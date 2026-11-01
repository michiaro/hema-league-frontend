#!/usr/bin/env bash
# Deploys a release artifact built by the Jenkinsfile.
#
# Usage: ./deploy.sh ARTIFACT sandbox|production
#
# The artifact is a tar.gz with the contents of `dist` and `nginx.conf` at its root.
# DEPLOY_HOST (user@host) and KNOWN_HOSTS (a known_hosts file with the server key) must be set,
# and an SSH agent must hold the deploy key. RELEASE_ID (YYYYMMDDHHMMSS, UTC) names the release
# directory; it defaults to the current time. Files of the release become readable for nginx (www-data).
#
# The vhost comes from nginx.conf of the release (written for the sandbox; production gets its ports and
# paths), and a vhost nginx rejects is rolled back together with the release. The sandbox (port 8000) and
# production (443) serve the same domain, so only nginx.conf of other projects must not name it.

set -Eeuo pipefail

artifact="${1:?Artifact path is required}"
environment="${2:?Environment (sandbox or production) is required}"
host="${DEPLOY_HOST:?DEPLOY_HOST is required}"
known_hosts="${KNOWN_HOSTS:?KNOWN_HOSTS must point to a known_hosts file with the server key}"

case "$environment" in
    sandbox) port=8000 ;;
    production) port=443 ;;
    *) echo "Environment must be sandbox or production" >&2; exit 2 ;;
esac

domain="hema-league.ru"
base_path="/var/www/${environment}/${domain}"
release_id="${RELEASE_ID:-$(date -u '+%Y%m%d%H%M%S')}"
if [[ ! "$release_id" =~ ^[0-9]{14}$ ]]; then
    echo "RELEASE_ID must have the UTC format YYYYMMDDHHMMSS" >&2
    exit 1
fi
release_path="${base_path}/releases/${release_id}"

remote() {
    ssh -o UserKnownHostsFile="$known_hosts" -o StrictHostKeyChecking=yes "$host" "$@"
}

tar -xzOf "$artifact" ./index.html > /dev/null

echo "==> Checking the server"

remote bash -s -- "$domain" <<'CHECK'
set -Eeuo pipefail
domain="$1"
# nginx includes the nginx.conf of every project: another project must not serve the domain.
others="$(grep -lE "server_name[^;]*[[:space:]](www\.)?${domain//./\\.}([[:space:];]|\$)" \
    /var/www/production/*/nginx.conf /var/www/sandbox/*/nginx.conf 2>/dev/null \
    | grep -vxF -e "/var/www/production/${domain}/nginx.conf" -e "/var/www/sandbox/${domain}/nginx.conf" || true)"
if [[ -n "$others" ]]; then
    echo "${domain} is still served by: ${others}" >&2
    exit 1
fi
CHECK

echo "==> Uploading release ${release_id} (${environment})"

# logs/ is shared with nginx; 2775 keeps it writable for the www-data group, as on the rest of the server.
remote "mkdir -p ${base_path}/releases \
    && install -d -m 2775 ${base_path}/logs \
    && mkdir ${release_path} \
    && tar -xzf - --no-same-owner -C ${release_path} \
    && chmod -R go+rX,go-w ${release_path}" < "$artifact"

echo "==> Activating release ${release_id}"

remote bash -s -- "$base_path" "$release_path" "$release_id" "$environment" "$domain" "$port" <<'REMOTE'
set -Eeuo pipefail
base_path="$1"
release="$2"
release_id="$3"
environment="$4"
domain="$5"
port="$6"

# nginx includes the config from the base path; it is not served from the release.
# The release's vhost is written for the sandbox.
if [[ "$environment" == production ]]; then
    sed -E -e 's/(listen (\[::\]:)?)8000([ ;])/\1443\3/' -e 's/(listen (\[::\]:)?)8080([ ;])/\180\3/' \
        -e 's:/var/www/sandbox/:/var/www/production/:g' "${release}/nginx.conf" > "${base_path}/nginx.conf.next"
    if grep -qE 'listen (\[::\]:)?80(00|80)[ ;]|/var/www/sandbox/' "${base_path}/nginx.conf.next"; then
        echo "nginx.conf of release ${release_id} still has sandbox ports or paths" >&2
        exit 1
    fi
else
    cp "${release}/nginx.conf" "${base_path}/nginx.conf.next"
fi
rm -f "${release}/nginx.conf"

previous_release=""
if [[ -L "${base_path}/current" ]]; then
    previous_release="$(readlink "${base_path}/current")"
fi
had_conf=false
if [[ -f "${base_path}/nginx.conf" ]]; then
    cp -p "${base_path}/nginx.conf" "${base_path}/nginx.conf.previous"
    had_conf=true
fi

rollback() {
    if $had_conf; then
        mv -f "${base_path}/nginx.conf.previous" "${base_path}/nginx.conf"
    else
        rm -f "${base_path}/nginx.conf"
    fi
    if [[ -n "$previous_release" ]]; then
        ln -sfn "$previous_release" "${base_path}/current.next"
        mv -Tf "${base_path}/current.next" "${base_path}/current"
    else
        rm -f "${base_path}/current"
    fi
    sudo /usr/sbin/nginx -t && sudo /usr/sbin/service nginx reload
}

# Switch atomically: rename(2) replaces the link, so `current` never disappears.
ln -sfn "$release" "${base_path}/current.next"
mv -Tf "${base_path}/current.next" "${base_path}/current"

# Full paths, exactly as /etc/sudoers.d/deploy allows them.
mv -f "${base_path}/nginx.conf.next" "${base_path}/nginx.conf"
if ! sudo /usr/sbin/nginx -t; then
    rollback || true
    echo "nginx rejected the configuration of release ${release_id}; the previous release is active" >&2
    exit 1
fi
# The server is shared, so the configuration is reloaded, not restarted.
sudo /usr/sbin/service nginx reload

# The page itself, not the certificate: a renewal problem must not undo a release.
if ! curl -sfk -o /dev/null --retry 5 --retry-all-errors --retry-delay 1 \
        --resolve "${domain}:${port}:127.0.0.1" "https://${domain}:${port}/"; then
    rollback || true
    echo "https://${domain}:${port}/ does not answer with release ${release_id}; the previous release is active" >&2
    exit 1
fi

# Keep the previous releases for a quick rollback.
find "${base_path}/releases" -mindepth 1 -maxdepth 1 -type d -name '[0-9]*' | sort -r | tail -n +4 | xargs -r rm -rf
REMOTE

echo "==> ${environment} now runs release ${release_id}"

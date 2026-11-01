/*
 * Every branch and tag type-checks and builds one release artifact. A branch deploys it to the sandbox
 * (https://hema-league.ru:8000), a version tag (2026.01.14, v1.2.3-2) to production.
 *
 * Requires the Docker Pipeline, Lockable Resources, SSH Agent, Credentials Binding, Git and Workspace
 * Cleanup plugins, an agent with Docker and the tag build strategy of Basic Branch Build Strategies.
 */

// Runs build and deployment commands with Node.js, Yarn and SSH.
def insideCi(Closure body) {
  docker.image('cimmwolf/vistro:3').inside('-u root:root') {
    try {
      body()
    } finally {
      // Files created by root must stay removable by the Jenkins agent.
      sh 'chown -R "$(stat -c %u:%g .)" .'
    }
  }
}

def isProductionTag() {
  return env.TAG_NAME && env.TAG_NAME ==~ /v?\d+\.\d+\.\d+.*/
}

// Uploads the stashed artifact with deploy.sh to the sandbox or production.
def deployTo(String environment) {
  unstash 'artifact'
  lock("hema-league-${environment}") {
    def releaseId = sh(returnStdout: true, script: "date -u '+%Y%m%d%H%M%S'").trim()
    withEnv(["RELEASE_ID=${releaseId}"]) {
      insideCi {
        sshagent(credentials: [env.SSH_CREDENTIALS]) {
          withCredentials([file(credentialsId: env.KNOWN_HOSTS_CREDENTIALS, variable: 'KNOWN_HOSTS')]) {
            sh "./deploy.sh \"\$ARTIFACT\" ${environment}"
          }
        }
      }
    }
    currentBuild.description = "${currentBuild.description} → ${environment} ${releaseId}"
  }
}

pipeline {
  agent none
  options {
    buildDiscarder(logRotator(numToKeepStr: '30'))
  }
  environment {
    // vistro-26 (Hosts/Vistro/bootstrap.sh), shared with eco74.com, CRM_GF, BPM and DSystem.
    DEPLOY_HOST             = 'deploy@45.66.118.106'
    SSH_CREDENTIALS         = 'c98cafdc-9af0-4637-b970-6cc7f2305852'
    // Secret file with the known_hosts line of the server's ED25519 key.
    KNOWN_HOSTS_CREDENTIALS = 'dsystem-known-hosts'
    ARTIFACT                = 'hema-league.ru.tar.gz'
  }
  stages {
    stage('Build') {
      agent any
      stages {
        stage('Test') {
          steps {
            insideCi {
              sh 'yarn install --frozen-lockfile --non-interactive'
              // ESLint is not run yet: the code does not pass it.
              sh 'yarn type-check'
            }
          }
        }
        stage('Package') {
          steps {
            script {
              currentBuild.description = env.GIT_COMMIT.take(8)
            }
            insideCi {
              sh 'yarn build-only'
              // The root of the archive becomes the release directory, which nginx must be able to read.
              sh '''
                cp nginx.conf dist/nginx.conf
                chmod 755 dist
                tar -czf "$ARTIFACT" -C dist .
              '''
            }
            stash name: 'artifact', includes: env.ARTIFACT
          }
        }
      }
      post {
        always {
          cleanWs()
        }
      }
    }
    stage('Sandbox') {
      when {
        // Decide before an agent and a checkout are taken for nothing.
        beforeAgent true
        expression { !env.CHANGE_ID && !env.TAG_NAME }
      }
      agent any
      steps {
        deployTo('sandbox')
      }
      post {
        always {
          cleanWs()
        }
      }
    }
    stage('Production') {
      when {
        beforeAgent true
        expression { isProductionTag() }
      }
      agent any
      steps {
        deployTo('production')
      }
      post {
        always {
          cleanWs()
        }
      }
    }
  }
}

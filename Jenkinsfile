pipeline {
  agent {
    docker {
      image 'cimmwolf/vistro:3'
      args '-u root:root'
    }
  }
  environment {
    BuildEnv      = "${env.TAG_NAME && env.TAG_NAME ==~ /v?\d+\.\d+\.\d+.*/ ? "production" : "sandbox"}"
    ServerIp      = "78.155.197.111"
    BasePath      = "/var/www/${BuildEnv}/hema-league.ru"
    RemoteMachine = "deploy@${ServerIp}"
    ReleaseDate   = """${sh(
                            returnStdout: true,
                            script: 'echo $(date "+%Y%m%d%H%M%S")'
                        ).trim()}"""
    ReleasePath   = "${BasePath}/releases/${ReleaseDate}"
  }
  stages {
    stage('Build') {
      steps {
        sh 'mkdir ~/.ssh && ssh-keyscan ${ServerIp} >> ~/.ssh/known_hosts'
        sh 'yarn build'
      }
    }
    stage('Prepare for prod') {
      when {
        environment name: 'BuildEnv', value: 'production'
      }
      steps {
        sh 'sed -i -e "s/listen 8000/listen 443/g" nginx.conf'
        sh 'sed -i -e "s/listen 8080/listen 80/g" nginx.conf'
        sh 'sed -i -e "s:/sandbox/:/production/:g" nginx.conf'
      }
    }
    stage('Deploy') {
      steps {
        sshagent(credentials: ['c98cafdc-9af0-4637-b970-6cc7f2305852']) {
          sh "ssh $RemoteMachine mkdir -p ${BasePath}/releases ${BasePath}/logs ${BasePath}/shared"

          sh "rsync -rlzv --delete --link-dest=${BasePath}/current ./dist/ ${RemoteMachine}:${ReleasePath}"
          sh "scp nginx.conf ${RemoteMachine}:${BasePath}"
        }
      }
    }
    stage('Clean & restart') {
      steps {
        sshagent(credentials: ['c98cafdc-9af0-4637-b970-6cc7f2305852']) {
          sh "ssh $RemoteMachine ln -vfn -s ${ReleasePath} ${BasePath}/current"
          sh "ssh $RemoteMachine 'cd ${BasePath}/releases && ls -1r | tail -n +2 | xargs rm -rf'"
          sh "ssh $RemoteMachine 'sudo nginx -t && sudo service nginx restart'"
        }
      }
    }
  }
  post {
    always {
      sh "chown -R ${JENKINS_UID}:${JENKINS_GID} ./"
      cleanWs()
    }
  }
}

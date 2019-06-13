pipeline {
    agent {
        label "docker-agent"
    }
    environment {
       POMVERSION = readMavenPom().getVersion();
    }
    stages {
        stage('Configure') {
            steps {
                script {
                    if(env.BRANCH_NAME == "master") {
                        env.DEPLOY = "deploy"
                    } else if (env.BRANCH_NAME == "development") {
                        env.DEPLOY = "deploy"
                    } else {
                        env.DEPLOY = ""
                    }
                }
            }
        }
        stage('Maven Build') {
            agent {
                dockerfile {
                    dir 'build'
                }
            }
            steps {
                withMaven(maven: 'mvn3.5.2', mavenSettingsConfig: 'phx-maven', mavenLocalRepo: '.repository') {
                    sh '''export PATH=$MVN_CMD_DIR:$PATH && mvn -X -U -DskipTests clean package ${DEPLOY}'''
                }
                stash(name: 'target', includes: 'target/**/*.jar')
            }
        }
        stage('DD agent download') {
          steps {
            sh '''wget -O dd-java-agent.jar 'https://search.maven.org/classic/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST' '''
          }
        }
        stage('Build Image') {
          steps {
              unstash 'target'
              script {
                  image = docker.build("gcr.io/dauntless-141219/bigtable-autoscaler", "--build-arg VERSION=${POMVERSION} .")
              }
          }
      }
        stage('Push Image') {
            when {
                anyOf {
                    branch "master"
                    branch "development"
                }
            }
            steps {
                script {
                    docker.withRegistry('https://gcr.io', 'gcr:Cloud_Storage') {
                        image.push("${POMVERSION}")
                    }
                }
            }
        }
    }
}

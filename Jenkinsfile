pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential = 'loseva-dockerhub'
      IMAGE_NAME = "www123vika123/epam" + "-${GIT_BRANCH.split("/")[1]}"
      REPO_NAME = "${GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')}" + "-${GIT_BRANCH.split("/")[1]}"
      EXTERNAL_PORT = 10005
      EXTERNAL_ADDRESS = '192.168.0.102'
    }
    options {
      parallelsAlwaysFailFast()
    }

    stages {

        stage('Checkout code') { 
            steps {
                checkout scm
                script {
                    sh "ls -al && pwd"
                }
            }
            
        }   

        stage('Build') { 
            steps {
                script{
                    image = docker.build("${env.IMAGE_NAME}")
                }
            }
        }

        stage('Run unittests') {
            steps {
                script {
                    docker.image("${env.IMAGE_NAME}").withRun {c ->
                    docker.image("${env.IMAGE_NAME}").inside{
                          sh "coverage run -m pytest"
                          sh "coverage report"
                        }
                    }
                }
            }
        }                                                                           

        stage('Push') { 
            steps {
                script {
                docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    image.push()
                    image.push("${env.BUILD_NUMBER}")
                    image.push("latest")
                    }
                }
            }
        }
    }
    post {
        always {
           sh "docker rmi $IMAGE_NAME" 
           cleanWs cleanWhenNotBuilt: true, notFailBuild: true
        }
        success {
           build job: 'ansible_deploy_web', parameters: [string(name: 'CONTAINER_NAME', value: "${env.REPO_NAME}"),
                                                        string(name: 'IMAGE_NAME', value: "${env.IMAGE_NAME}"),
                                                        string(name: 'EXTERNAL_PORT', value: "${env.EXTERNAL_PORT}"),
                                                        string(name: 'EXTERNAL_ADDRESS', value: "${env.EXTERNAL_ADDRESS}"),
                                                        ]
        }
    }
}      


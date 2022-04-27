pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential = 'loseva-dockerhub'
      IMAGE_NAME = "www123vika123/epam" + "-${GIT_BRANCH.split("/")[1]}"
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
        stage('Cleaning up') {
            steps{
                script {
                    sh "docker rmi $IMAGE_NAME"
                    cleanWs cleanWhenNotBuilt: false, notFailBuild: true
                }
            }   
        }    
    }
}        


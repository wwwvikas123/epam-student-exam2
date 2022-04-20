pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential = 'loseva-dockerhub'
      IMAGE_MANE = 'www123vika123/epam'
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
                    image = docker.build("${env.IMAGE_MANE}")
                }
            }
        }

//
        stage('Run unittests') {
            steps {
                script {
                    image.inside {
                        sh "python3.9 pip install --no-cache-dir -e '.[test]' --user api"
                        sh "coverage run -m pytest"
                        sh "coverage report"
                    }
                }
            }
        }                                                                           

        stage('Push') { 
            steps {
                script {
                    docker.withRegistry( '', registryCredential )
                    image.push("${env.BUILD_NUMBER}")
                    image.push("latest")
                }
            }
        }
        stage('Cleaning up') {
            steps{
                script {
                    sh "docker rmi $image"
                }
            }
        }    
    }
}        


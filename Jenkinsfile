pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential = 'loseva-dockerhub'
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
                                         
        stage('Run unittests') {
            steps {
                script {
                    image.inside {
                        sh "pip install -e '.[test]'"
                        sh "coverage run -m pytest"
                        sh "coverage report"
                    }
                }
            }
        }                                                                           
        stage('Build') { 
            steps {
                script{
                    image = docker.build("www123vika123/epam:latest")
                }
            }
        }
        stage('Push') { 
            steps {
                script{
                docker.withRegistry( '', registryCredential )
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
                }
            }
        }
    }        
}

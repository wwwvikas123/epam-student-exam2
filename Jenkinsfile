pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential = 'loseva-dockerhub'
      IMAGE_NAME = "www123vika123/epam"
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

   //     stage('BuildInside') {
   //         steps {
   //             script {
   //                 docker.image("${env.IMAGE_MANE}").withRun {c ->
   //                     docker.image("${env.IMAGE_MANE}").inside{
   //                     
   //                                 sh "ls -al && pwd && virtualenv .venv && pip install --no-cache-dir -e '.[test]' --user api"
   //                     }
   //                 }
   //             }
   //         }
   //     }
        stage('Run unittests') {
            steps {
                script {
               //     image.inside {
                          docker.image("${env.IMAGE_MANE}").withRun {c ->
                         sh "/bin/bash /usr/src/app/tests.sh"
                      //  sh "coverage run -m pytest"
                      //  sh "coverage report"
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
                }
            }
        }    
    }
}        


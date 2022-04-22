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

        stage('BuildInside') {
            steps {
                script {
                    docker.image("${env.IMAGE_MANE}").withRun {c ->
                        docker.image("${env.IMAGE_MANE}").inside{
                        
                                    sh "pip install --no-cache-dir -e '.[test]' --user api"
                        }
                    }
                }
            }
        }
//        stage('Run unittests') {
//            steps {
//                script {
//               //     image.inside {
//                          docker.image("${env.IMAGE_MANE}").withRun {c ->
//                         sh "pip install --no-cache-dir -e '.[test]'"
//                      //  sh "coverage run -m pytest"
//                      //  sh "coverage report"
//                    }
//                }
//            }
//        }                                                                           

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


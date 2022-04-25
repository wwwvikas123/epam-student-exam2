pipeline {
agent {
  label 'unittest'
}
environment {
      registryCredential=credentials('loseva-dockerhub')
      IMAGE_MANE='www123vika123/epam'
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
                    image = docker.build("${env.IMAGE_MANE}" + ":$BUILD_NUMBER")
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

//        stage('Login') {
//
//			steps {
//				sh 'echo $registryCredential | docker login -u $registryCredential --password-stdin'
//			}
//		}


        stage('Push') { 
            steps {
                script {
                docker.withRegistry('', registryCredential) {
                    image.push()
                //    docker.withRegistry('https://registry.hub.docker.com', registryCredential )
                    image.push("${env.BUILD_NUMBER}")
                    image.push("latest")
                    }
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


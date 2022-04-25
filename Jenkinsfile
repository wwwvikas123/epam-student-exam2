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

        stage('Docker build') {
            steps { 
                script {
                echo ">>>>>>>>>> Start Image build <<<<<<<<<<<"
                 DocImage=docker.build("www123vika123/epam" + ":$BUILD_NUMBER")
                }
            }
        }
        stage('Docker push') {
            steps { 
                script {
                echo ">>>>>>>>>>!! Start Image push !!<<<<<<<<<<<"
                docker.withRegistry('', registryCredential) {
                    DocImage.push()
                    DocImage.push('latest')
                }
            }
        } 
        }
    }
}     


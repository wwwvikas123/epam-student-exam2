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
                git describe --always
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
                                          
                                          
      //  stage('Publish reports') { 
      //      steps {
      //          cobertura  (
      //          onlyStable: false,
      //          enableNewApi: true,
      //          failUnhealthy: false,
      //          failUnstable: false,
      //          autoUpdateHealth: false,
      //          autoUpdateStability: false,
      //          zoomCoverageChart: false,
      //          maxNumberOfBuilds: 0,
      //          sourceEncoding: 'ASCII',
      //          coberturaReportFile: 'report/coverage.xml',
      //          lineCoverageTargets: '80, 0, 0',
      //          methodCoverageTargets: '80, 0, 0',
      //          conditionalCoverageTargets: '70, 0, 0'
      //          )
      //      }
      //  }
        stage('Build') { 
            steps {
                script{
                    image = docker.build("www123vika123/epam:latest)
                }
            }
        }
        stage('Push') { 
            steps {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
            }
        }
    }        
}

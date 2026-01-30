pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        SONAR_SCANNER_HOME = tool 'sonar-scanner'
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_IMAGE = "ayush1406/devsecops-app:${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                      mvn sonar:sonar \
                      -Dsonar.projectKey=devsecops-app \
                      -Dsonar.projectName=devsecops-app
                    '''
                }
            }
        }

        
stage('Quality Gate') {
    steps {
        timeout(time: 10, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
  stage('OWASP Dependency Check') {
    steps {
        dependencyCheck additionalArguments: '--scan .',
                        odcInstallation: 'OWASP-DC'
        dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
    }
}

stage('Docker Build') {
    steps {
        sh 'docker build -t $DOCKER_IMAGE .'
    }
}

// stage('Trivy Image Scan') {
//     steps {
//         sh '''
//           trivy image \
//           --severity HIGH,CRITICAL \
//           --exit-code 1 \
//           $DOCKER_IMAGE
//         '''
//     }
// }

stage('Docker Push') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
            sh '''
              echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
              docker push $DOCKER_IMAGE
            '''
        }
    }
}

stage('Deploy to EKS using Helm') {
    steps {
        script {
            try {
                sh '''
                  helm upgrade --install devsecops devsecops-chart \
                  --set image.repository=dockerhubusername/devsecops-app \
                  --set image.tag=${IMAGE_TAG}
                '''
            } catch (Exception e) {
                sh 'helm rollback devsecops'
                error "Deployment failed. Rolled back to previous release."
            }
        }
    }
}

    }
}

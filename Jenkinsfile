pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        SONAR_SCANNER_HOME = tool 'sonar-scanner'
        DOCKER_IMAGE = "ayush1406/devsecops-app:latest"
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
    }
}

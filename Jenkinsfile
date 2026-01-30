pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        SONAR_SCANNER_HOME = tool 'sonar-scanner'
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
    }
}

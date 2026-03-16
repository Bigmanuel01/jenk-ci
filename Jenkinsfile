pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-frontend-app"
        IMAGE_TAG = "latest"
        SONARQUBE_ENV = "SonarQube"
    }

    stages {
        stage('Build Code') {
            steps {
                echo 'Building code...'
                bat '''
                    if exist package.json (
                        call npm install
                        call npm run build
                    ) else (
                        echo No package.json found, treating as static project.
                    )
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    bat '''
                        sonar-scanner ^
                          -Dsonar.projectKey=my-frontend-app ^
                          -Dsonar.projectName=my-frontend-app ^
                          -Dsonar.sources=. ^
                          -Dsonar.exclusions=vendor/**,assets/** ^
                          -Dsonar.host.url=%SONAR_HOST_URL% ^
                          -Dsonar.login=%SONAR_AUTH_TOKEN%
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'deploying...'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
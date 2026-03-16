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
                sh '''
                    if [ -f package.json ]; then
                        npm install
                        npm run build || echo "No build script found, skipping..."
                    else
                        echo "No package.json found, treating as static project."
                    fi
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh '''
                        sonar-scanner \
                          -Dsonar.projectKey=my-frontend-app \
                          -Dsonar.projectName=my-frontend-app \
                          -Dsonar.sources=. \
                          -Dsonar.exclusions=vendor/**,assets/** \
                          -Dsonar.host.url=$SONAR_HOST_URL \
                          -Dsonar.login=$SONAR_AUTH_TOKEN
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
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
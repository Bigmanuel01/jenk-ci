pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-frontend-app"
        IMAGE_TAG = "latest"
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

        stage('SonarQube Analysis (Optional)') {
            steps {
                echo 'Running SonarQube analysis...'
                bat '''
                    if exist sonar-project.properties (
                        call sonar-scanner
                    ) else (
                        echo No sonar-project.properties found, skipping analysis.
                    )
                '''
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
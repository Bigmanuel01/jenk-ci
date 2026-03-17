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
                sh '''
                    if [ -f package.json ]; then
                        npm install
                        npm run build || echo "No build script found"
                    else
                        echo "No package.json found, treating as static project."
                    fi
                '''
            }
        }

        stage('SonarQube Analysis (Optional)') {
            steps {
                echo 'Running SonarQube analysis...'
                sh '''
                    if [ -f sonar-project.properties ]; then
                        sonar-scanner
                    else
                        echo "No sonar-project.properties found, skipping analysis."
                    fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
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
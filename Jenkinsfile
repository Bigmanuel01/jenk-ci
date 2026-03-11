pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // This pulls your LEKAN-KUNLE project from GitHub
                checkout scm
            }
        }

        stage('Lint & Validate') {
            steps {
                echo 'Checking HTML and CSS for errors...'
                // If you use tools like stylelint or htmlhint, run them here:
                // sh 'npx htmlhint index.html'
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Bundling files for deployment...'
                // This saves your files so they can be downloaded from Jenkins
                archiveArtifacts artifacts: 'index.html, style.css, index.js, assets/**', fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to Web Server...'
                // Example: Copying files to a local web server directory
                // sh 'cp -R . /var/www/html/my-site'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
        success {
            echo 'Deployment successful. Your site is live.'
        }
        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}
pipeline {
    agent any

    stages {

        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t html-app:v1 .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop html-app || true
                docker rm html-app || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d --name html-app -p 5002:80 html-app:v1'
            }
        }
    }

    post {
        success {
            echo '✅ Jenkins Pipeline executed successfully'
        }
        failure {
            echo '❌ Jenkins Pipeline failed'
        }
    }
}

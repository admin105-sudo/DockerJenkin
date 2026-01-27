pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        EC2_IP = "44.198.56.239"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/admin105-sudo/web-api-ai-docker-.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp:latest .'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@${EC2_IP} '
                    docker stop myapp || true
                    docker rm myapp || true
                    docker run -d -p 80:80 --name myapp myapp:latest
                    '
                    """
                }
            }
        }
    }
}

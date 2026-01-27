pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        EC2_IP = "98.82.17.19"
        IMAGE = "dockerhubusername/myapp:latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} '
                    docker pull $IMAGE
                    docker stop myapp || true
                    docker rm myapp || true
                    docker run -d -p 80:80 --name myapp $IMAGE
                    '
                    """
                }
            }
        }
    }
}

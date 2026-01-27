pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        EC2_IP = "98.86.171.127"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} '
                    if [ ! -d app ]; then
                        git clone https://github.com/admin105-sudo/DockerJenkin.git app
                    fi
                    cd app
                    git pull
                    docker stop myapp || true
                    docker rm myapp || true
                    docker build -t myapp .
                    docker run -d -p 80:80 --name myapp myapp
                    '
                    """
                }
            }
        }
    }
}

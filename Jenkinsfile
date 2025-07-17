pipeline {
    agent any

    environment {
        IMAGE_NAME = 'cloudblade-barista'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/shadow846/Cloudblade-WebOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                docker run --rm \
                  -v /var/run/docker.sock:/var/run/docker.sock \
                  -v \$PWD:/workspace \
                  custom-jenkins:k8s \
                  sh -c 'kubectl apply -f /workspace/k8s-deployment.yaml'
                """
            }
        }
    }
}


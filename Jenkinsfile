pipeline {
    agent any

    environment {
        IMAGE_NAME = 'cloudblade-barista'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git credentialsId: 'github-https', url: 'https://github.com/shadow846/Cloudblade-WebOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Build custom Jenkins image') {
            steps {
                sh 'docker build -t custom-jenkins:k8s -f Dockerfile.jenkins .'
            }
        }

        stage('Deploy to Kubernetes') {
    steps {
        sh '''
            docker run --rm \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v $(pwd):/workspace \
                custom-jenkins:k8s sh -c "
                    echo '📂 Listing files in /workspace:' && ls -l /workspace &&
                    kubectl apply -f /workspace/k8s-deployment.yaml
                "
        '''
    }
}


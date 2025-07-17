pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'cloudblade-barista:latest'
        CUSTOM_JENKINS_IMAGE = 'custom-jenkins:k8s'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git(
                    url: 'https://github.com/shadow846/Cloudblade-WebOps.git',
                    branch: 'master',
                    credentialsId: 'github-https'
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Build custom Jenkins image') {
            steps {
                sh 'docker build -t ${CUSTOM_JENKINS_IMAGE} -f Dockerfile.jenkins .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    docker run --rm \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        -v $(pwd):/workspace \
                        ${CUSTOM_JENKINS_IMAGE} sh -c "
                            echo '📂 Listing files in /workspace:' && ls -l /workspace &&
                            kubectl apply -f /workspace/k8s-deployment.yaml
                        "
                '''
            }
        }
    }
}


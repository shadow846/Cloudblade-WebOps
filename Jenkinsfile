pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'cloudblade-barista:latest'
        CUSTOM_JENKINS_IMAGE = 'custom-jenkins:k8s'
        DEPLOY_PATH = '/home/jenkins/workspace'   // inside container
    }

    stages {
        stage('Clone Repo') {
            steps {
                git credentialsId: 'github-https', url: 'https://github.com/shadow846/Cloudblade-WebOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    set -ex
                    echo "🛠 Building site Docker image..."
                    docker build -t ${DOCKER_IMAGE} .
                '''
            }
        }

        stage('Build custom Jenkins image with kubectl') {
            steps {
                sh '''
                    set -ex
                    echo "🧰 Building custom Jenkins image (includes kubectl)..."
                    docker build -t ${CUSTOM_JENKINS_IMAGE} -f Dockerfile.jenkins .
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    set -ex
                    echo "📦 Mounting workspace: ${WORKSPACE} -> ${DEPLOY_PATH}"
                    docker run --rm \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        -v ${WORKSPACE}:${DEPLOY_PATH} \
                        ${CUSTOM_JENKINS_IMAGE} sh -c '
                            set -ex
                            echo "📂 Files inside ${DEPLOY_PATH}:"
                            ls -la ${DEPLOY_PATH}
                            echo "🚀 Deploying to Kubernetes..."
                            kubectl apply -f ${DEPLOY_PATH}/k8s-deployment.yaml
                        '
                '''
            }
        }
    }

    post {
        failure {
            echo "❌ Deployment failed! Check logs above."
        }
        success {
            echo "✅ Deployment completed successfully!"
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'your-credential-id', url: 'https://github.com/shadow846/Cloudblade-WebOps.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('cloudblade-barista')
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    docker.image('cloudblade-barista').run('-d -p 8080:80')
                }
            }
        }
    }
}

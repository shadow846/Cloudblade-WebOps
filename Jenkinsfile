pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/shadow846/Cloudblade-WebOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t cloudblade-barista:latest .'
            }
        }

        // Skipping minikube image load (Jenkins container can't run this)
        // stage('Load Image into Minikube') {
        //     steps {
        //         sh 'minikube image load cloudblade-barista:latest'
        //     }
        // }

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


pipeline {
    agent any 
    stages {
        stage('Checkout SCM') {
            steps {  
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/muhammadhur2/kubernetes-tutorial.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "muhammadhur/tutorial:${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    def imageName = "muhammadhur/tutorial:${env.BUILD_NUMBER}"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                        sh "docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS docker.io"
                    }
                    sh "docker push ${imageName}"
                    sh "docker logout"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Update the image in the deployment YAML file
                    def imageName = "muhammadhur/tutorial:${env.BUILD_NUMBER}"
                    sh "sed -i 's|muhammadhur/tutorial:latest|${imageName}|' ./deployment.yaml"
                    // Apply the deployment
                    withCredentials([file(credentialsId: 'kube', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f ./deployment.yaml'
}
                }
            }
        }
    }
}
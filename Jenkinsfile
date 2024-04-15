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
                    // Define the image name and tag, typically using the Jenkins build number or other unique identifiers
                    def imageName = "muhammadhur/tutorial:${env.BUILD_NUMBER}"
                    // Build the Docker image
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    def imageName = "muhammadhur/tutorial:${env.BUILD_NUMBER}"
                    // Login to DockerHub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                        sh "docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS docker.io"
                    }
                    // Push the image
                    sh "docker push ${imageName}"
                    // Logout from DockerHub to secure the session
                    sh "docker logout"
                }
            }
        }
    }
}
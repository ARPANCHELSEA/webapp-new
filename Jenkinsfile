pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'yourdockerhubusername/devops-app:latest'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Scan') {
            steps {
                sh 'trivy image $DOCKER_IMAGE'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'helm upgrade --install flask-app ./helm-chart --namespace default --create-namespace'
            }
        }
    }
}
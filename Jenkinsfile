pipeline {
    agent any
    environment {
        IMAGE_NAME = "moezog/my-app"
        TAG = "${BUILD_NUMBER}"
    }
    tools {
        maven 'Maven 3.9.0' // le nom que tu as donné dans Jenkins
    }

    stages {

        stage('Build Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${TAG} .'
                sh 'docker tag ${IMAGE_NAME}:${TAG} ${IMAGE_NAME}:latest'
 
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
            credentialsId: 'first_jenkin',  // ← l'ID que tu as créé
            usernameVariable: 'DOCKER_USER', // ← Jenkins met 'moezog' ici
            passwordVariable: 'DOCKER_PASS'
                )]) {                                          // ✅ accolade ouvrante
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${IMAGE_NAME}:${TAG}'
                    sh 'docker push ${IMAGE_NAME}:latest'
                }                                             // ✅ accolade fermante
            }
        }
    }

    post {
        success {
            echo "Build successful! Image pushed as ${IMAGE_NAME}:${TAG}"
        }
    }

}
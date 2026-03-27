pipeline {
    agent any
    tools {
        maven 'Maven 3.9.0' // le nom que tu as donné dans Jenkins
    }

    stages {
        stage('Clean') {
            steps {
                deleteDir()   // 🔥 supprime workspace
            }
        }
        stage('Build Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t moezog/my-app:1.0 .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
            credentialsId: 'first_jenkins',  // ← l'ID que tu as créé
            usernameVariable: 'DOCKER_USER', // ← Jenkins met 'moezog' ici
            passwordVariable: 'DOCKER_PASS'
                )]) {                                          // ✅ accolade ouvrante
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push moezog/my-app:1.0'
                }                                             // ✅ accolade fermante
            }
        }
    }
}
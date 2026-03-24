pipeline {
    agent any // On utilise l'agent Jenkins normal

    stages {
        stage('Build Maven') {
            steps {
                // On télécharge et utilise Maven juste pour cette commande
                sh  'mvn clean package'            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t moezog/my-app:1.0 .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push moezog/my-app:1.0'
            }
        }
    }
}
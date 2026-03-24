pipeline {
    agent any

    stages {
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
                    credentialsId: 'first_jenkins',
                    usernameVariable: 'moezog',
                    passwordVariable: 'Sankou72003'
                )]) {                                          // ✅ accolade ouvrante
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push moezog/my-app:1.0'
                }                                             // ✅ accolade fermante
            }
        }
    }
}
pipeline {
    agent  any
    tools {
        maven 'Maven-3'
    }
    stages {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-app:1.0 .'
            }
        }

        stage('Tag Image') {
            steps {
                sh 'docker tag my-app:1.0 moezog/my-app:1.0'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push moezog/my-app:1.0'
            }
        }
    }
}
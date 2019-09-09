pipeline {
    agent any
    stages {
        stage('image') {
            steps {
                sh 'make build'
            }
        }
        stage('deploy') {
            steps {
                sh 'make deploy'
            }
        }
    }
}


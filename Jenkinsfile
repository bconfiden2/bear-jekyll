pipeline {
    environment {
        dockerImage = ''
    }
    
    agent any
    stages {
        stage('Git clone') {
            steps {
                git([url: 'https://github.com/bconfiden2/bear-jenkins.git', branch: 'main', credentialsId: 'credential-id'])
            }
        }
        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build "bconfiden2/tmp"
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub') {
                        dockerImage.push("1.0")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}

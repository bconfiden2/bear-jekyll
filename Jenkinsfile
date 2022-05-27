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
                    }
                }
            }
        }
        stage('Git push') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([usernamePassword(credentialsId: 'credential-id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh 'echo "$USERNAME"'
                            sh 'echo "$PASSWORD"'
                            sh 'echo 1 >> webhook'
                            sh 'git add webhook'
                            sh 'git commit -am "commit msg - from pipeline"'
                            sh 'git push'
                        }
                    }
                }
            }
        }
    }
}

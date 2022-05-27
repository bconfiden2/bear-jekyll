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
                        withCredentials([usernamePassword(credentialsId: 'amazon', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            echo $USERNAME
                            echo $PASSWORD
                            echo 1 >> webhook
                            git add webhook
                            git commit -am "commit msg - from pipeline"
                            git push
                        }
                    }
                }
            }
        }
    }
}

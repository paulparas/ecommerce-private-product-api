properties([pipelineTriggers([githubPush()])])
pipeline {
    agent any
    
    triggers {
        pollSCM '* * * * *'
    }
    
    stages {
        
        stage('Checkout'){
            steps{
                checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/paulparas/private-microservice-1.git']], branches: [[name: 'refs/heads/main']]], poll: true
            }
        }
        
        stage('Slack Notify Start'){
            steps{
                wrap([$class: 'BuildUser']) {
                    slackSend (color: '#FFFF00', message: """STARTED: Job '${env.JOB_NAME} - #${env.BUILD_NUMBER}'  by ${BUILD_USER} (${BUILD_URL})""")
        }
                
            }
        }
        stage('Approval'){
            steps{
                script{
                    wrap([$class: 'BuildUser']) {
                    slackSend (color: '#D4DADF', message: """Approval Pending: ${BUILD_URL}input""")
        }
            def userName = input message: 'Deploy?', submitterParameter: 'USER'
            slackSend (color: '#00FF00', message: """Approved  by ${userName}""")
                }
                
        
            }
        }
        stage('Hello') {
            steps{
                echo 'Hello World'
            }
                            
                
            }
        }
    post {
        success {
            slackSend (color: '#00FF00', message: """SUCCESSFUL: Job '${env.JOB_NAME} - #${env.BUILD_NUMBER}' after ${currentBuild.durationString.replace(' and counting', '')}""")
        }
        failure {
            slackSend (color: '#FF0000', message: """FAILED: Job '${env.JOB_NAME} - #${env.BUILD_NUMBER}' after ${currentBuild.durationString.replace(' and counting', '')}""")
        }
        aborted{
            slackSend (color: '#FF0000', message: """ABORTED: Job '${env.JOB_NAME} - #${env.BUILD_NUMBER}' after ${currentBuild.durationString.replace(' and counting', '')}""")
        }
    }
}

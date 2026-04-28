#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
        [$class: 'GitSCMSource',
         remote: 'https://github.com/MrEfosa/jenkins-shared-library.git',
         credentialsId: 'github-credentials'
        ]
)


def gv

pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }

    stages {
        stage('increment version') {
            steps {
                script {
                    def version = incrementVersion()
                    echo "New version is ${version}"
                    echo "Image name is ${env.IMAGE_NAME}"
                }
                  
            }
        }

        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }

        stage("test app") {
            steps {
                script {
                    echo "testing app"
                }
            }
        }
        
        stage("build jar") {
            steps {
                script {
                    echo "building the application for ${env.BRANCH_NAME} branch..."
                    buildJar()
                }
            }
        }
        
        stage("build and push image") {
            steps {
                script {
                    echo "building and pushing the image for ${env.BRANCH_NAME} branch"
                    buildImage("sirdavidchris/java-maven-app:${IMAGE_NAME}")
                    dockerLogin()
                    dockerPush("sirdavidchris/java-maven-app:${IMAGE_NAME}")
                }
            }
        }
    
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying the application to EC2 server..."
                    def dockerComposeCmd = "docker-compose -f /home/ec2-user/docker-compose.yaml up --detach"
                    sshagent(['ec2-server-key']) {
                        sh "scp docker-compose.yaml ec2-user@100.52.234.62:/home/ec2-user/"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@100.52.234.62 '${dockerComposeCmd}'"
                    }
                }
            }
        }

        stage('Commit Version Update') {
            steps {
                script {
                    gitCommitAndPush([
                        repoUrl: 'https://github.com/MrEfosa/java-maven-app.git',
                        branch: 'feature/shared-library-integration',
                    ])
                }
            }
        }
    }
}

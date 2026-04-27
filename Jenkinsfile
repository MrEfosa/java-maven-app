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
                    echo "building the application for ${env.BRANCH_NAME} branch"
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
                sshagent(['ec2-server-key']) {
                    script {
                        def dockerCmd = "docker run -d -p 8080:8080 sirdavidchris/java-maven-app:1.1.4-2"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@100.52.234.62 '${dockerCmd}'"
                    }
                }
            }
        }

        stage('Commit Version Update') {
            steps {
                script {
                    gitCommitAndPush([
                        repoUrl: 'https://github.com/MrEfosa/java-maven-app.git',
                    ])
                }
            }
        }
    }
}

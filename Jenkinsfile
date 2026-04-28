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
                    buildImage("sirdavidchris/java-maven-app:${env.IMAGE_NAME}")
                    dockerLogin()
                    dockerPush("sirdavidchris/java-maven-app:${env.IMAGE_NAME}")
                }
            }
        }
    
        stage('Deploy') {
            steps {
                deployToEc2(
                    imageName: env.IMAGE_NAME,
                    ec2Instance: "ec2-user@100.52.234.62",
                    sshCredential: "ec2-server-key"
                )
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

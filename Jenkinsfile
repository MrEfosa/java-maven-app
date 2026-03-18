#!/usr/bin/env groovy
@Library("jenkins-shared-library") 

def gv

pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }

    stages {
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
                    echo "building the application for $BRANCH_NAME branch"
                    buildJar()
                }
            }
        }
        
        stage("build image") {
            steps {
                script {
                    buildImage("sirdavidchris/java-maven-app:3.2") 
                }
            }
        }
        stage("login to Docker Hub") {
            steps {
                script {
                    def docker = new com.example.Docker(this)
                    docker.loginToDockerHub()
                }
            }
        }
        stage("push image") {
            steps {
                    script {
                    pushImage("sirdavidchris/java-maven-app:3.2")   
                }
            }
        }
    }
}
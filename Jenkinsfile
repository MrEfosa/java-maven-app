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
        
        stage("push image") {
            steps {
                    script {
                    gv.deployApp()
                }
            }
        }
    }
}
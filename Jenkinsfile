#!/usr/bin/env groovy


Library identifier: "jenkins-shared-library", retriever: modernSCM(
    scm: [
        $class: "GitSCM",
        branches: [[name: "*/master"]],
        userRemoteConfigs: [[url: "https://github.com/MrEfosa/jenkins-shared-library.git"]],
        credentialsId: "github-credentials"
    ]
)

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
        
        stage("build and push image") {
            steps {
                script {
                    buildImage("sirdavidchris/java-maven-app:3.2")
                    dockerLogin()
                    dockerPush("sirdavidchris/java-maven-app:3.2")
                }
            }
        }
<<<<<<< HEAD

        stage("push image") {
            steps {
                    script {
                    pushImage("sirdavidchris/java-maven-app:3.2")   
                }
            }
        }
=======
>>>>>>> 923f681b13045e523c281ee223d41cd0acf9d1e6
    }
}

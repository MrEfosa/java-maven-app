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
        stage("build jar") {
            steps {
                script {
                    echo "building jar"
                    gv.buildJar()
                }
            }
        }
        stage("build image") {
            when {
                expression { 
                    BRANCH_NAME == "master"
                 }
            }
            steps {
                script {
                    echo "building image"
                    gv.buildImage()
                }
            }
        }
        stage("push image") {
            when {
                expression { 
                    BRANCH_NAME == "master"
                 }
            }
            steps {
                script {
                    echo "pushing image"
                    gv.pushImage()
                }
            }
        }
    }
}

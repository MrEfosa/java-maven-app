@Library("jenkins-shared-library") _

pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }

    stages {
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
                    echo "building jar"
                    buildJar()
                }
            }
        }
        
        stage("build image") {
            steps {
                script {
                    echo "building image"
                    buildImage()
                }
            }
        }
        
        stage("push image") {
            steps {
                    script {
                    echo "pushing image"
                }
            }
        }
    }
}

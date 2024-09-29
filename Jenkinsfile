pipeline {
    agent any
    environment {
                withCredentials([usernamePassword(credentialsId: 'bf23481a-9111-4c5a-b2bc-95a6ddd7d2b4', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {

                    sh '''
                    echo "Using AWS Access Key: $AWS_ACCESS_KEY_ID"
                    aws s3 ls # Replace this with your actual AWS CLI command
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/davidkapcsandi/monitoring.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-pipeline-app.'
            }
        }
        stage('Apply Terraform') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

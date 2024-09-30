pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')   // AWS Access Key stored in Jenkins credentials
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') // AWS Secret Key stored in Jenkins credentials
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/davidkapcsandi/monitoring.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-pipeline-app .'
            }
        }

        stage('Apply Terraform') {
            steps {
                // Export the AWS environment variables for Terraform to use
                sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                '''
                
                // Run Terraform commands
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

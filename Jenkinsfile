pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')   // AWS Access Key stored in Jenkins credentials
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') // AWS Secret Key stored in Jenkins credentials
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/davidkapcsandi/monitoring.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-pipeline-app .'
            }
        }

        stage('Apply Terraform') {
            steps {
                dir('terraform') {
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Install Grafana') {
            steps {
                script {
                    // Commands to install Grafana
                    sh '''
                        # Update package list
                        sudo apt-get update

                        # Install required dependencies
                        sudo apt-get install -y software-properties-common wget

                        # Add Grafana APT repository
                        sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" -y

                        # Add Grafana GPG key
                        wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

                        # Update package list again
                        sudo apt-get update

                        # Install Grafana
                        sudo apt-get install -y grafana

                        # Start Grafana service
                        sudo systemctl start grafana-server

                        # Enable Grafana to start on boot
                        sudo systemctl enable grafana-server

                        # Check Grafana status
                        sudo systemctl status grafana-server
                    '''
                }
            }
        }
    }
}

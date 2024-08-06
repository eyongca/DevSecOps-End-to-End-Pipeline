pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/eyongca/DevSecOps-End-to-End-Pipeline.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'ansible-playbook deploy.yml'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Docker Build and Push') {
            steps {
                sh 'docker build -t your-image .'
                sh 'docker push your-image'
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }
}

pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          sh 'mvn clean install'
        }
      }
    }
    stage('Test') {
      steps {
        script {
          sh 'mvn test'
        }
      }
    }
    stage('SonarQube Analysis') {
      steps {
        script {
          sh 'mvn sonar:sonar'
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
          sh 'ansible-playbook -i inventory deploy.yml'
        }
      }
    }
  }
}

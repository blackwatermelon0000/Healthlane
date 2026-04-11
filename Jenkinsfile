pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build and Run (Compose)') {
      steps {
        sh 'docker compose -f docker-compose.jenkins.yml down || true'
        sh 'docker compose -f docker-compose.jenkins.yml up -d --build'
      }
    }

    stage('Verify') {
      steps {
        sh 'docker compose -f docker-compose.jenkins.yml ps'
      }
    }
  }
}

pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Sync Repo To Host Path') {
      steps {
        sh 'mkdir -p /home/ashes/Healthlane'
        sh 'rm -rf /home/ashes/Healthlane/*'
        sh 'cp -a "$WORKSPACE"/. /home/ashes/Healthlane/'
      }
    }

    stage('Deploy Part-II') {
      steps {
        sh 'HOST_PROJECT_DIR=/home/ashes/Healthlane docker compose -p healthlane_pipeline -f /home/ashes/Healthlane/docker-compose.jenkins.yml down -v --remove-orphans || true'
        sh 'HOST_PROJECT_DIR=/home/ashes/Healthlane docker compose -p healthlane_pipeline -f /home/ashes/Healthlane/docker-compose.jenkins.yml up -d --build --remove-orphans'
      }
    }

    stage('Health Check') {
      steps {
        sh 'for i in $(seq 1 36); do curl -fsS http://localhost:8202/docs >/dev/null && break; sleep 5; done'
        sh 'for i in $(seq 1 36); do curl -fsS http://localhost:3200 >/dev/null && break; sleep 5; done'
        sh 'HOST_PROJECT_DIR=/home/ashes/Healthlane docker compose -p healthlane_pipeline -f /home/ashes/Healthlane/docker-compose.jenkins.yml ps'
      }
    }
  }
}

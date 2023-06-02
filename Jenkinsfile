pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'docker build -t glassfish:1.0 .'
      }
    }
    stage('Publish') {
      steps {
        sh 'docker tag glassfish:1.0 localhost:5000/repo-docker:1.0'
        sh 'docker push localhost:5000/repo-docker:1.0'
      }
    }
    stage('Run Container') {
      steps {
        sh 'docker run -d -p 7070:8080 --name mi-contenedor localhost:5000/repo-docker:1.0'
      }
    }
  }
}

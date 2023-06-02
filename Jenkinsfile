pipeline {
  agent any

  stages {
    stage('Construir') {
      steps {
        sh 'sudo docker build -t glassfish:1.0 .'
      }
    }
    stage('Publicar') {
      steps {
        sh 'sudo docker tag glassfish:1.0 localhost:5000/repo-docker:1.0'
        sh 'sudo docker push localhost:5000/repo-docker:1.0'
      }
    }
    stage('Run Container') {
      steps {
        sh 'sudo docker run -d -p 7070:8080 --name mi-contenedor2 localhost:5000/repo-docker:1.0'
      }
    }
  }
}

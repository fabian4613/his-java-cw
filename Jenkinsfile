pipeline {
  agent any

  stages {
    stage('Construir') {
      steps {
        sh 'sudo -S su root'
        sh 'sudo -S docker build -t glassfish:1.0 .'
      }
    }
    stage('Publicar') {
      steps {
        sh 'sudo -S docker tag glassfish:1.0 localhost:5000/repo-docker:1.0'
        sh 'sudo -S docker push localhost:5000/repo-docker:1.0'
      }
    }
    stage('Run Container') {
      steps {
        sh 'sudo -S docker run -d -p 7070:8080 --name mi-contenedor2 localhost:5000/repo-docker:1.0'
      }
    }
  }
}

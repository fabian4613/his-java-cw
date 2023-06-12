pipeline {
  agent any

  stages {
    stage('Construir') {
      steps {
        sh 'docker build -t glassfish:1.0 .'
      }
    }
    stage('Publicar') {
      steps {
        sh 'docker tag glassfish:gfsh2.0 localhost:5000/repo-docker:gfsh2.0'
        sh 'docker push localhost:5000/repo-docker:gfsh2.0'
      }
    }
    stage('Run Container') {
      steps {
        sh 'docker run -d -p 7070:8080 --name mi-contenedor3 localhost:5000/repo-docker:gfsh2.0'
      }
    }
  }
}

pipeline {
  agent any
 // hola
  stages {
    stage('Construir') {
      steps {
        telegramSend 'Construyendo Imagen con Dockerfile'
        sh 'docker build -t glassfish:gfsh2.0 .'
      }
    }
    stage('Publicar') {
      steps {
        telegramSend 'Publicando Imagen en Repo Local (Docker Registry)'
        sh 'docker tag glassfish:gfsh2.0 localhost:5000/repo-docker:gfsh2.0'
        sh 'docker push localhost:5000/repo-docker:gfsh2.0'
      }
    }
    stage('Run Container') {
      steps {
        telegramSend 'Creando Contenedor en base a la imagen'
        sh 'docker run -d -p 7070:8080 --name mi-contenedor3 localhost:5000/repo-docker:gfsh2.0'
        telegramSend 'Proceso docker finalizado correctamente'
      }
    }
  }
}

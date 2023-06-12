pipeline {
  agent any

  stages {
    stage('Construir') {
      steps {
        script {
          telegramSend(message: 'Construyendo Imagen con Dockerfile', chatId: '5488922521')
          sh 'docker build -t glassfish:gfsh2.0 .'
        }
      }
    }

    stage('Publicar') {
      steps {
        script {
          telegramSend(message: 'Publicando Imagen en Repo Local (Docker Registry)', chatId: '5488922521')
          sh 'docker tag glassfish:gfsh2.0 localhost:5000/repo-docker:gfsh2.0'
          sh 'docker push localhost:5000/repo-docker:gfsh2.0'
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          telegramSend(message: 'Creando Contenedor en base a la imagen', chatId: '5488922521')
          sh 'docker run -d -p 7070:8080 --name mi-contenedor3 localhost:5000/repo-docker:gfsh2.0'
          telegramSend(message: 'Proceso docker finalizado correctamente', chatId: '5488922521')
        }
      }
    }
  }
}

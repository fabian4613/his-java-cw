pipeline {
  agent any

  stages {
    // Etapa para construir la imagen del contenedor
    stage('Construir') {
      steps {
        script {
          telegramSend(message: 'Construyendo Imagen con Dockerfile', chatId: '5488922521')
          sh 'docker build -t glassfish:gfsh2.0 .'  // Construye la imagen con el nombre "glassfish:gfsh2.0"
        }
      }
    }

    // Etapa para publicar la imagen en el repositorio local (Docker Registry)
    stage('hernan') {
      steps {
        script {
          telegramSend(message: 'Publicando Imagen en Repo Local (Docker Registry)', chatId: '5488922521')
          sh 'docker tag glassfish:gfsh2.0 localhost:5000/repo-docker:gfsh2.0'  // Asigna una etiqueta a la imagen
          sh 'docker push localhost:5000/repo-docker:gfsh2.0'  // Envía la imagen al repositorio local
        }
      }
    }

    // Etapa para ejecutar el contenedor a partir de la imagen
    stage('Run Container') {
      steps {
        script {
          telegramSend(message: 'Creando Contenedor en base a la imagen', chatId: '5488922521')
          sh 'docker run -d -p 7070:8080 --name mi-contenedor4 localhost:5000/repo-docker:gfsh2.0'  // Crea y ejecuta un contenedor a partir de la imagen
          telegramSend(message: 'Proceso docker finalizado correctamente', chatId: '5488922521')
        }
      }
    }
  }
}

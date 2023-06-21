pipeline {
  agent any

  stages {
    stage('Setup') {
      steps {
        script {
          telegramSend(message: 'Configurando Docker Registry', chatId: '5488922521')
          def containerExists = sh(returnStdout: true, script: 'docker ps -a --format "{{.Names}}" | grep -w registry').trim()
          
          if (containerExists) {
            telegramSend(message: 'El contenedor del Docker Registry ya existe. Saltando configuración.', chatId: '5488922521')
          } else {
            sh 'docker run -d -p 5000:5000 --restart=always --name registry registry:2' // Crea un contenedor de Docker Registry
          }
        }
      }
    }

    stage('Construir') {
      steps {
        script {
          telegramSend(message: 'Construyendo Imagen con Dockerfile', chatId: '5488922521')
          sh 'docker build -t appjava:1.0 .'  // Construye la imagen con el nombre "appjava:1.0"
        }
      }
    }

    stage('Publicar') {
      steps {
        script {
          telegramSend(message: 'Publicando Imagen en Repo Local (Docker Registry)', chatId: '5488922521')
          sh 'docker tag appjava:1.0 localhost:5000/appjava:1.0'  // Asigna una etiqueta a la imagen
          sh 'docker push localhost:5000/appjava:1.0'  // Envía la imagen al repositorio local
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          telegramSend(message: 'Creando Contenedor en base a la imagen', chatId: '5488922521')
          sh 'docker run -d -p 7070:8080 --name app_java localhost:5000/appjava:1.0'  // Crea y ejecuta un contenedor a partir de la imagen
          telegramSend(message: 'Proceso docker finalizado correctamente', chatId: '5488922521')
        }
      }
    }
  }
}

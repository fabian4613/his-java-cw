pipeline {
  agent any

  stages {
    stage('Setup') {
      steps {
        script {
          // Configuración del Docker Registry
          def registryExists = sh(script: 'docker ps -a --filter "name=registry" --format "{{.Names}}"', returnStatus: true)

          if (registryExists != 0) {
            echo 'Configurando Docker Registry'
            sh 'docker run -d -p 5000:5000 --restart=always --name registry registry:2'
          } else {
            echo 'El contenedor registry ya existe'
          }
        }
      }
    }

    stage('Construir') {
      steps {
        script {
          // Verificar si la imagen ya existe
          def imageExists = sh(script: 'docker image inspect appjava:1.0', returnStatus: true)

          if (imageExists == 0) {
            echo 'La imagen appjava:1.0 ya existe'
          } else {
            echo 'Construyendo la imagen appjava:1.0'
            sh 'docker build -t appjava:1.0 .'
          }
        }
      }
    }

    stage('Actualizar Contenedor') {
      steps {
        script {
          // Verificar si el contenedor ya existe
          def containerExists = sh(script: 'docker ps -a --filter "name=app_java" --format "{{.Names}}"', returnStatus: true)

          if (containerExists == 0) {
            echo 'Deteniendo y eliminando el contenedor app_java existente'
            sh 'docker stop app_java'
            sh 'docker rm app_java'
          } else {
            // Crear un nuevo contenedor app_java con la imagen actualizada
            echo 'Creando un nuevo contenedor app_java con la imagen actualizada'
            sh 'docker run -d -p 7070:8080 --name app_java appjava:1.0'
          }
        }
      }
    }

  }
}

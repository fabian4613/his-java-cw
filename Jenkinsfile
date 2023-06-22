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
          def containerName = "app_java"
          def existingContainerId = sh(script: "docker ps -aqf \"name=${containerName}\"", returnStdout: true).trim()
    
          if (existingContainerId) {
            // Obtener el estado del contenedor existente
            def containerState = sh(script: "docker inspect -f '{{.State.Status}}' ${existingContainerId}", returnStdout: true).trim()
    
            if (containerState == 'running') {
              echo 'Deteniendo el contenedor app_java existente'
              sh "docker stop ${existingContainerId}"
            }
    
            echo 'Eliminando el contenedor app_java existente'
            sh "docker rm ${existingContainerId}"
          } else {
            echo 'El contenedor app_java no existe'
          }
    
          // Crear un nuevo contenedor app_java con la imagen actualizada
          echo 'Creando un nuevo contenedor app_java con la imagen actualizada'
          sh 'docker run -d -p 7070:8080 --name app_java appjava:1.0'
        }
      }
    }



  }
}

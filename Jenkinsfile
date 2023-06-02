pipeline {
  agent any

environment{
        // Configuración de las variables de entorno
    DOCKER_SSH_USERNAME = 'ubuntu'  // Nombre de usuario SSH para el servidor Docker
    SSH_HOST = '3.87.248.255'  // Dirección IP del servidor Docker
    DOCKER_SSH_CREDENTIALS = 'docker-ssh29'  // Credenciales SSH para el servidor Docker
}

  stages {
    stage('Build') {
      steps {
        script{
          sshagent(credentials: [DOCKER_SSH_CREDENTIALS]){
        sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${DOCKER_SSH_USERNAME}@${SSH_HOST} 'sudo docker build -t glassfish:1.0 .'"
            }
        }
       
      }
    }
    stage('Publish') {
      steps {
        script{
            sshagent(credentials: [DOCKER_SSH_CREDENTIALS]){
                 sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${DOCKER_SSH_USERNAME}@${SSH_HOST} 'sudo docker tag glassfish:1.0 localhost:5000/repo-docker:1.0'"
        sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${DOCKER_SSH_USERNAME}@${SSH_HOST}'sudo docker push localhost:5000/repo-docker:1.0'"
            }
        }
       
      }
    }
    stage('Run Container') {
      steps {
        script{
            sshagent(credentials: [DOCKER_SSH_CREDENTIALS]){
                sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${DOCKER_SSH_USERNAME}@${SSH_HOST}'sudo docker run -d -p 7070:8080 --name mi-contenedor2 localhost:5000/repo-docker:1.0'"
            }
        }
        
      }
    }
  }
}

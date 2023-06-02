pipeline {
    agent any
    
    stages {
        stage('Construir Imagen Docker') {
            steps {
                script {
                    def imageName = "glassfish"
                    echo "Creando imagen a partir del Dockerfile..."
                    docker.build(imageName, "-f")
                }
            }
        }
        
        stage('Ejecutar Contenedor Docker') {
            steps {
                script {
                    def imageName = "glassfish"
                    def containerName = "glassfish-deploy"
                    
                    echo "Arrancando el contenedor..."
                    docker.image(imageName).run("--name ${containerName} -d")
                }
            }
        }
        
    }
}

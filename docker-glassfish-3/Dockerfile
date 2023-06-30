# Establece la imagen base
FROM ubuntu:latest

# Configura las variables de entorno
ENV JAVAEE_HOME=/opt/javaee6sdk \
    JAVAEE_PKG=java_ee_sdk-6u2-unix.sh \
    JAVAEE_URL=https://download.oracle.com/otn-pub/java/java_ee_sdk/6u2-nojdk/java_ee_sdk-6u2-unix.sh \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    PATH=$PATH:/usr/local/glassfish3/bin \
    MD5=ae8e17e9dcc80117cb4b39284302763f 

# Actualiza los paquetes e instala las dependencias necesarias
RUN apt-get update && apt-get install -y wget unzip expect

# Crea el directorio de GlassFish y establece los permisos
RUN mkdir -p $GLASSFISH_HOME $JAVAEE_HOME

# Descarga e instala GlassFish
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG -d /usr/local && \
    rm -f $GLASSFISH_PKG && \
    \
    # Elimina los archivos .bat y .exe de Windows para ahorrar espacio
    cd $GLASSFISH_HOME && \
    find . -name '*.bat' -delete && \
    find . -name '*.exe' -delete

# Descarga e instala Java EE 6 SDK Update 2
RUN wget -q -O $JAVAEE_HOME/$JAVAEE_PKG $JAVAEE_URL && \
    chmod +x $JAVAEE_HOME/$JAVAEE_PKG && \
    echo "A" | $JAVAEE_HOME/$JAVAEE_PKG && \
    rm -f $JAVAEE_HOME/$JAVAEE_PKG

# Expone los puertos
EXPOSE 4848 8080 8181

# Establece el directorio de trabajo
WORKDIR $GLASSFISH_HOME

# Copia el script de entrada
COPY docker-entrypoint.sh $GLASSFISH_HOME/

# Copia los archivos WAR locales al directorio autodeploy de GlassFish
COPY prueba2grupo1.war prueba2grupo2.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# Inicia el dominio de GlassFish y genera SSL
CMD $GLASSFISH_HOME/bin/asadmin start-domain --verbose

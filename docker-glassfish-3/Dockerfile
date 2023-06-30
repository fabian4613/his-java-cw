FROM ubuntu:latest

# Set environment variables
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    MD5=ae8e17e9dcc80117cb4b39284302763f \
    PATH=$PATH:/usr/local/glassfish3/bin
    
# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y wget unzip expect

# Download and install OpenJDK 7
RUN apt-get install -y openjdk-8-jdk

# Create the GlassFish directory and set permissions
RUN mkdir -p $GLASSFISH_HOME

# Download and install GlassFish
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG -d /usr/local && \
    rm -f $GLASSFISH_PKG && \
    \
    # Remove Windows .bat and .exe files to save space
    cd $GLASSFISH_HOME && \
    find . -name '*.bat' -delete && \
    find . -name '*.exe' -delete

# Establece las variables de entorno en asenv.conf
RUN echo "AS_JAVA=/usr/lib/jvm/java-8-openjdk-amd64" >> $GLASSFISH_HOME/glassfish/domains/domain1/config/asenv.conf && \
    echo "OTRA_VARIABLE=valor" >> $GLASSFISH_HOME/glassfish/domains/domain1/config/asenv.conf

# Ports being exposed
EXPOSE 4848 8080 8181 8181

WORKDIR $GLASSFISH_HOME

# Copy the entrypoint script
COPY docker-entrypoint.sh $GLASSFISH_HOME/

# Copia los archivos WAR locales al directorio autodeploy de GlassFish
COPY prueba2grupo1.war prueba2grupo2.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# Inicia el dominio de GlassFish y genera SSL
CMD tail -f /dev/null

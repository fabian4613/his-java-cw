FROM openjdk:7u151-jdk-alpine

# Set environment variables
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    PATH=$PATH:/usr/local/glassfish3/bin

# Update packages and install necessary dependencies
RUN apk update && apk add wget unzip

# Download and install GlassFish
RUN wget -q -O $GLASSFISH_PKG $GLASSFISH_URL \
    && unzip -o $GLASSFISH_PKG -d /usr/local \
    && rm -f $GLASSFISH_PKG \
    && cd $GLASSFISH_HOME \
    && find . -name '*.bat' -delete \
    && find . -name '*.exe' -delete

# Ports being exposed
EXPOSE 4848 8080 8181 8181

WORKDIR $GLASSFISH_HOME

# Copy the entrypoint script
COPY docker-entrypoint.sh $GLASSFISH_HOME/

# Copy the local WAR files to GlassFish autodeploy directory
COPY prueba2grupo1.war prueba2grupo2.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# Set the entrypoint script as executable
RUN chmod +x $GLASSFISH_HOME/docker-entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]

# Start the GlassFish domain
CMD ["asadmin", "start-domain", "--verbose"]

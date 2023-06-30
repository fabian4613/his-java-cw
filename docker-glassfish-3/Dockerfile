FROM ubuntu:14.04

# Set environment variables
ENV GLASSFISH_PKG=/tmp/glassfish-3.1.2.2.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip \
    GLASSFISH_HOME=/usr/local/glassfish3 \
    MD5=ae8e17e9dcc80117cb4b39284302763f \
    PATH=$PATH:/usr/local/glassfish3/bin
    
# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y wget unzip expect

# Download and install OpenJDK 6
RUN apt-get install -y openjdk-6-jdk

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
    
# Ports being exposed
EXPOSE 4848 8080 8181 8181

WORKDIR $GLASSFISH_HOME

# Copy the entrypoint script
COPY docker-entrypoint.sh $GLASSFISH_HOME/


# Copy the local WAR files to GlassFish autodeploy directory
COPY prueba2grupo1.war prueba2grupo2.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/


# Start GlassFish domain and generate SSL
CMD $GLASSFISH_HOME/bin/asadmin start-domain --verbose | tail -f /dev/null


#!/bin/bash

# Ruta al directorio de configuración de GlassFish
GLASSFISH_HOME="/usr/local/glassfish3"

# Nombre del almacén de claves y archivo JKS
KEYSTORE_FILE="keystore.jks"
CACERTS_FILE="cacerts.jks"

# Alias y contraseñas del certificado
CERTIFICATE_ALIAS="fabiancert"
KEYSTORE_PASSWORD="fabian5613"
CERTIFICATE_PASSWORD="fabian5613"

# Navegar al directorio de configuración
cd $GLASSFISH_HOME/glassfish/domains/domain1/config

# Crear almacén de claves vacío
keytool -genkey -alias dummy -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=dummy" -validity 365

# Eliminar clave dummy
keytool -delete -alias dummy -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

# Crear archivo JKS vacío
keytool -genkey -alias dummy -keystore $CACERTS_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=dummy" -validity 365

# Eliminar clave dummy
keytool -delete -alias dummy -keystore $CACERTS_FILE -storepass $KEYSTORE_PASSWORD

# Generar certificado autofirmado
keytool -genkeypair -alias $CERTIFICATE_ALIAS -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=Fabian" -validity 365

echo "¡Almacén de claves y archivo JKS creados con éxito!"

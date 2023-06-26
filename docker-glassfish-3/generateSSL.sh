#!/bin/bash

# Ruta al directorio de configuración de GlassFish
GLASSFISH_HOME="/usr/local/glassfish3"

# Nombre del archivo de contraseñas
PASSWORD_FILE="$GLASSFISH_HOME/glassfish/domains/domain1/config/admin-password.txt"

# Contraseña maestra
MASTER_PASSWORD="fabian5613"

# Nombre del almacén de claves y archivo JKS
KEYSTORE_FILE="keystore.jks"
CACERTS_FILE="cacerts.jks"

# Alias y contraseñas del certificado
CERTIFICATE_ALIAS="fabiancert"
KEYSTORE_PASSWORD="fabian5613"
CERTIFICATE_PASSWORD="fabian5613"

# Crear el archivo de contraseñas si no existe
touch $PASSWORD_FILE

# Asignar permisos al archivo de contraseñas
chmod 600 $PASSWORD_FILE

# Detener el dominio si está en ejecución
$GLASSFISH_HOME/bin/asadmin stop-domain

# Escribir la contraseña maestra en el archivo de contraseñas
echo "AS_ADMIN_PASSWORD=$MASTER_PASSWORD" > $PASSWORD_FILE
echo "AS_ADMIN_NEWPASSWORD=$MASTER_PASSWORD" >> $PASSWORD_FILE

# Cambiar la contraseña maestra del administrador
$GLASSFISH_HOME/bin/asadmin --passwordfile $PASSWORD_FILE change-master-password --savemasterpassword=true

# Eliminar el archivo de contraseñas
rm $PASSWORD_FILE

# Navegar al directorio de configuración
cd $GLASSFISH_HOME/glassfish/domains/domain1/config

# Crear almacén de claves vacío
$GLASSFISH_HOME/glassfish/bin/keytool -genkey -alias dummy -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=dummy" -validity 365

# Eliminar clave dummy
$GLASSFISH_HOME/glassfish/bin/keytool -delete -alias dummy -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

# Crear archivo JKS vacío
$GLASSFISH_HOME/glassfish/bin/keytool -genkey -alias dummy -keystore $CACERTS_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=dummy" -validity 365

# Eliminar clave dummy
$GLASSFISH_HOME/glassfish/bin/keytool -delete -alias dummy -keystore $CACERTS_FILE -storepass $KEYSTORE_PASSWORD

# Generar certificado autofirmado
$GLASSFISH_HOME/glassfish/bin/keytool -genkeypair -alias $CERTIFICATE_ALIAS -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD -keypass $CERTIFICATE_PASSWORD -dname "CN=Fabian" -validity 365

# Iniciar el dominio en segundo plano
$GLASSFISH_HOME/bin/asadmin start-domain &

# Mantener el contenedor en ejecución
tail -f /dev/null

echo "¡Contraseña maestra de administrador creada y almacén de claves JKS creados con éxito!"

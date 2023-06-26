# Iniciar el dominio en segundo plano
$GLASSFISH_HOME/bin/asadmin start-domain &

# Mantener el contenedor en ejecución
tail -f /dev/null


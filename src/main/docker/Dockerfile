# Usa una imagen base de Wildfly
FROM jboss/wildfly:latest
ENV WILDFLY_USER admin
ENV WILDFLY_PASS admin

ENV JBOSS_CLI $JBOSS_HOME/bin/jboss-cli.sh
ENV DEPLOYMENT_DIR $JBOSS_HOME/standalone/deployments/

RUN echo "Adding WildFly administrator"
RUN $JBOSS_HOME/bin/add-user.sh -u $WILDFLY_USER -p $WILDFLY_PASS --silent

# Copia el archivo WAR construido en el target del proyecto a la carpeta de despliegue de Wildfly
# Copia el archivo WAR de tu aplicación Spring Boot al directorio de despliegue de Wildfly
COPY maven/${project.build.finalName}.${project.packaging} ${DEPLOYMENT_DIR}
#COPY target/registro_curso_ms_docker.war /opt/jboss/wildfly/standalone/deployments/

# Expone el puerto 8090 para la aplicación desplegada en Wildfly
EXPOSE 8090
# puerto administracion
EXPOSE 9090

# Comando para ejecutar Wildfly al iniciar el contenedor
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
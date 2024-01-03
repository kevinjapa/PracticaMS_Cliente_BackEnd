# Use the base WildFly image
FROM jboss/wildfly

# Set environment variables
ENV WILDFLY_USER=user
ENV WILDFLY_PASS=userPassword

ENV DS_NAME=myDS
ENV DS_USER=consultas
ENV DS_PASS=QueryConSql.pwd
ENV DS_URI=jdbc:postgresql://srvdb/consultas

ENV JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
ENV DEPLOYMENT_DIR=$JBOSS_HOME/standalone/deployments/

# Add WildFly administrator
RUN $JBOSS_HOME/bin/add-user.sh -u $WILDFLY_USER -p $WILDFLY_PASS --silent

# Configure WildFly server and set up PostgreSQL datasource
RUN echo "Starting WildFly server" && \
    $JBOSS_HOME/bin/standalone.sh -c standalone.xml & \
    until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do \
        echo `$JBOSS_CLI -c ":read-attribute(name=server-state)"` && sleep 1; \
    done && \
    curl --location --output /tmp/postgresql-42.2.16.jar --url https://jdbc.postgresql.org/download/postgresql-42.2.16.jar && \
    $JBOSS_CLI --connect --command="/subsystem=undertow/server=default-server/ajp-listener=ajp-listener:add(socket-binding=ajp, scheme=https)" && \
    $JBOSS_CLI --connect --command="/subsystem=undertow:write-attribute(name=statistics-enabled,value=true)" && \
    $JBOSS_CLI --connect --command="module add --name=org.postgres --resources=/tmp/postgresql-42.2.16.jar --dependencies=javax.api,javax.transaction.api" && \
    $JBOSS_CLI --connect --command="/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgres,driver-class-name=org.postgresql.Driver,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)" && \
    $JBOSS_CLI --connect --command="data-source add \
        --name=${DS_NAME} \
        --jndi-name=java:jboss/datasources/${DS_NAME} \
        --user-name=${DS_USER} \
        --password=${DS_PASS} \
        --driver-name=postgresql \
        --connection-url=${DS_URI} \
        --min-pool-size=10 \
        --max-pool-size=20 \
        --blocking-timeout-wait-millis=5000 \
        --statistics-enabled=true \
        --enabled=true" && \
    $JBOSS_CLI --connect --command=":shutdown" && \
    rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/ $JBOSS_HOME/standalone/log/* && \
    rm -f /tmp/*.jar

# Copy the application WAR file to WildFly deployments directory
#COPY target/cursos-online-docker.war $DEPLOYMENT_DIR



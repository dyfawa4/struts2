FROM struts2-tomcat-base:8.5.100

COPY s2-009/S2-009.war /tmp/ROOT.war

RUN set -ex \
    && mkdir -p $CATALINA_HOME/webapps/ROOT \
    && cd $CATALINA_HOME/webapps/ROOT \
    && jar -xf /tmp/ROOT.war \
    && rm /tmp/ROOT.war

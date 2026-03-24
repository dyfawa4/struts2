FROM struts2-tomcat-base:9.0.97-jdk8

COPY s2-059/ROOT.war /tmp/ROOT.war

RUN set -ex \
    && mkdir -p $CATALINA_HOME/webapps/ROOT \
    && cd $CATALINA_HOME/webapps/ROOT \
    && jar -xf /tmp/ROOT.war \
    && rm /tmp/ROOT.war

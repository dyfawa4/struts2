FROM struts2-tomcat-base:8.5.100

COPY s2-057/struts2-showcase.war /tmp/ROOT.war
COPY s2-057/struts-actionchaining.xml /tmp/struts-actionchaining.xml

RUN set -ex \
    && mkdir -p $CATALINA_HOME/webapps/ROOT \
    && cd $CATALINA_HOME/webapps/ROOT \
    && jar -xf /tmp/ROOT.war \
    && rm -f /tmp/ROOT.war \
    && mv /tmp/struts-actionchaining.xml $CATALINA_HOME/webapps/ROOT/WEB-INF/classes/struts-actionchaining.xml

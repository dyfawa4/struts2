ARG JDK_VERSION=8
FROM eclipse-temurin:${JDK_VERSION}-jdk

LABEL maintainer="phithon <root@leavesongs.com>"

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

ARG TOMCAT_VERSION=8.5.100
COPY apache-tomcat-${TOMCAT_VERSION}.tar.gz /tmp/apache-tomcat.tar.gz

RUN set -ex \
    && tar -xzf /tmp/apache-tomcat.tar.gz -C /usr/local \
    && mv /usr/local/apache-tomcat-${TOMCAT_VERSION} $CATALINA_HOME \
    && rm -rf $CATALINA_HOME/webapps/* /tmp/apache-tomcat.tar.gz \
    && chmod a+x $CATALINA_HOME/bin/*.sh

EXPOSE 8080
CMD ["catalina.sh", "run"]

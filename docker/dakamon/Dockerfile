FROM tomcat:9-jre8
MAINTAINER <a href="mailto:e.h.juerrens@52north.org">J&uuml;rrens, Eike Hinderk</a>

ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/share/maven

WORKDIR /tmp

RUN apt-get update &&\
    apt-get --assume-yes upgrade &&\
    apt-get dist-upgrade --assume-yes &&\
    apt-get install --assume-yes --no-install-recommends openjdk-8-jdk maven git
RUN git clone https://github.com/EHJ-52n/series-rest-api.git &&\
    cd series-rest-api &&\
    git checkout -b distribution/dakamon origin/distribution/dakamon &&\
    mvn install -DskipTests=true &&\
    cd ..
RUN git clone https://github.com/EHJ-52n/dao-series-api.git &&\
    cd dao-series-api &&\
    git checkout -b distribution/dakamon origin/distribution/dakamon &&\
    mvn install -DskipTests=true &&\
    cd ..
RUN git clone https://github.com/EHJ-52n/SOS.git &&\
    cd SOS &&\
    git checkout -b distribution/dakamon origin/distribution/dakamon &&\
    mvn package -DskipTests=true -P-check
RUN mv /tmp/SOS/webapp/target/52n-sos-webapp /usr/local/tomcat/webapps/ &&\
    rm -rfv /tmp/SOS &&\
    rm -rfv /usr/local/tomcat/webapps/docs &&\
    rm -rfv /usr/local/tomcat/webapps/examples &&\
    rm -rfv /usr/local/tomcat/webapps/host-manager &&\
    rm -rfv /usr/local/tomcat/webapps/manager &&\
    rm -fv /usr/local/tomcat/webapps/ROOT/tomcat* &&\
    find /usr/local/tomcat/webapps/ROOT/* -maxdepth 0  -type f -print0| xargs -0 rm -v &&\
    apt-get purge git maven openjdk-8-jdk --assume-yes &&\
    apt-get autoremove --purge --assume-yes && apt-get clean --assume-yes &&\
    rm -rf /var/cache/apt/archives &&\
    rm -rf /root/.m2 &&\
    rm -rf /var/lib/apt/lists/*

COPY ./tomcat-index.html /usr/local/tomcat/webapps/ROOT/index.html
# config uses postgrest:postgres @db
COPY ./datasource.properties /usr/local/tomcat/webapps/52n-sos-webapp/WEB-INF/
COPY ./configuration.db /usr/local/tomcat/webapps/52n-sos-webapp/
COPY ./application.properties /usr/local/tomcat/webapps/52n-sos-webapp/WEB-INF/classes/

WORKDIR /usr/local/tomcat

ENV JAVA_OPTS="-XX:PermSize=4096m -XX:MaxPermSize=3072m"

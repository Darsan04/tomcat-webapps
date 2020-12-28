FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get -y install openjdk-8-jdk wget curl iputils-ping telnet vim
RUN apt-get -y install maven
CMD mvn -version
RUN mkdir /opt/tomcat/
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.61/src/apache-tomcat-8.5.61-src.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.61-src/* /opt/tomcat/
WORKDIR /app
COPY . .
RUN mvn clean install
RUN cp target/WebApp.war /opt/tomcat/webapps/
EXPOSE 8080
CMD "sh" "start.sh"

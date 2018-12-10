FROM tomcat:latest
RUN mkdir -p /usr/local/tomcat/webapps/test
COPY ./mysql-connector-java-5.1.44-bin.jar /usr/local/tomcat/webapps/test
COPY ./db.jsp /usr/local/tomcat/webapps/test 
COPY ./web.xml /usr/local/tomcat/webapps/test
CMD ["catalina.sh", "run"] 
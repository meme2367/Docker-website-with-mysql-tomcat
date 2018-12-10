deploying java web with docker container
========================================

## architecture

![architecture](https://i.stack.imgur.com/4Av3X.png)

## tomcat folder - docker file

FROM tomcat:latest
RUN mkdir -p /usr/local/tomcat/webapps/test/
COPY ./mysql-connector-java-5.1.44-bin.jar /usr/local/tomcat/webapps/test
COPY ./db.jsp /usr/local/tomcat/webapps/test 
COPY ./web.xml /usr/local/tomcat/webapps/test
CMD ["catalina.sh", "run"]
tomcat folder - db.jsp

## mysql folder - dockerfile

FROM mysql:5.7
ENV MYSQL_ROOT_PASSWORD=".."
ENV MYSQL_DATABASE=".."
ENV MYSQL_USER=".." 
ENV MYSQL_PASSWORD=".."
EXPOSE 3306
tomcat folder - mysql-connector-java-5.1.44-bin.jar

## tomcat folder - web.xml

<web-app></web-app>

run by: 

docker build -t my-mysql . docker run -dit --name mysql1 -p 3306:3306 my-mysql

and input datadase using mysql workbench(i granted a privileges and checked the data at docker mysql bash.)

run by :

docker build -t my-tomcat .
docker run -dit --link mysql1:my-mysql --name myTomcat1 -p 8888:8080 my-tomcat

get access to http://localhost:8888/test/db.jsp

+ https://stackoverflow.com/questions/53700678/connect-tomcat-and-mysql-in-docker-container-with-jdbc-driver

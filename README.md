deploying java web with docker container
========================================

## architecture

![architecture](https://i.stack.imgur.com/4Av3X.png)

## organize your working directory like this:
```
docker/
```
```
tomcat/
    Dockerfile
    webapp/
        WEB-INF/
          classes/
          lib/mysql-connector-java-5.1.44-bin.jar
          web.xml
        db.jsp
```
+ web-inf/lib/설정해야 jdbc driver 제대로 작동됨.

## tomcat folder - docker file
```
  FROM tomcat:latest
  RUN mkdir -p /usr/local/tomcat/webapps/test/
  COPY ./mysql-connector-java-5.1.44-bin.jar /usr/local/tomcat/webapps/test
  COPY ./db.jsp /usr/local/tomcat/webapps/test 
  COPY ./web.xml /usr/local/tomcat/webapps/test
  CMD ["catalina.sh", "run"]
```
webapps폴더의 하위폴더에 jsp비롯 웹과 관련된 코드 넣음.

## tomcat folder - db.jsp
파일 저장시 인코딩 utf-8, 파일 형식 모든파일로 설정하고 저장.

## tomcat folder - mysql-connector-java-5.1.44-bin.jar

## mysql folder - dockerfile
```
  FROM mysql:5.7
  ENV MYSQL_ROOT_PASSWORD="welcome1"
  ENV MYSQL_DATABASE="test"
  ENV MYSQL_USER="root" 
  ENV MYSQL_PASSWORD="welcome1"
  EXPOSE 3306
```  
## tomcat folder - web.xml

<web-app></web-app>

run by: 
```
docker build -t my-mysql .
docker run -dit --name mysql1 -p 3306:3306 my-mysql\`
```
and input datadase using mysql workbench(i granted a privileges and checked the data at docker mysql bash.)

run by :
```
  docker build -t my-tomcat .
  docker run -dit --link mysql1:my-mysql --name myTomcat1 -p 8888:8080 my-tomcat
```  
  
### mysql bash || workbench
run by :
```
  docker exec -it mysql1 bash
  mysql -u root -p
```  
+ create user 계정@호스트 identified by 암호;
  (호스트가 %일때는 모든 호스트에서 해당 계정으로 접근할 때 해당 암호 사용한다는 뜻.)
+ grant 권한목록 on db.대상 to 계정@호스트
```  
  create database dku default character set utf8;
  create user 'dku'@'localhost' identified by '...';
  grant all privileges on dku.* to 'dku'@'localhost';
  create user 'dku'@'%' identified by '...';
  grant all privilegeson dku.* to 'dku'@'%';
  flush privileges;
  quit;
```  
get access to http://localhost:8080/test/db.jsp
(톰캣의 기본 포트번호 8080, 웹서버 기본 포트번호 80)

+ https://stackoverflow.com/questions/53700678/connect-tomcat-and-mysql-in-docker-container-with-jdbc-driver

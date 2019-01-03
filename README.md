java member-board web with docker container
========================================


## 회원 관련 기능
- 회원 가입
- 회원 정보 수정하기
- 로그인하기
- 로그아웃하기
- 로그인한 사람만 특정 기능 실행하기

## 게시판 기능
- 게시글 등록
- 게시글 목록 조회
- 게시글 내용 조회
- 게시글 수정

## organize your working directory like this:
```
mysql/
    Dockerfile
```
```
tomcat/
    guestboard.sql
    Dockerfile
    board/
        WEB-INF/
            classes/
            lib/
                mysql-connector-java-5.1.35-bin.jar
                jstl-1.2.jar
                commons-pool2-2.4.1.jar
                commons-logging-1.2.jar
                commons-dbcp2-2.1.jar
            src/
            tags/
            view/
            commandHandlerURI.properties
            web.xml
        META-INF/
        dbconnTest.jsp
        index.jsp

        
```
+ web-inf/lib/설정해야 jdbc driver 제대로 작동됨.

## tomcat folder - docker file
```
    FROM tomcat:latest
    ADD ./board /usr/local/tomcat/webapps/board/
    CMD ["catalina.sh", "run"]
```
webapps폴더의 하위폴더에 jsp비롯 웹과 관련된 코드 넣음.


## mysql folder - dockerfile
```
    FROM mysql:5.7
    ENV MYSQL_ROOT_PASSWORD="welcome1"
    ENV MYSQL_DATABASE="board"
    ENV MYSQL_USER="dku"
    ENV MYSQL_PASSWORD="welcome1"
    EXPOSE 3306
```  

## docker container
run by: 
```
docker build -t my-mysql .
docker run -dit --name mysql1 -p 3306:3306 my-mysql
```
and input datadase using mysql workbench(i granted a privileges and checked the data at docker mysql bash.)

run by :
```
  docker build -t my-tomcat .
  docker run -dit --link mysql1:my-mysql --name myTomcat1 -p 8888:8080 my-tomcat
```  
  
## mysql bash || workbench
run by :
```
  docker exec -it mysql1 bash
  mysql -u root -p
```  
+ create user 계정@호스트 identified by 암호;
  (호스트가 %일때는 모든 호스트에서 해당 계정으로 접근할 때 해당 암호 사용한다는 뜻.)
+ grant 권한목록 on db.대상 to 계정@호스트
```  
  create database board default character set utf8;
  
  create user 'dku'@'localhost' identified by 'welcome1';
  create user 'dku'@'%' identified by 'welcome1';

  grant all privileges on board.* to 'dku'@'localhost';
  grant all privileges on board.* to 'dku'@'%';

  flush privileges;
  quit;

  exit

```  
get access to http://localhost:8888/board/
(톰캣의 기본 포트번호 8080, 웹서버 기본 포트번호 80)

## delete port

sudo netstat -nlpt |grep 3306
sudo service mysql stop


+ https://stackoverflow.com/questions/53700678/connect-tomcat-and-mysql-in-docker-container-with-jdbc-driver

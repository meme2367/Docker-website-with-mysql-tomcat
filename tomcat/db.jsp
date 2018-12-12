<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page language="java" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>회원 목록</title></head>
<body>

MEMBER 테이블의 내용
<table width="100%" border="1">
<tr>
	<td>이름</td><td>아이디</td><td>이메일</td>
</tr>
<%
	Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcdriver = "jdbc:mysql://mysql1:3306/dku";
        String db_user = "dku";


        String db_pass = "welcome1";
        
        String query = "select * from test";
        
        // 2. 데이터베이스 커넥션 생성
         conn = java.sql.DriverManager.getConnection(jdbcdriver, db_user, db_pass);
        
        // 3. Statement 생성
        stmt = conn.createStatement();
        
        // 4. 쿼리 실행
        rs = stmt.executeQuery(query);
        
        // 5. 쿼리 실행 결과 출력
         while (rs.next()) {
                String sqlRecipeProcess = rs.getString("id");
                String sqlRecipeProcess2 = rs.getString("name");
        }


    }catch(SQLException ex) {
        out.println(ex.getMessage());
        ex.printStackTrace();
    } finally {
        // 6. 사용한 Statement 종료
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        
        // 7. 커넥션 종료
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
%>
</table>

</body>
</html>

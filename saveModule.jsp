<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String boardCnt=request.getParameter("boardCount");
    String BoardContents=request.getParameter("contents");
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="UPDATE board SET boardContents = ? WHERE boardId = ?";
    PreparedStatement query=connect.prepareStatement(sql);
    int temp= Integer.parseInt(boardCnt);
    query.setString(1,BoardContents);
    query.setInt(2,temp);

    query.executeUpdate();
    response.sendRedirect("index.jsp");
   
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>week7 project</title>
</head>
<body>
   <script>
       alert("저장 되었습니다.");
       location.href ="index.jsp";
    </script>
</body>
</html>

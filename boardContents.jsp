<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String resultTitle="";
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT *FROM board";
    PreparedStatement query=connect.prepareStatement(sql);
    ResultSet result=query.executeQuery();

    while(result.next()){
       data.add("'" + Integer.toString(result.getInt(1)) + "'");
       data.add("'" + result.getString(3) + "'");
       data.add("'" + result.getString(5) + "'");
       dataList.add(data);
    }

%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>week7 project</title>
</head>
<body>
   
    <h2>제목에 해당 하는 내용 볼 수  있고 내용 삭제 가능하게 만들었다.</h2>
    <div></div>
    <div></div>
    
</body>
</html>
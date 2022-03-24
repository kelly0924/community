<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>week7 project</title>
</head>
<body>
   <header>
   
   </header>
   <main>
        <form action="addModule.jsp" method="post">
            <div id="contentsDiv">
                <h2>게시글 쓰기</h2>
                <textarea id="contentsDivTextarea" name="contents"></textarea>
                 <input type="submit" value="저장">
            </div>
        </form>    
   </main>
</body>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String resultCnt=request.getParameter("boardcount");
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="DELETE FROM board WHERE boardId=?";
    PreparedStatement query=connect.prepareStatement(sql);
    int temp= Integer.valueOf(resultCnt);
    query.setInt(1,temp);

    query.executeUpdate();
    response.sendRedirect("index.jsp");
   
%>

<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String  id=request.getParameter("idValue");
    String pw=request.getParameter("pwValue");
    String resultId="";
    String resultPw="";

    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호

    String sql="SELECT * FROM login WHERE userId=? and userPw=?";
    PreparedStatement query =connect.prepareStatement(sql);
    query.setString(1,id);
    query.setString(2,pw);

    ResultSet result=query.executeQuery();//데이터 베이스에 값을 불러와서 저장 하기 

    while(result.next()){
        resultId=result.getString(1);
        resultPw=result.getString(2);
    }

    if(id.equals(resultId) && pw.equals(resultPw)){
        response.sendRedirect("index.jsp");
    }else{
        response.sendRedirect("logPage.jsp");
    }




%>
<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    Cookie[] ck = request.getCookies();
    String sessionId="";
    String userId="";
    if (ck != null) {//쿠키가 비여 있지 않을 경우
        for (Cookie cookies : ck) {
            if (cookies.getName().equals("cookid")){
                sessionId = cookies.getValue();//세션으로 id를 불러 온다. 
            }
        }
        if(sessionId != null){//생성된 세션이 존재 한다는 뜻 생성된 세션이 존재 하면 
            userId=(String)session.getAttribute("id");// 생성된 세션에 값을 가져 오겠다. 
        }
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
   <header>
             <div id="headerRightDiv">
            </div>
   </header>
   <main>
        <form action="addModule.jsp" method="post">
            <div>
                제목: <input type="text" name="title">
            </div>
            <div>
                날짜: <input type="date" name="writeDate">
            </div>
            <div id="contentsDiv">
                내용: <textarea id="contentsDivTextarea" name="contents"></textarea>
                <%--userId를 넘겨 주기 위해서 type="hidden으로 만들어 주기" --%>
                <input type="hidden" name="userId" value="<%=userId%>">
                <input type="submit" value="저장">
            </div>
        </form>    
   </main>

   <script>
        document.getElementById("headerRightDiv").innerHTML="<%=userId%>";
   </script>
</body>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String resultCnt=request.getParameter("boardcount");
    String resultBoardContents="";
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT * FROM board WHERE boardId=?";
    PreparedStatement query=connect.prepareStatement(sql);
    int temp= Integer.valueOf(resultCnt);
    query.setInt(1,temp);

    ResultSet result = query.executeQuery();
    
    while(result.next()){
        resultBoardContents=result.getString(4);
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
   
   </header>
   <main>
         <h2>제목에 해당 하는 내용 볼 수  있고 내용 삭제 가능하게 만들었다.</h2>
        <form action="saveModule.jsp" method="post">
            <div id="contentsDiv">
                <h2>계시글 내용</h2>
                <input type="hidden" name="boardCount" value="<%=resultCnt%>">
                <textarea id="contentsDivTextarea" name="contents"></textarea>
            </div>
            <div>
                <input type="button" value="삭제" deleteFun>
                <input id="deletButton" type="button" value="수정">
                <input type="submit" value="저장">
            </div>
        </form>    
   </main>
    <script>
        console.log("<%=resultBoardContents%>");
        document.getElementById("contentsDivTextarea").innerHTML="<%=resultBoardContents%>";

        var boardCnt=<%=resultCnt%>;
        var deletBut=document.getElementById("deletButton");
        deletBut.addEventListener('click',deleteFun)

        function deleteFun(){
            var newForm=document.createElement("form");
                newForm.setAttribute("action","deleteModule.jsp");
                newForm.setAttribute("method","post");
                resultDiv.appendChild(newForm);
                var newInput=document.createElement("input");
                newInput.setAttribute("name","boardcount");
                newInput.setAttribute("value",boardCnt);
                newForm.appendChild(newInput);
                newForm.submit();
         }
        
    </script>
</body>
</html>
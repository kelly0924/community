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
   // boolean logCheck = true;//로그인이 되었는지를 체그 하는 변수 
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


    String count="";
    String resultTitle="";
    String writer="";
    String writeDate="";
    String userName="";

    ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();
    //DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect =DriverManager.getConnection("jdbc:mysql://localhost:3306/communityDB", "community","1234");//데이터 베이스 계정 아이디, 데이터베이스 계정 비밀번호
    
    String sql="SELECT *FROM board";
    PreparedStatement query=connect.prepareStatement(sql);
    ResultSet result=query.executeQuery();

    while(result.next()){
       ArrayList<String> data=new ArrayList<String>();
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
        <link rel="stylesheet" type="text/css" href="index.css">
        <title>week7 project</title>
    </head>
    <body>
        <h1>show community</h1>
        <header> 
            <div>
                <div id="headerRightWriteDiv"><input type="button" value="글쓰기"  onclick="newWriteEvent()"></div>
                <div id="headerRightUserIdDv"></div>
                <div id="headerRightlogOutDiv"><input id="logOutButton" type="button" value="로그아웃" onclick="logOutEvent()"></div>
                <div id="headerRightlogInDiv"><input id="logInButton" type="button" value="로그인" onclick="logInEvent()"></div>
            </div>
        </header>

        <main>
            <div></div>
            <table>
                <thead>
                    <tr>
                        <th>번호</th> 
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody id="tbody">
                    <tr id="tbodyTr">
                        <%-- <td class="countTd"></td>
                        <td class="titleTd"></td>
                        <td class="writerTd"></td>
                        <td class="writeDateTd"></td> --%>
                    </tr>
                </tbody>

            </table>
        </main>

        <script>
            var boardList = <%=dataList%>;//jsp에 arrylist를 js 변수에 저장
            var jsLogCheck ="<%=userId%>"
            console.log(jsLogCheck);
            //userId를 출력 하는 부분

            function moveBoardConentsEvent(boardcnt){
                console.log(boardcnt);
                var resultDiv=document.getElementById("tbody");
                var newForm=document.createElement("form");
                newForm.setAttribute("action","boardContents.jsp");
                newForm.setAttribute("method","post");
                resultDiv.appendChild(newForm);
                var newInput=document.createElement("input");
                newInput.setAttribute("name","boardcount");
                newInput.setAttribute("value",boardcnt);
                newForm.appendChild(newInput);
                newForm.submit();
            }

            window.onload = function() {
                var newTbody=document. getElementById("tbody");
                var boardIndex;
                var boarCount;//count 값을 저장 할 변수  

                //로그인 된 경우 와 되지 않은 경우에 예외 처리 ????????????????
                if(jsLogCheck != null){//로그인이 되었을 경우  
                    document.getElementById("headerRightUserIdDv").innerHTML="<%=userId%>";
                    document.getElementById("headerRightlogInDiv").style.visibility="hidden";//로그인 버튼 숨김
                }else{//로그인을 하지 않은 경우
                    document.getElementById("headerRightUserIdDv").innerHTML="";
                    document.getElementById("headerRightlogOutDiv").style.visibility="hidden";//로그아웃 버튼 숨김
                    document.getElementById("headerRightlogInDiv").style.visibility="visible";//로그인 버튼 숨김
                }
                ////////////////////////////////////////////////////////////
                // 데이터 베이스에 있는 것을 보여 주기 
                for(var index = 0; index<boardList.length; index++){
                    boardIndex=0;
                    var newTr=document.createElement("tr");
                    newTr.setAttribute("class","tbodyTr");
                    newTbody.appendChild(newTr);

                    var newCountTd=document.createElement("td");
                    newCountTd.setAttribute("class","countTd")
                    newTr.appendChild(newCountTd);
                    newCountTd.innerHTML=boardList[index][boardIndex];
                    boarCount=boardList[index][boardIndex];//count 값을 넣어 주지만 마지막 값만넣어 준다
                    boardIndex++;

                    var newTitleTd=document.createElement("td");
                    newTitleTd.setAttribute("class","titleTd"); 
                    newTr.appendChild(newTitleTd);
                    newTitleTd.innerHTML=boardList[index][boardIndex];
                    boardIndex++;
                    newTitleTd.addEventListener("click", function(){moveBoardConentsEvent(boarCount)});//배열에 마지막 값만 넣어 진다. 그래서 
                    //내가 누른 tr에 count 가 아닌 데이터 베이스에 마지막 인덱스만 넘어 온다 -- > 어떻게 해결 ??

                    var newWriterTd=document.createElement("td");
                    newWriterTd.setAttribute("class","writerTd");
                    newTr.appendChild(newWriterTd);
                    
                    var newWriteDateTd=document.createElement("td");
                    newWriteDateTd.setAttribute("class","writeDateTd");
                    newTr.appendChild(newWriteDateTd);
                    newWriteDateTd.innerHTML=boardList[index][boardIndex];
                }
                console.log(boarCount);
            }

            //사용자가 새로운 글을 쓰기 위해 페이지 이동하는 함수 
            function newWriteEvent(){
                location.href="addPage.jsp";
            }

            //로그 아웃 하기 위해 로그 아웃으로 이동하는 함수 
            function logOutEvent(){
                location.href="logOutModule.jsp";
            }
            function logInEvent(){
                location.href="logPage.jsp";
            }
        </script>
    </body>
</html>
<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("utf-8");
    String count="";
    String resultTitle="";
    String writer="";
    String writeDate="";

    ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();
    ArrayList<String> data=new ArrayList<String>();

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
        <link rel="stylesheet" type="text/css" href="index.css">
        <title>week7 project</title>
    </head>
    <body>
        <h1>show community</h1>
        <header> </header>

        <main>
        <div> </div>
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
            var boardList = <%=dataList%>;
            var boardData = <%=data%>;
            console.log(boardList.length);
            
            window.onload = function() {
                var newTbody=document. getElementById("tbody");
                var boardIndex=0;
                for(var index = 0; index<boardList.length; index++){
                    var newTr=document.createElement("tr");
                    newTr.setAttribute("class","tbodyTr");
                    newTbody.appendChild(newTr);

                    var newCountTd=document.createElement("td");
                    newCountTd.setAttribute("class","countTd")
                    newTr.appendChild(newCountTd);
                    newCountTd.innerHTML=boardData[boardIndex];
                    boardIndex++;


                    var newTitleTd=document.createElement("td");
                    newTitleTd.setAttribute("class","titleTd");
                    newTr.appendChild(newTitleTd);
                    var newA=document.createElement("a");
                    newA.setAttribute("class","newTitleTdA");
                    newA.setAttribute("href","boardContents.jsp")
                    newTitleTd.appendChild(newA);
                    newA.innerHTML=boardData[boardIndex];
                    boardIndex++;

                    var newWriterTd=document.createElement("td");
                    newWriterTd.setAttribute("class","writerTd");
                    newTr.appendChild(newWriterTd);
                    
                    var newWriteDateTd=document.createElement("td");
                    newWriteDateTd.setAttribute("class","writeDateTd");
                    newTr.appendChild(newWriteDateTd);
                     newWriteDateTd.innerHTML=boardData[boardIndex];
                }

            }

            console.log(boardData.length)
        </script>
    </body>
</html>
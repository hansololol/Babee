<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>
<meta charset="UTF-8">
<title>다이어리 상세창(관리자)</title>


<style>

.diaryDetail_admin_tb tr td {
   border:1px solid gray;
   padding: 5px;
}


.diaryDetail_admin_btn {
    background-color: orange; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}


/* 버튼에 호버 효과 */
.diaryDetail_admin_btn:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

 
</style>
</head>

<body>

<div style="width:66%; margin: 0 auto;">
   
   <div>
   <h3 style="display:inline-block;margin-bottom: 5px;">{ 제목 } <span style="color:gray; display:inline-block; font-size:5px;">YYYY-MM-DD</span></h3>
   <hr>   
   </div>
   
   <table class="diaryDetail_admin_tb" widht="100%">
      <tr>
         <td width="200px" style="text-align:center; background:#ffffcc; border:1px solid gray;">작성자</td>
         <td width="90%"> { 작성자 } </td>
      <tr>
         <td width="150" style="text-align:center; background:#ffffcc; border:1px solid gray;">제목</td>
         <td> { 제목 } </td>
      </tr>
      <tr>
         <td width="200px" style="text-align:center; background:#ffffcc; border:1px solid gray;">표지</td>
         <td><img src="images/baby.jpg" widht="300" height="200"/></td>
      </tr>
      <tr>
         <td width="200px" style="text-align:center; background:#ffffcc; border:1px solid gray;">아이의 상태</td>
         <td height="150"> { 아이의 상태입니다. }</td>
      </tr>
      <tr>
         <td width="200px" style="text-align:center; background:#ffffcc; border:1px solid gray;">기록</td>
         <td height="300"> { 기록 내용입니다. }</td>
      </tr>
   </table>
   
   <br><br>
   
   <div style="text-align: -webkit-center;">
    <div class="diaryDetail_admin_btn" style="width: 50px; text-align: center;">
        <a href="다이어리 리스트로" style="display: block; width: fit-content; margin: 0 auto; padding: 5px; text-decoration-line: none; color: black; font-weight: bold;"> 이전 </a>
       </div>


   </div>
   </div>



</body>
</html>
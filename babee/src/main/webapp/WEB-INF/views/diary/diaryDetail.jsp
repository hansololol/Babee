<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>
<meta charset="UTF-8">
<title>다이어리 상세창</title>
<link rel="stylesheet" href="/css/font.css" type="text/css">
<script>
   $(document).ready(function(){
        $("#btnList").click(function(){
            // 페이지 주소 변경(이동)
            location.href = "${contextPath}/diary/diaryList.do";
        });
    })
</script>

<style>
.detail_title h3{
   display: flex;
   margin: 20px auto;
   flex-direction: column-reverse
}

.diaryDetail_tb {
   width: 600px;
   margin: 0 auto;
}
.diaryDetail_tb tr td {
   border:1px solid gray;
   padding: 5px;
}
.diaryDetail_list{
   width: 120px;
   font-weight: bold;
   text-align:center; 
   background:#ffffcc;
   border:1px solid gray;
}
.back_to_List_btn {
    background-color: orange; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 50px;
}


/* 버튼에 호버 효과 */
.back_to_List_btn:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

</style>

</head>

<body>
<div style="width:800px; margin: 0 auto;">
   
   <div class="detail_title">
   <h3>${diary.dir_title} <span style="color:gray; display:inline-block; font-size: 15px;">${diary.dir_writeDate}</span></h3>   
   </div>
   
   <table class="diaryDetail_tb">
      <tr height="80px">
         <td class="diaryDetail_list">작성자</td>
         <td>${memberInfo.member_name}</td>
      <tr height="80px">
         <td class="diaryDetail_list">제목</td>
         <td> ${diary.dir_title} </td>
      </tr>
      <tr height="150px">
         <td class="diaryDetail_list">표지</td>
         <td><img src="${contextPath}/thumbnails.do?goods_id=${diary.member_id}&fileName=${diary.dir_main_img}&fileType=diary" width="100px"></td>
      </tr>
      <tr height="80xp">
         <td class="diaryDetail_list">아이의 상태</td>
         <td> ${diary.baby_condition}</td>
      </tr>
      <tr height="300px">
         <td class="diaryDetail_list">기록</td>
         <td> ${diary.dir_content}</td>
      </tr>
   </table>
   
   <br><br>
   
   <div style="text-align: -webkit-center;">
      <input type="button" value="리스트로 돌아가기" class="back_to_List_btn" id="btnList" >
   
       </div>


   </div>
   </div>



</body>
</html>
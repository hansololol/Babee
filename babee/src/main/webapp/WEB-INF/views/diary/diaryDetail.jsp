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
   function fn_enable(obj){
	document.getElementById("d_title").disabled = false;
   document.getElementById("d_imageFileName").disabled = false;
	document.getElementById("d_condition").disabled = false;
   document.getElementById("d_content").disabled = false;
	document.getElementById("btnList_modify").style.display = "table-row";
	document.getElementById("btnList").style.display = "none";
   }
   function fn_disabled(){
	document.getElementById("d_title").disabled = true;
	document.getElementById("d_imageFileName").disabled = true;
   document.getElementById("d_condition").disabled = true;
   document.getElementById("d_content").disabled = true;
   document.getElementById("btnList_modify").style.display = "none";
	document.getElementById("btnList").style.display = "table-row";
	
	
}
   function fn_modify_diary(obj){
	obj.action = "${contextPath}/diary/modDiary.do";
	obj.submit();
   }

   function readURL(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$('#preview').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

   function backToList(){
	location.href = "${contextPath}/diary/diaryList.do";

   }

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
.btnList{
   margin: 30px auto;
}
.back_to_List_btn {
    background-color: orange; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}


/* 버튼에 호버 효과 */
.back_to_List_btn:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

#btnList_modify{
display:none;
}
</style>

</head>

<body>
<form name="frmDiaryDetail" action="${contextPath}/diary/modDiary.do" method="post" enctype="multipart/form-data">
<div style="width:800px; margin: 0 auto;">
   
   <div class="detail_title">
   <h3>${diary.dir_title} <span style="color:gray; display:inline-block; font-size: 15px;">${diary.dir_writeDate}</span></h3>   
   </div>
   
   <table class="diaryDetail_tb">
      <tr height="80px">
         <input type="hidden" name="dir_no" value="${diary.dir_no}">
         <td class="diaryDetail_list">작성자</td>
         <td><input type="text" value="${memberInfo.member_name}" name="member_id" id="d_id" disabled></td>
      <tr height="80px">
         <td class="diaryDetail_list">제목</td>
         <td><input type="text" value="${diary.dir_title}" name="dir_title" id="d_title" disabled></td>
      </tr>
      <tr height="150px">
         <td class="diaryDetail_list">표지</td>
            <input type="hidden" name="originalFileName" value="${diary.dir_main_img}"/>
         <td> 
            <img src="${contextPath}/thumbnails.do?goods_id=${diary.member_id}&fileName=${diary.dir_main_img}&fileType=diary" width="150px" id="preview">
            <input type="file" name="dir_main_img1" id="d_imageFileName" disabled onchange="readURL(this);"/>
         </td>
      </tr>
      <tr height="80xp">
         <td class="diaryDetail_list">아이의 상태</td>
         <td><input type="text" value="${diary.baby_condition}" name="baby_condition" id="d_condition" disabled></td>
      </tr>
      <tr height="300px">
         <td class="diaryDetail_list">기록</td>
         <td><input type="text" value="${diary.dir_content}" name="dir_content" id="d_content" disabled></td>
      </tr>
   </table>
   
  
   
   <div class="btnList" id="btnList">
      <input type="button" value="목록 보기" onClick="backToList()" >
      <input type="button" value="수정" onClick="fn_enable(this.form)">
      <input type="button" value="삭제">
   </div>

   <div class="btnList_modify" id="btnList_modify">
      <input type="submit" value="수정반영하기" onClick="fn_modify_diary(frmDiaryDetail)">
      <input type="button" value="취소" onClick="fn_disabled(this.form)">
   </div>

   </div>
</form>
</body>
</html>
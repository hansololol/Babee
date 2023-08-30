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
	document.getElementById("btnList_modify").style.display = "inline-block";
	document.getElementById("btnList").style.display = "none";
   }
   function fn_disabled(){
	document.getElementById("d_title").disabled = true;
	document.getElementById("d_imageFileName").disabled = true;
   document.getElementById("d_condition").disabled = true;
   document.getElementById("d_content").disabled = true;
   document.getElementById("btnList_modify").style.display = "none";
	document.getElementById("btnList").style.display = "inline-block";
	
	
}
   function fn_modify_diary(obj){
	obj.action = "${contextPath}/diary/modDiary.do";
	obj.submit();
   }

   function fn_remove_diary(dir_no, dir_main_img_id){
      var formObj = document.createElement("form");
      var d_goods = document.createElement("input");
            d_goods.name = "dir_no";
            d_goods.value = dir_no;
            formObj.appendChild(d_goods);
      var d_img = document.createElement("input");
            d_img.name = "dir_main_img_id";
            d_img.value = dir_main_img_id;
            formObj.appendChild(d_img);
      document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/diary/removeDiary.do";
            formObj.submit();
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
   
   function adminbackToList(){
		location.href = "${contextPath}/admin/order/diaryManageList.do";

	   }

</script>

<style>
.detail_title h3{
   display: flex;
   margin: 20px auto;
   flex-direction: column-reverse
}

.diaryDetail_tb {
   left: 30px;
    top: 30px;
    width: 850px;
    height: 800px;
    background:#ededed;
   
    box-shadow: 25px 25px 39px rgba(0, 104, 255, 0.25);
    border-radius: 50px;
    border-collapse: collapse;
}
.diaryDetail_tb tr{
   border-bottom:1px solid rgba(128, 128, 128, 0.25);
}
.diaryDetail_tb tr:last-child{
   border-bottom: none; /* 마지막 줄의 테두리 제거 */
}

/* '수정','수정반영하기' 버튼 스타일 */
#btnModify {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}
/* 버튼 목록 스타일 */
input[type="button"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}
/* 버튼에 호버 효과 */
#btnModify:hover, input[type="button"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

#btnList{
   margin: 30px auto;
}
#btnList_modify{
display:none;
margin: 30px auto;
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
      <tr style="height: 70px;">
         <input type="hidden" id="d_no" name="dir_no" value="${diary.dir_no}">
         <td width="200">작성자</td>
         <td>
         	<c:choose>
         		<c:when test="${memberInfo.member_id == diary.member_id }">
        			<input type="text" value="${memberInfo.member_name}" name="member_id" id="d_id" disabled>
         		</c:when>
         		<c:when test="${memberInfo.member_id == 'admin' }">
         			<input type="text" value="${diary.member_id}" name="member_id" id="d_id" disabled>
        		</c:when>
        	</c:choose> 
         </td>
      <tr style="height: 70px;">
         <td width="200">제목</td>
         <td><input type="text" value="${diary.dir_title}" name="dir_title" id="d_title" disabled></td>
      </tr>
      <tr>
         <td width="200">표지</td>
            <input type="hidden" name="originalFileName" value="${diary.dir_main_img}"/>
         <td> 
            <img src="${contextPath}/thumbnails.do?goods_id=${diary.member_id}&fileName=${diary.dir_main_img}&fileType=diary&dir_no=${diary.dir_no}" width="250px" id="preview">
            <input type="file" name="dir_main_img1" id="d_imageFileName" disabled onchange="readURL(this);"/>
         </td>
      </tr>
      <tr>
         <td width="200">아이의 상태</td>
         <td><textarea name="baby_condition" rows = "4" cols="65" maxlength="4000" id="d_condition" disabled >${diary.baby_condition}</textarea></td>
         
      </tr>
      <tr>
         <td width="200">기록</td>
         <td><textarea name="dir_content" rows = "10" cols="65" maxlength="4000" id="d_content" disabled >${diary.dir_content}</textarea></td>
         <input type="hidden" name="dir_main_img_id" value="${diary.dir_main_img_id}">
      </tr>
   </table>
   
  
   <c:choose>
         		<c:when test="${memberInfo.member_id == diary.member_id }">
        			<div id="btnList">
     					 <input type="button" value="수정" onClick="fn_enable(this.form)" id="btnModify">
     					 <input type="button" value="삭제" onClick="fn_remove_diary('${diary.dir_no}', '${diary.dir_main_img_id}')">
     					 <input type="button" value="목록 보기" onClick="backToList()" >
   					</div>
         		</c:when>
         		<c:when test="${memberInfo.member_id == 'admin' }">
         				<br>
         			 <input type="button" value="목록 보기" onClick="adminbackToList()" >
         			 	<br>
        		</c:when>
        	</c:choose> 
   
   
   <div id="btnList_modify" style="margin: 30px auto;">
      <input type="submit" value="수정반영하기" onClick="fn_modify_diary(frmDiaryDetail)" id="btnModify">
      <input type="button" value="취소" onClick="fn_disabled(this.form)">
   </div>
</div>
</form>
</body>
</html>
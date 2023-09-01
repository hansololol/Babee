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
	document.querySelector("#add").style.display = "block";
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
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 850px;
            margin: 50px auto;
            /* background: #ededed; */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }

        .text-center {
            text-align: center;
            margin-bottom: 10px;
        }

        img#line {
            display: block;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            /* border: 1px solid #ccc; */
            border: none;
            border-radius: 5px;
        }

        input[type="file"] {
            padding: 0;
        }

        textarea {
            resize: vertical;
        }

        .image-preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
        }

        .btn-container {
            text-align: center;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #ffcd29;
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #cca300;
        }
        
        .file-label {
        display: inline-block;
        background-color: #ffcd29;
        color: black;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-bottom: 15px;
        transition: background-color 0.3s;
        position: relative;
        overflow: hidden;
    }

    .file-label span {
        display: inline-block;
        vertical-align: middle;
        margin-right: 10px;
    }

    .file-label:hover {
        background-color: #cca300;
    }

    .file-info {
        font-size: 12px;
        color: #666;
        margin-top: 5px;
    }

    .image-preview {
        max-width: 100%;
        max-height: 250px;
       
        margin-top: 10px;
    }

    .file-input {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
    }

    .file-input-label {
        /* display: flex; */
        /* align-items: center; */
        justify-content: center;
        
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
  		<div class="container" style="border:1px solid lightgray;  padding:40px;">
        	<h1 class="text-center">다이어리</h1>
        	<h4 class="text-center" style="color: #996633;">작은 발자국, 큰 사랑의 다이어리</h4>
        	<img id="line" src="/image/line.png" alt="줄 출력">
        <br><br>
      
         <input type="hidden" id="d_no" name="dir_no" value="${diary.dir_no}">
         <label style="text-align:left;">작성자</label>        
         	<c:choose>
         		<c:when test="${memberInfo.member_id == diary.member_id }">
        			<input type="text" value="${memberInfo.member_name}" name="member_id" id="d_id" style="border:none;" disabled>
         		</c:when>
         		<c:when test="${memberInfo.member_id == 'admin' }">
         			<input type="text" value="${diary.member_id}" name="member_id" id="d_id" disabled>
        		</c:when>
        	</c:choose> 
         <hr>
          <label style="text-align:left;">제목</label>        
       		<div class="form-group">
                <input type="text" name="dir_title" value="${diary.dir_title} "  id="d_title" disabled>
            </div>
     	 <hr>
     	
     	<label style="text-align:left;">표지</label>  
       <div class="form-group" style="border: 1px solid lightgray; border-radius: 5px; padding: 20px; background: azure;">
               <div class="file-input-label">
                   
               <input type="hidden" name="originalFileName" value="${diary.dir_main_img}"/>
            <label for="d_imageFileName" style="width: 50px;">
            
             <img src="${contextPath}/image/add.png" alt="파일 선택" width="30" height="30" style="cursor: pointer; display: none;" id="add"></label>
           	<input type="file" class="file-input" id="d_imageFileName" name="dir_main_img1" onchange="readURL(this);" disabled>
                   
            <img src="${contextPath}/thumbnails.do?goods_id=${diary.member_id}&fileName=${diary.dir_main_img}&fileType=diary&dir_no=${diary.dir_no}" width="250px" id="preview">
              
               
    	</div></div>
         <hr>
     
        <label style="text-align:left;">아이의 상태</label> 
         <textarea name="baby_condition" rows = "4" cols="65" maxlength="4000" id="d_condition" disabled >${diary.baby_condition}</textarea>
         
      	<hr>
      <label style="text-align:left;">기록</label> 
         <textarea name="dir_content" rows = "10" cols="65" maxlength="4000" id="d_content" disabled >${diary.dir_content}</textarea>
         <input type="hidden" name="dir_main_img_id" value="${diary.dir_main_img_id}">
     
   
  
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
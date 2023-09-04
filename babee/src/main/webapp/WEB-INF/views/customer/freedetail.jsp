<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<meta charset="UTF-8">
<title>자유게시판 상세창</title>

<script>
function readURL(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$('#preview').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}
</script>
   
   <style>
      /* 전체 스타일은 여기에 기존 스타일 코드를 놔두고, 원하는 영역에 클래스 스타일을 추가합니다 */
      .custom-style {
         display: flex;
         justify-content: center;
         align-items: center;
         flex-direction: column;
         padding: 86px 16%;
      }

      /* 추가된 클래스 스타일 */
      .post-container {
         width: 70%;
         margin: 20px auto;
      }

      .post-container h1 {
         text-align: left;
         font-size: 24px;
         display: inline-block; /* 텍스트와 버튼을 나란히 배치하기 위한 속성 */
      }

      .post-container .delete-button {
         float: right;
         margin-top: 10px;
      }

      .post-container hr {
         margin-top: 10px;
         margin-bottom: 20px;
      }

      .post-container .meta-info {
         text-align: right;
         font-size: 14px;
         color: #888;
      }

      .post-container .main-image {
         text-align: center;
         margin-top: 20px;
      }

      .post-container .main-image img {
         max-width: 100%;
         max-height: 400px;
      }

      .post-container .content {
         margin-top: 20px;
         text-align: left;
      }

      .post-container .comment-container {
         margin-top: 30px;
         text-align: left;
      }

      .post-container .comment {
         border: 1px solid gray;
         padding: 10px;
         margin-top: 10px;
         background-color: #f5f5f5;
         position: relative;
      }

      .post-container .comment-delete {
         position: absolute;
         top: 5px;
         right: 10px;
         font-size: 16px;
         cursor: pointer;
      }

      .post-container .comment-info {
         font-size: 14px;
         color: #888;
         margin-bottom: 5px;
      }

      .post-container .comment-form {
         margin-top: 20px;
      }

      .post-container textarea {
         width: 80%;
         padding: 10px;
         border: 1px solid rgba(128, 128, 128, 0.25);
         border-radius: 5px;
         box-sizing: border-box;
         margin-top: 10px;
      }

      .post-container button {
         background-color: #fef7dd;
         color: black;
         border: none;
         border-radius: 5px;
         padding: 10px 20px;
         font-size: 16px;
         cursor: pointer;
         margin-top: 10px;
         transition: background-color 0.3s;
         
      }

      .post-container button:hover {
         background-color: orange;
      }
   </style>

     <script>
      function fn_remove_freeboard(articleNO, free_img_id){
          var formObj = document.createElement("form");
          var d_goods = document.createElement("input");
                d_goods.name = "articleNO";
                d_goods.value = articleNO;
                formObj.appendChild(d_goods);
          var d_img = document.createElement("input");
                d_img.name = "free_img_id";
                d_img.value = free_img_id;
                formObj.appendChild(d_img);
          document.body.appendChild(formObj);
                formObj.method = "post";
                formObj.action = "${contextPath}/community/removeFreeboard.do";
                formObj.submit();
       }
      
      function fn_comment(obj) {

    	    if(! isLogOn){
    	        alert("로그인 이후 이용 가능한 서비스입니다.");
    	        location.replace("${contextPath}/member/loginForm.do")
    	    } else {
    	    	alert("댓글을 등록하시겠습니까?");
    	    	obj.submit();
    	    }
    	    }
      
   </script> 
   
    <script>
      function fn_remove_freeboard(articleNO, free_img_id){
          var formObj = document.createElement("form");
          var d_goods = document.createElement("input");
                d_goods.name = "articleNO";
                d_goods.value = articleNO;
                formObj.appendChild(d_goods);
          var d_img = document.createElement("input");
                d_img.name = "free_img_id";
                d_img.value = free_img_id;
                formObj.appendChild(d_img);
          document.body.appendChild(formObj);
                formObj.method = "post";
                formObj.action = "${contextPath}/community/removeFreeboard.do";
                formObj.submit();
       }
      
      function fn_mod_freeboard(articleNO, free_img_id){
          var formObj = document.createElement("form");
          var d_goods = document.createElement("input");
                d_goods.name = "articleNO";
                d_goods.value = articleNO;
                formObj.appendChild(d_goods);
          var d_img = document.createElement("input");
                d_img.name = "free_img_id";
                d_img.value = free_img_id;
                formObj.appendChild(d_img);
          document.body.appendChild(formObj);
                formObj.method = "post";
                formObj.enctype = "multipart/form-data";
                formObj.action = "${contextPath}/community/modFreeboardForm.do";
                formObj.submit();
       }
   </script> 
   
   
</head>
<body>
   <div class="custom-style">
      <h3>자유게시판</h3><br>
      <div class="post-container">

         <!-- 게시글 삭제 버튼 -->
         <c:choose>
         	<c:when test="${isLogOn == true }">
         		<c:if test="${memberInfo.member_id == freeboard.member_id  || memberInfo.member_id == 'admin' }">
       			<input type="button" value="삭제" style="float:right;" onClick="fn_remove_freeboard('${freeboard.articleNO}', '${freeboard.free_img_id}')">
  			</c:if>
			</c:when>
			
			<c:when test="${isLogOn == true }">
			<c:if test="${memberInfo.member_id == freeboard.member_id}">
			     			<input type="button" value="수정" style="float:right;" onClick="fn_mod_freeboard('${freeboard.articleNO}', '${freeboard.free_img_id}')">
			</c:if>
			</c:when>
         </c:choose>

        <p style="font-size: 25px; text-align: left; padding-left: 23px;">${freeboard.free_title}</p>
         <hr>
         <div class="meta-info">
            <p>작성자: ${freeboard.member_id} </p>
            <p>작성일: ${freeboard.free_writeDate }</p>
         </div>
         <div class="main-image">
            <c:if test="${freeboard.free_img != ''}">
           <img src="${contextPath}/thumbnails.do?goods_id=${freeboard.member_id}&fileName=${freeboard.free_img}&fileType=freeboard&articleNO=${freeboard.articleNO}" width="400px" id="preview">
         </c:if>
            </div>
         <div class="content">
            <p style="padding-left: 30px;">${freeboard.free_content }</p>
         </div>
         <hr>
         
         <div class="comment-container" id="commentList" style="background:#e6e6e6; padding-top:30px; padding-bottom: 40px;">
     	        <c:forEach var="comment" items="${commentList}">
     	       		<ul>
            		<li> <strong>${comment.member_id}</strong> </li>
             		<li> ${comment.free_comment} </li>
             		
             		
 					</ul>
 					<hr>
 				</c:forEach>
 			
 			<form id="comment" method="post" action="${contextPath}/community/addCommnet.do" novalidate="novalidate" >
					<div class="comment-form">
						<p style="text-align: left; margin-bottom: 0px; margin-left: 20px;">댓글	작성</p>
						<textarea id="commentText" name="free_comment" rows="4" cols="50" style="width: 95%; margin-left: 20px;"></textarea>					
						<button type="button" onclick="fn_comment(this.form)" style="margin-left: 90%; padding: 5px 10px; background-color: #fef7dd; color: black; border: none; border-radius: 4px; cursor: pointer;" >등록</button>
					</div>
			</form>
    
          </div>
      </div>
  
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>
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
 <!--   
   function addComment() {
	    var commentText = document.getElementById('commentText').value;
	    if (commentText.trim() === '') {
	        alert('댓글 내용을 입력하세요.');
	        return;
	    }

	    var currentDate = new Date();
	    var formattedDate = currentDate.toLocaleString();

	    var commentContainer = document.createElement('div');
	    commentContainer.className = 'comment';
	    commentContainer.innerHTML = '<div class="comment-info">작성자: 사용자 아이디 | 작성일: ' + formattedDate + '</div><p>' + commentText + '</p><span class="comment-delete" onclick="deleteComment(this)">❌</span>';

	    var commentList = document.getElementById('commentList');
	    commentList.appendChild(commentContainer);

	    document.getElementById('commentText').value = '';

	    // Ajax를 사용하여 댓글을 서버로 전송
	    var xhr = new XMLHttpRequest();
	    xhr.open('POST', '/addCommnet.do', true); // 수정된 엔드포인트
	    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4) {
	            if (xhr.status === 200) {
	                // 서버에서 응답을 받았을 때 수행할 동작
	                console.log('댓글이 성공적으로 전송되었습니다.');
	            } else {
	                // 에러 처리
	                console.log('댓글 전송에 실패했습니다.');
	            }
	        }
	    };
	    var data = JSON.stringify({ content: commentText, date: formattedDate });
	    xhr.send(data);
	}

      
      -->
      <script>
      function fn_remove_diary(articleNO, free_img_id){
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
   </script> 
   
   
</head>
<body>
   <div class="custom-style">
      <div class="post-container">
         <h1>자유게시판</h1>
         <!-- 게시글 삭제 버튼 -->
         <c:choose>
         	<c:when test="${isLogOn == true }">
         		<c:if test="${memberInfo.member_id == freeboard.member_id }">
       			<input type="button" value="삭제" style="float:right;" onClick="fn_remove_diary('${freeboard.articleNO}', '${freeboard.free_img_id}')">
				</c:if>
			</c:when>
         </c:choose>
        <p>${freeboard.free_title}</p>
         <hr>
         <div class="meta-info">
            <p>작성자: ${freeboard.member_id} </p>
            <p>작성일: ${freeboard.free_writeDate }</p>
         </div>
         <div class="main-image">
           <img src="${contextPath}/thumbnails.do?goods_id=${freeboard.member_id}&fileName=${freeboard.free_img}&fileType=freeboard&articleNO=${freeboard.articleNO}" width="400px" id="preview">
           
            </div>
         <div class="content">
            <p>${freeboard.free_title }</p>
         </div>
         <hr>
         
         <div class="comment-container" id="commentList" style="background:#e6e6e6; padding-top:30px; padding-bottom: 40px;">
     	        <c:forEach var="comment" items="${commentList}">
     	       		<ul>
            		<li> <strong>${comment.member_id}</strong> </li>
             		<li> ${comment.free_comment} </li>
             		<%-- <td> ${comment.free_commentDate}  </td> --%>
 					</ul>
 					<hr>
 				</c:forEach>
 				
      	<form id="comment" method="post" action="${contextPath}/community/addCommnet.do" novalidate="novalidate" >
					<div class="comment-form">
						<p style="text-align: left; margin-bottom: 0px; margin-left: 20px;">댓글	작성</p>
						<textarea id="commentText" name="free_comment" rows="4" cols="50" style="width: 95%; margin-left: 20px;"></textarea>

						<input type="submit" value="작성" style="margin-left: 90%; padding: 5px 10px; background-color: #fef7dd; color: black; border: none; border-radius: 4px; cursor: pointer;" />
					</div>
				</form>
          </div>
      </div>
  
</body>
</html>
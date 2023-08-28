<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>게시글 상세 페이지</title>
   
   <link rel="stylesheet" href="/css/font.css" type="text/css">

   <style>
      /* 전체 스타일은 여기에 기존 스타일 코드를 놔두고, 원하는 영역에 클래스 스타일을 추가합니다 */
      .custom-style {
         display: flex;
         justify-content: center;
         align-items: center;
         flex-direction: column;
         padding: 20px;
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
         width: 100%;
         padding: 10px;
         border: 1px solid rgba(128, 128, 128, 0.25);
         border-radius: 5px;
         box-sizing: border-box;
         margin-top: 10px;
      }

      .post-container button {
         background-color: #fef7dd;
         color: gray;
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
   <script>
      function deletePost() {
         var confirmDelete = confirm("정말로 이 게시글을 삭제하시겠습니까?");
         if (confirmDelete) {
            // 게시글 삭제 로직을 여기에 구현합니다
            alert("게시글이 삭제되었습니다.");
            // 서버로 게시글 삭제 요청을 보내는 등의 처리를 추가할 수 있습니다
         }
      }
   </script>
</head>
<body>
	<form action="${contextPath}/community/modinfoForm.do?articleNO=${infoboard.articleNO}&page=adminPage" enctype="multipart/form-data">
 	<input type="hidden" value="${infoboard.articleNO}" name="articleNO"/>
   <div class="custom-style">
      <div class="post-container">
         <h1>공지사항</h1>
         <!-- 게시글 삭제 버튼 -->
        <a href="/community/deleteInfo.do?articleNO=${infoboard.articleNO}" style="color: red;" onclick="return confirm('삭제하시겠습니까?');"><span style="font-size: 20px; float:right;">&#128683;삭제</span> </a>
			<p>${infoboard.info_title}</p>
			<input type="hidden" value="${infoboard.info_title}" id="i_title"/>
         <hr>
         <div class="meta-info">
            <p>작성자: ${infoboard.member_id }</p>
         </div>
         <div class="main-image">
            <img src="${contextPath}/thumbnails.do?goods_id=${infoboard.member_id}&fileName=${infoboard.info_img}&fileType=info&articleNO=${infoboard.articleNO}" width="400px" id="preview">
          <input type="hidden" value="${infoboard.info_img}" id="i_imageFileName"/>
         </div>
         <div class="content">
            <p>${infoboard.info_content }</p>
            <input type="hidden" value="${infoboard.info_content}" id="i_content"/>
         </div>
         <hr>
         <button type="button" onclick="window.location.href='/community/admininfolist.do?page=adminPage';" style="width:120px; height:45px; margin-top:-50px;">뒤로가기</button>
         <input type="submit" style="width:120px; height:45px; margin-top:-50px;" value="수정">
 
 
 
         

</div>
      </div>
</form>
</body>
</html>
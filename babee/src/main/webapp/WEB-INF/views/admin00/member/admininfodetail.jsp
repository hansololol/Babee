<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>게시글 상세 페이지</title>
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
   <div class="custom-style">
      <div class="post-container">
         <h1>공지사항</h1>
         <!-- 게시글 삭제 버튼 -->
         <button class="delete-button" type="button" onclick="deletePost()" style="width:120px; height:45px; margin-top:-50px;">게시글 삭제</button>

         <hr>
         <div class="meta-info">
            <p>작성자: 게시글 작성자</p>
            <p>작성일: 게시글 작성일</p>
         </div>
         <div class="main-image">
            <img src="image/Babee_Logo.png">
         </div>
         <div class="content">
            <p>게시글 내용이 여기에 들어갑니다.</p>
         </div>
         <hr>
         <button type="button" onclick="window.location.href='/member/admininfolist.do?page=adminPage';" style="width:120px; height:45px; margin-top:-50px;">뒤로가기</button>
         
      </div>
   </div>
</body>
</html>
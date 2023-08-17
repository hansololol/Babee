<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 자주하는질문 작성창</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
   /* 전체 스타일은 여기에 기존 스타일 코드를 놔두고, 원하는 영역에 클래스 스타일을 추가합니다 */
   .custom-style {
      display: flex;
      justify-content: center;
      align-items: center;
   }

   /* 추가된 클래스 스타일 */
   .form-container {
      width: 70%;
      margin: 20px auto;
   }

   .form-container table {
      width: 90%;
      border-collapse: collapse;
      
      margin: 0 auto;
      margin-top: 10px;
   }

   .form-container th,
   .form-container td {
      text-align: center;
      padding: 10px;
      border: 1px solid gray; /* 추가된 스타일 */
   }

   .form-container th {
      background-color: #ffffcc;
      width: 20%;
   }

   .form-container td {
      width: 80%;
   }

   .form-container input[type="text"],
   .form-container select,
   .form-container textarea,
   .form-container input[type="file"] {
      width: 100%;
      padding: 10px;
      border: 1px solid rgba(128, 128, 128, 0.25);
      border-radius: 5px;
      box-sizing: border-box;
      margin-left: -10px;
   }

   .form-container select {
      margin-left: -3px;
   }

   .form-container textarea {
      width: 100%;
      height: 100px;
      resize: vertical;
   }

   .form-container .file-preview img {
      width: 200px;
      height: auto;
      margin: 10px 0;
   }

   .form-container .btn-container {
      margin-top: 10px;
      text-align: center;
   }

   .form-container button,
   .form-container a {
      background-color: orange;
      color: white;
      border: none;
      border-radius: 20px;
      padding: 10px 30px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 20px;
      transition: background-color 0.3s;
      text-decoration: none;
      display: inline-block;
   }

   .form-container button:hover,
   .form-container a:hover {
      background-color: #ff7e00;
   }
</style>
<script>
   $(document).ready(function() {
      $('input[name="imageUpload"]').on('change', function(event) {
         var file = event.target.files[0];
         var reader = new FileReader();
         reader.onload = function(e) {
            $('.file-preview').html('<img src="' + e.target.result + '" alt="Preview">');
         };
         reader.readAsDataURL(file);
      });
   });
</script>
</head>
<body>
<div class="custom-style">
   <form class="form-container" method="post" action="${contextPath}/main.do" enctype="multipart/form-data">
      <h1 style="text-align: center;">공지사항</h1>
      <h3 style="text-align: center;">작성페이지</h3>
      <hr>
      
      <div>
         <table>
            <tr>
               <th>작성자</th>
               <td><input type="text" name="author"></td>
            </tr>
            
            <tr>
               <th>제목</th>
               <td><input type="text" name="title"></td>
            </tr>
            
            
            <tr>
               <th>문의내용</th>
               <td>
                  <div style="padding: 10px 0;">
                     <textarea name="inquiryContent"></textarea>
                  </div>
               </td>
            </tr>
   
            <tr>
               <th>이미지 업로드</th>
               <td>
                  <input type="file" name="imageUpload">
               </td>
            </tr>
            <tr>
               <th>이미지 미리보기</th>
               <td class="file-preview"></td>
            </tr>
         </table>
      </div>
      <br>
      <div class="btn-container">
         <button type="submit">작성하기</button>
         <a href="/member/admininfolist.do">뒤로가기</a>
      </div>
   </form>
</div>
</body>
</html>
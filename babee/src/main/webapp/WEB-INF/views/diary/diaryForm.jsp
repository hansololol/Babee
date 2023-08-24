<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>
<meta charset="UTF-8">
<title>다어이리 작성창</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input){
      if(input.files && input.files[0]){
         var reader = new FileReader();
         reader.onload = function(e){
            $('#preview').attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }
   
   function backToList(obj){
      obj.action = "${contextPath}/board/listArticles.do";
      obj.submit();
   }
   
   
</script>

<style>
.text_center{ 
   text-align:center;
   }

.tb {
    left: 30px;
    top: 30px;
    width: 850px;
    height: 800px;
    background:#ededed;
   
    box-shadow: 25px 25px 39px rgba(0, 104, 255, 0.25);
    border-radius: 50px;
    border-collapse: collapse;
    
    
}

 .tb tr{
 border-bottom:1px solid rgba(128, 128, 128, 0.25);
 }
.tb tr:last-child {
    border-bottom: none; /* 마지막 줄의 테두리 제거 */
}

/* '작성하기' 버튼 스타일 */
input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '다시입력' 버튼 스타일 */
input[type="reset"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}
 
  
 
</style>
</head>
<body>

<form method="post" action="${contextPath}/diary/addDiary.do" enctype="multipart/form-data">
   <div style="text-align: center;">
   <h1 class="text_center">다이어리</h1>
   <h4 class="text_center" style="color:#996633;">작은 발자국, 큰 사랑의 다이어리</h4>
   <img src="/image/line.png" style="margin: 0 auto; display: block;" alt="줄 출력">
   </div>
   
   <br><br><br>
   <table class="tb" align="center">
      
      <tr style="height: 70px;">

         <td width="200">작성자</td>
         <td width="250"> <input type="text"  value="${memberInfo.member_name}" disabled></td>
                        <input type="hidden" name="member_id" value="${memberInfo.member_id}" ></td>
      </tr>
      
      <tr style="height: 70px;">
         <td width="200"> 제목</td>
         <td width="250"> <input type="text" name="dir_title" > </td>
      </tr>
   
      <tr>
         <td align="center">표지 </td>
         <td width="200"><input type="file" name="dir_main_img1" onChange="readURL(this);"/> 
            <p style="font-size:12px">&nbsp;다음 파일 형식만 지원됩니다.<br>
            <p style="font-size:12px">&nbsp;.jpg(JPEG), .png(Portable Network Graphics), .gif(Graphics Interchange Format)
         </td>
         <td width="250" height="200"><img id="preview" src="#" width=200 height=200 /></td>
      </tr>

      <tr>
         <td width="200">아이의 상태</td>
         <td colspan = "2"><textarea name="baby_condition" rows = "4" cols="65" maxlength="4000" ></textarea> </td>
      </tr>
      <tr>
         <td width="200">기록</td>
         <td colspan = "2"><textarea name="dir_content" rows = "10" cols="65" maxlength="4000" ></textarea></td>
      </tr>
   </table>
   <br><br><br><br><br>
      <div style="text-align: center;">
   <input type="submit" value="작성하기">&nbsp;&nbsp;&nbsp;
   <input type="reset" value="다시입력">
      </div>
</form>
<br><br><br><br><br>

</body>
</html>
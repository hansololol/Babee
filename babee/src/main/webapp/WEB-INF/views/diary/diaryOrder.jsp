<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>다어이리 주문창</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">

   function backToList(obj){
      obj.action = "${contextPath}/member/diaryList.do";
      obj.submit();
   }
   
   
</script>

<style>
.text_center{ 
   text-align:center;
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
input[type="button"] {
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

<form method="post" action="${contextPath}/goods/orderGoodsForm.do" enctype="multipart/form-data">
   <div style="text-align: center;">
   <h1 class="text_center">다이어리</h1>
   <h4 class="text_center" style="color:#996633;">작은 발자국, 큰 사랑의 다이어리</h4>
   <img src="/image/line.png" style="margin: 0 auto; display: block;" alt="줄 출력">
   <br>
   <h2 class="text_center">이달의 다이어리</h2>
   </div>
   <br>
   <p class="text_center"> 제작될 다이어리의 커버입니다.
   
   
<div class="text_center" style="position: relative; text-align: center;">
    <img src="/image/diary_cover2.png" />
    <div class="text_center" style="position: absolute; top: 152px; left: 50%; transform: translateX(-50%);">
        <img src="/image/baby.jpg" width="372px" height="270px" />
    </div>
</div>

   <br>
   <div style="text-align: center;">
         <input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;
          <input type="button" value="이전" onclick="fn:backToList(this.form)">
   </div>

</form>
<br><br><br><br><br><br><br>
</body>
</html>
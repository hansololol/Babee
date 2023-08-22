<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />


<head>
<style>
.text_center{ 
   text-align:center;
   margin: 0 auto;
   }

.del_notice {
    text-align:center;
   margin: 0 auto;
   border: 1px solid #444444; /* 테두리 설정 */
    padding: 20px; /* 내부 여백 설정 */
    border-radius: 15px;
}

/* '탈퇴하기' 버튼 스타일 */
.del_btn > a {
   background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 24px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
}


/* 버튼에 호버 효과 */
.del_btn > a:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}



</style>
<script>
   function delMember(){
      var password = document.getElementById('inPassword').value;
      console.log(password);
      location.href="${contextPath}/member/memberDel.do?member_pw=" +password
   }
</script>

<title>마이페이지 메인창</title>

</head>
<body>


<form>
<div class="text_center" style="width:66%;">

   <div style="text-align:left;">
      <img src="/image/people.png" style="display:inline-block; margin-block-end: -6px;" width="30"/>
      <h3 style="display:inline-block;">회원탈퇴</h3>
   <hr>
   <br>
   </div>
   
   <br>
   <div class="del_notice" border="1">
      <img src="/image/Babee_Logo.png" />
      
      <p> 소중한 회원님, <br><br>
          저희 서비스를 이용해 주셔서 감사합니다. <br><br>
          회원 탈퇴 시, 사용자님의 개인 정보는 모두 삭제됩니다. <br><br>
          아래 비밀번호를 입력 후 '회원탈퇴'를 클릭하여 완료하시면 됩니다.<br><br>
          더 나은 서비스로 보답하고자 항상 노력하고 있습니다.<br><br>
          감사합니다.<br><br>
        <b>Babee</b>드림</p>  
        
        <input type="password" placeholder="비밀번호를 입력해 주세요." id="inPassword"/> <br><br><br>
         <div class="del_btn">
    <a href="javascript:delMember()"><b><span>탈퇴하기</span></b> 
   
   
   </div>
   
   </div>
   <br><br>

</div>
</form>
</body>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
<script>

</script>
</c:if>
<style>

	.member_cont {
	    padding: 20px 100px;
    border: 1px solid #dbdbdb;
	width: 690px;
	margin: 0 auto;
}
 .login_input_sec > div {
    float: left;
}
	.login_input_sec input {
		display: block;
		width: 280px;
		height: 36px;
		margin: 0 0 3px 16px;
		padding: 0 0 0 18px;
		border: 1px solid #d0d0d0;
		color: #979d9d;
	}
	.login_input_sec > button {
		float: right;
		width: 158px;
		height: 80px;
		margin: 0 20px 15px 0;
		border: 1px solid #FEF7DD;
		background: #FEF7DD;
		color: #ffffff;
		font-size: 15px;
		font-weight: bold;
		cursor: pointer;
	}
	.btn_member_join {
		width: 110px;
		height: 45px;
		margin: 0;
		color: #ffffff;
		font-size: 14px;
		border: 1px solid #666666;
		background: #666666;
		cursor: pointer;
		font-weight: bold;
	}
	.btn_member_white {
		width: 110px;
		height: 45px;
		color: #3e3d3c;
		font-weight: bold;
		font-size: 13px;
		border: 1px solid #cccccc;
		background: #fff;
		cursor: pointer;
	
	}
	
	.btn_login_box {
    
    margin: 20px 0 0 -35px;
    padding: 10px 0 0 0;
    border-top: 1px solid #dcdcdc;
}
.btn_login_box ul{
	display: -webkit-inline-box;
}
	
	</style>

<script>
  
	var falseLog = '${falseLog}';
	 
	 if(falseLog=='falseLog'){
	  alert("아이디/비밀번호가 올바르지 않습니다. 다시 입력해주세요");
	 }
  
	</script>
</head>
<body>
	<br><br><br><br>
	<div class="content_box">
		<div class="member_wrap">
			<div class="member_tit">
				<h2>로그인</h2>
			</div>
			<!-- //member_tit -->
	<div class="member_cont">

		<form id="formLogin" method="post" action="${contextPath}/member/login.do" novalidate="novalidate">
			
			<div class="member_login_box">
				<img src="/image/Babee_Logo.png"><br><br>
				<div class="login_input_sec">
					<div>
						<input type="text" id="loginId" name="member_id" placeholder="아이디" required="true" aria-required="true">
						<input type="password" id="loginPwd" name="member_pw" placeholder="비밀번호" required="true" aria-required="true">
					</div>
					 <button type="submit" class="member_login_order_btn">로그인</button> 
				</div>
			</div>
		</form>
			<!-- //login_box -->
			<div class="member_sns_login">
				
				<a href="#" class="btn_naver_login js_btn_naver_login" data-naver-url="https://socialmember.godo.co.kr/NaverLogin/naver_api.php?mode=login&amp;response_type=code&amp;client_id=k0VcGSUFEXqRJqP80ryh&amp;redirect_uri=https%3A%2F%2Fmall.suomi.co.kr%2F&amp;state=e1628eb01a5c7d245df9ebe8ccb06a7c"><img src="https://cdn-pro-web-219-28.cdn-nhncommerce.com/malltr2083_godomall_com/data/skin/front/moment/img/etc/pc_naver.png" alt="네이버 아이디 로그인"></a><br>
				
				<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
  integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
<script>
  Kakao.init('881cd43e5724e04602b618321bb393c1'); // 사용하려는 앱의 JavaScript 키 입력
</script>

<a class="btn_kakao_login js_btn_kakao_login" id="kakao-login-btn" href="javascript:loginWithKakao()"> <img src="https://cdn-pro-web-219-28.cdn-nhncommerce.com/malltr2083_godomall_com/data/skin/front/moment/img/etc/pc_kakao.png" alt="카카오 아이디 로그인"></a>
<p id="token-result"></p>

<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/kakao/callback',
    });
  }
				
		</script>
				</div>
			<div class="btn_login_box">
				<ul>
					<li><button id="btnJoinMember" class="btn_member_join" onclick="location.href='${contextPath}/member/memberForm.do'" >회원가입</a></button></li>
					<li><button id="btnFindId" class="btn_member_white" onclick="location.href='${contextPath}/seller/sellerForm.do'">사업자 가입</button></li>
					<li><button id="btnFindId" class="btn_member_white" onclick="location.href='${contextPath}/member/findId.do'" style="width: 147px;">아이디/비밀번호 찾기</button></li>
				
				</ul>
			</div>
			<!-- //btn_login_box -->
		

	</div>
</div>
</div>
<br><br><br><br><br><br><br>
</body>
</html>
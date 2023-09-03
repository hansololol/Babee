<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" isELIgnored="false" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="/css/font.css" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:if test="${not empty message }">
      <script></script>
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
        border: 1px solid #fef7dd;
        background: #fef7dd;
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
      .btn_login_box ul {
        display: -webkit-inline-box;
      }
    </style>

    <script>
      var falseLog = "${falseLog}";

      if (falseLog == "falseLog") {
        alert("아이디/비밀번호가 올바르지 않습니다. 다시 입력해주세요");
      }
    </script>
  </head>
  <body>
    <br /><br /><br /><br />
    <div class="content_box">
      <div class="member_wrap">
        <div class="member_tit">
          <h2>로그인</h2>
        </div>
        <!-- //member_tit -->
        <div class="member_cont">
          <form
            id="formLogin"
            method="post"
            action="${contextPath}/member/login.do"
            novalidate="novalidate"
          >
            <div class="member_login_box">
              <img src="/image/Babee_Logo.png" /><br /><br />
              <div class="login_input_sec">
                <div>
                  <input
                    type="text"
                    id="loginId"
                    name="member_id"
                    placeholder="아이디"
                    required="true"
                    aria-required="true"
                  />
                  <input
                    type="password"
                    id="loginPwd"
                    name="member_pw"
                    placeholder="비밀번호"
                    required="true"
                    aria-required="true"
                  />
                </div>
                <button type="submit" class="member_login_order_btn">
                  로그인
                </button>
              </div>
            </div>
          </form>
          <!-- //login_box -->

          <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


    <div class="member_sns_login"
             >
              <div id="naverIdLogin"></div> 
              <script type="text/javascript">
              const naverLogin = new naver.LoginWithNaverId(
                      {
                          clientId: "g9MhutSOy0o5MqWSol0E",
                          callbackUrl: "http://localhost:8080/member/loginForm.do",
                          loginButton: {color: "green", type: 2, height: 0}
                      }
                  );
           	   naverLogin.init(); // 로그인 설정
  
                naverLogin.getLoginStatus(function (status) {
                    if (status) {
                        var nickName=naverLogin.user.getNickName();
                        var email=naverLogin.user.getEmail();
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "${contextPath}/member/naver.do",
                            data: { 'nickName': nickName, 'email':email },
                            dataType: 'text',
                            success: function (result) {
                            	window.location.replace("${contextPath}/main/main.do");
                            }
                           
                        });
                    }
                    });
                        
                $(document).on("click", "#naverLogin", function () {
                    var btnNaverLogin =
                      document.getElementById("naverIdLogin").firstChild;
                    btnNaverLogin.click();
                  });
                
           
   
              </script>
           
            
              <img
                src="https://cdn-pro-web-219-28.cdn-nhncommerce.com/malltr2083_godomall_com/data/skin/front/moment/img/etc/pc_naver.png"
                alt="네이버 아이디 로그인" id="naverLogin" style="cursor: pointer;"
              />
             </div>

          <div>
            <script
              src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
              integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh"
              crossorigin="anonymous"
            ></script>
            <script>
              Kakao.init("881cd43e5724e04602b618321bb393c1"); // 사용하려는 앱의 JavaScript 키 입력
            </script>

            <a
              class="btn_kakao_login js_btn_kakao_login"
              id="kakao-login-btn"
              href="javascript:loginWithKakao()"
            >
              <img
                src="https://cdn-pro-web-219-28.cdn-nhncommerce.com/malltr2083_godomall_com/data/skin/front/moment/img/etc/pc_kakao.png"
                alt="카카오 아이디 로그인"
            /></a>
            <p id="token-result"></p>

            <script>
              function loginWithKakao() {
                Kakao.Auth.authorize({
                  redirectUri: "http://localhost:8080/member/kakao",
                });
              }
            </script>
          </div>
          <div class="btn_login_box">
            <ul>
              <li>
                <button
                  id="btnJoinMember"
                  class="btn_member_join"
                  onclick="location.href='${contextPath}/member/memberForm.do'"
                >
                  회원가입
                </button>
              </li>
              <li>
                <button
                  id="btnFindId"
                  class="btn_member_white"
                  onclick="location.href='${contextPath}/seller/sellerForm.do'"
                >
                  사업자 가입
                </button>
              </li>
              <li>
                <button
                  id="btnFindId"
                  class="btn_member_white"
                  onclick="location.href='${contextPath}/member/findId.do'"
                  style="width: 147px"
                >
                  아이디/비밀번호 찾기
                </button>
              </li>
            </ul>
          </div>
          <!-- //btn_login_box -->
        </div>
      </div>
    </div>
    <br /><br /><br /><br /><br /><br /><br />
  </body>
</html>

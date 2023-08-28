<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" isELIgnored="false"%> <%@ taglib
uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<html>
  <head>
    <style>
      .member_cont {
        padding: 20px 100px;
        border: 1px solid #dbdbdb;
        width: 690px;
        margin: 0 auto;
      }
    </style>
  </head>
  <body>
    <br /><br />

    <nav>
      <div
        class="nav nav-tabs"
        id="nav-tab"
        role="tablist"
        style="margin: 0px 31%"
      >
        <button
          class="nav-link active"
          id="nav-home-tab"
          data-bs-toggle="tab"
          data-bs-target="#nav-home"
          type="button"
          role="tab"
          aria-controls="nav-home"
          aria-selected="true"
        >
          아이디 찾기
        </button>
        <button
          class="nav-link"
          id="nav-profile-tab"
          data-bs-toggle="tab"
          data-bs-target="#nav-profile"
          type="button"
          role="tab"
          aria-controls="nav-profile"
          aria-selected="false"
        >
          비밀번호 찾기
        </button>
      </div>
    </nav>
    <div class="tab-content" id="nav-tabContent">
      <div
        class="tab-pane fade show active"
        id="nav-home"
        role="tabpanel"
        aria-labelledby="nav-home-tab"
        tabindex="0"
      >
        <script>
          $("document").ready(function () {
            var mymember = "${findMember}";
            if (mymember != "") {
              $("#findIdDIV").css("display", "none");
              $("#findIdLast").css("display", "block");
            }
          });
        </script>
        <div class="member_tit" height="700px">
          <br /><br />
          <img src="/image/Babee_Logo.png" /><br /><br />
        </div>
        <div id="findIdDIV" style="display: block">
          <form
            method="post"
            action="${contextPath}/member/findMyId.do"
            enctype="utf-8"
          >
            <div class="member_cont">
              <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label"
                  >이름</label
                >
                <input
                  type="text"
                  class="form-control"
                  id="exampleFormControlInput1"
                  name="member_name"
                  placeholder="이름을 입력해주세요"
                />
              </div>
              <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label"
                  >이메일</label
                >
                <input
                  type="email"
                  class="form-control"
                  id="exampleFormControlInput1"
                  placeholder="회원가입 시 입력한 이메일을 입력해주세요"
                  name="member_email"
                />
              </div>
              <input type="submit" value="아이디 찾기" />
            </div>
          </form>
        </div>
        <div class="member_cont" id="findIdLast" style="display: none">
          <div class="mb-3">
            <p style="font-size: 20px">회원님의 아이디는</p>
            <p style="font-size: 20px">
              ' <b>${findMember.member_id}</b> ' 입니다.
            </p>
          </div>
        </div>
        <br /><br />
      </div>

      <div
        class="tab-pane fade"
        id="nav-profile"
        role="tabpanel"
        aria-labelledby="nav-profile-tab"
        tabindex="0"
      >
        <div class="member_tit" height="700px">
          <br /><br />
          <img src="/image/Babee_Logo.png" /><br /><br />
        </div>
        <form method="post" action="${contextPath}/member/checkPw.do">
          <div class="member_cont">
            <div class="mb-3">
              <label for="exampleFormControlInput1" class="form-label"
                >아이디</label
              >
              <input
                type="text"
                class="form-control"
                id="exampleFormControlInput1"
                placeholder="아이디를 입력해주세요"
                name="member_id"
              />
            </div>

            <button onclick="javascript:findPw(this.form)">
              비밀번호 찾기
            </button>
            <script>
              function findPw(obj) {
                alert("등록하신 이메일로 비밀번호를 전송해 드렸습니다.");
              }
              obj.submit();
            </script>
          </div>
        </form>
        <br /><br />
      </div>
    </div>
  </body>
</html>

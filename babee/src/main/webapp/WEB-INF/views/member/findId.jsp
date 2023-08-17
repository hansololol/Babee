<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<html>
    <head>

        <script>


        </script>
        <style>
.member_cont {
	    padding: 20px 100px;
    border: 1px solid #dbdbdb;
	width: 690px;
	margin: 0 auto;
}
            
        </style>
    </head>
<body><br><br>

    <nav>
        <div class="nav nav-tabs" id="nav-tab" role="tablist" style="margin: 0px 31%;">
          <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">아이디 찾기</button>
          <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">비밀번호 찾기</button>          
        </div>
      </nav>
      <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
            <div class="member_tit" height="700px">
                <br><br>
                <img src="/image/Babee_Logo.png"><br><br>
            </div>
            <form method="post" action="">
                <div class="member_cont">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">이름</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="아이디를 입력해주세요">
              </div>
              <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">이메일</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="회원가입 시 입력한 이메일을 입력해주세요">
              </div>
              <input type="submit" value="아이디 찾기">
            </div>
            </form>
            <br><br>

        </div>
        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
            <div class="member_tit" height="700px">
                <br><br>
                <img src="/image/Babee_Logo.png"><br><br>
            </div>
            <form method="post" action="">
                <div class="member_cont">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">아이디</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="아이디를 입력해주세요">
              </div>
              <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">이메일</label>
                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="회원가입 시 입력한 이메일을 입력해주세요">
              </div>
              <button>비밀번호 찾기</button>
            </div>
            </form>
            <br><br>

        </div>
       
      </div>

	
</body>
</html>
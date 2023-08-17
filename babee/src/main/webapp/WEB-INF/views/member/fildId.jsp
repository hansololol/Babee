<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<html>
    <head>

        
    </head>
<body>
<form class="form-horizontal"  method="POST" action="">
   
    <div class="row">
    <div class="col-md-10 inputbb">
    <div class="form-group has-danger">
    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
    <input type="text" name="name" class="form-control" id="name" placeholder="이름" required autofocus>
    </div>
    </div>
    </div>
    </div>

    <div class="row">
    <div class="col-md-10 inputbb">
    <div class="form-group">
    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
    <input type="email" name="email" class="form-control" id="email" placeholder="이메일" required>
    </div>
    </div>
    </div>
    </div>
    
    <div class="row">
    <div class="col-md-10 inputbb">
    <button type="submit" class="btn btn-outline-secondary findbtn">*>찾기</button>
    </div>
    </div>
    </form>
    
    <div class="password_container">
    <form class="form-horizontal" role="form" method="POST">
   
    <div class="col-md-12 h2m">
    <h2>비밀번호 찾기</h2>
    <h6>회원가입 시 사용한 비밀번호는<strong>${fn:substring(pw, 0, 4)}
    <c:forEach begin="1" end="${fn:length(pw)-4}">
        *
    </c:forEach>
    </strong>입니다.</h6>
    </div>
  
   
    <div class="col-md-10 inputbb">
   </button>
    <!--<a type="submit" class="btn loginbtn" href="starters?cmd=login">로그인 화면으로 돌아가기</a>-->
    <button type="button" class="btn btn-outline-secondary loginbtn" onclick="backToLogin()">로그인 화면으로 돌아가기</button>
    </div>
    
    </form>
   </div>
</body>
</html>
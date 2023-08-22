<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<head>
    
    <title>비밀번호 확인</title>

    <script>
        function validateForm() {
            var passwordInput = document.getElementById("password").value;
            if (passwordInput !== "123") {
                alert("비밀번호가 틀렸습니다.");
                return false; // 폼 제출 방지
            }
            return true; // 폼 제출 허용
        }
    </script>
</head>
<body>

    <br>    <br>     <br>   
	<h2>내 정보수정</h2>
	
    <div style="padding: 20px; border-radius: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); text-align: center; margin: 0 16%;">
        <h3>사용자님의 회원정보 수정을 위해 비밀번호를 입력해 주시길 바랍니다.</h3>
        <br>
        
        <form action="${contextPath}/seller/modsellerForm.do?page=sellerPage" method="post" onsubmit="return validateForm()">
            <div style="margin-bottom: 15px;">
                
                <input type="password" id="password" name="password" required style="width: 30%; padding: 10px; border: 1px solid #ccc; border-radius: 3px; font-size: 16px;">
                <br><br>
            </div>
            <button type="submit"  style="width: 400px; background-color: #007bff; color: #fff; padding: 10px; border: none; border-radius: 3px; font-size: 16px; cursor: pointer; background-color: orange;">확인</button>
        </form>
    </div>
    <br>    <br>   

</body>
</html>
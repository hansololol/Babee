<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib
    prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <meta charset="UTF-8" />
    <title>비밀번호 확인</title>
    
    <style type="text/css">
    .mypage { 
	width: 66%;
    margin: auto;
   }
    
    </style>

    <script>
      function validateForm() {
        var passwordInput = document.getElementById("pwd").value;
        console.log(passwordInput);
        if (passwordInput == "${memberInfo.member_pw}") {
          location.replace("${contextPath}/member/modMember.do");
        } else  if (passwordInput == "${memberInfo.seller_pw}") {
          location.replace("${contextPath}/seller/modsellerForm.do?page=sellerPage");
        } else {
          alert("비밀번호가 틀렸습니다.");
        }
      }
    </script>
  </head>
  <body>

<div class="mypage" style="margin-left:165px;">
	<H3>내 정보 수정</H3>
	<hr>
	<table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
                 				<c:if test="${userType=='S'}">
                  <p  style="display:inline-block;"> ${memberInfo.seller_name} 님 안녕하세요 </p>
               	</c:if>
               	<c:if test="${userType!='S'}">
                  <p  style="display:inline-block;"> ${memberInfo.member_name} 님 안녕하세요 </p>
               	</c:if>
            </td>
            </td>
         </tr>
	</table>
      
      <hr>

   <br>

    <div 
      style="
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        text-align: center;
        border:1px solid #ccc;
        width:100%
      "
    >
     
      <h4>
        사용자님의 회원정보 수정을 위해 비밀번호를 입력해 주시길 바랍니다.
      </h4>
      <br />
        <div style="margin-bottom: 15px">
          <input
            type="password"
            id="pwd"
            value="${memberpw}"
            placeholder="비밀번호를 입력해 주세요."
            style="text-align: center; border: 1px solid #ccc; border-radius: 5px; width: 300px; height:40px;"
          />
          <br /><br />
        </div>
        <button
          style="
            width: 400px;
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 3px;
            font-size: 16px;
            cursor: pointer;
            background-color: orange;
          "
          onclick="validateForm()"
        >
          확인
        </button>
      </form>
      </div>
    </div>
    <br />
    <br />
  </body>
</html>

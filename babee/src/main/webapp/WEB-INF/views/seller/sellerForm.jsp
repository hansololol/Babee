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
<title>사업자 가입창</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>



.text_center{ 
   text-align:center;
   }

/* '회원가입' 버튼 스타일 */
input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
input[type="submit"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}



.tb {
    left: 30px;
    top: 30px;
    background:#ededed;
    border-radius: 40px;
    border-collapse: collapse;
    width: 617px;
    box-shadow: 20px 20px 39px rgba(0, 104, 255, 0.25);
    
    
}


 .tb tr{
   height:40px;
    border-bottom:1px solid rgba(128, 128, 128, 0.25);
}

.tb tr:last-child {
    border-bottom: none; /* 마지막 줄의 테두리 제거 */
}


.Personal_Data{
    margin: 0 auto;
    border-radius: 20px;
    border:1px solid rgba(128, 128, 128, 0.25);
    width: 617px;
    
}




</style>
</head>
<body>
	<br><br>
	
<div style="text-align: center;">
    <img src="/image/Babee_Logo.png" style="margin: 0 auto; display: block;" />
</div>
<br>
<form method="post" action="${contextPath}/seller/addSeller.do" enctype="multipart/form-data">
<div>
   <table class="tb" align="center">
      <tr>
         <td width="200"><h4 align="center"> 기본정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
   
      <tr>
         <td width="200"><p align="center">사업자 아이디</td>
         <td  width="300"><input type="text" name="seller_id">*
         <button type="button">중복확인</button></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">비밀번호</td>
         <td><input type="password" name="seller_pw">*</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">이름</td>
         <td><input type="text"name="seller_name">*</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">이메일</td>
         <td><input type="email" name="seller_email"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">일반전화</td>
         <td><input type="text" size="5" name="seller_tel1">-<input type="text" size="5" name="seller_tel2">-<input type="text" size="5" name="seller_tel3"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">휴대전화</td>
         <td><input type="text" size="5" name="seller_hp1">-<input type="text" size="5" name="seller_hp2">-<input type="text" size="5" name="seller_hp3"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">주소</td>
         <td><input type="text" size="7"  style=" margin-bottom: 5px;" name="seller_zipcode" >
         <button type="button">우편검색</button> <br>
               <input type="text" placeholder="도로명 주소" name="seller_roadAddr" style="margin-bottom: 5px;"><br>
                 <input type="text" placeholder="지번 주소" name="seller_jibunAddr" style="margin-bottom: 5px;"><br>
                 <input type="text" placeholder="나머지 주소"  name="seller_namujiAddr"  style="margin-bottom: 15px;"></td>
      </tr>
   </table>

</div>

<br><br><br>

<div>
<table class="tb" align="center">
      <tr>
         <td><h4 align="center"> 
        사업자 정보 </h4>
      </td>
      </tr>

      <tr>
         <td ><p align="center">은행정보</p></td><br>
         <td >은행명<input type="text" name="seller_bank_com"><br>
           통장번호<input type="text" name="seller_bank_num"><br>
           예금주명<input type="text" name="seller_bank_name">
      </tr>
      
      <tr>
         <td width="200"><p align="center">회사 정보<br>
            <td>회사 명<input type="text" name="seller_company"><br>
           회사 소개<textarea name="seller_company_info"></textarea>
         </tr>
      
      <tr>
         <td><p align="center">필요 서류<br></td>
            <td>
        사업자 등록증<input type="file"  multiple="multiple"name="seller_img1"><br>
        
      </td>
      </tr>
      </table>
</div>


<br>




   <div style="text-align: center;">
    <p><input type="submit" value="등록하기"></p>

    
</form>
<br><br><br><br>
</body>
</html>
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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>

.member_cont {
	padding: 20px 100px;
    border: 1px solid #dbdbdb;
	width: 690px;
	margin: 0 auto;
}
  	.join_input_sec > div {
    float: left;
}
	.join_input_sec input {
		display: block;
		width: 280px;
		height: 36px;
		margin: 0 0 3px 16px;
		padding: 0 0 0 18px;
		border: 1px solid #d0d0d0;
		color: #979d9d;
	}
	.join_input_sec > button {
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
	
.Personal_Data{
    margin: 0 auto;
    border-radius: 20px;
    border:1px solid rgba(128, 128, 128, 0.25);
    width: 500px;
    
}


</style>
<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('seller_zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('seller_roadAddr').value = fullRoadAddr;
      document.getElementById('seller_jibunAddr').value = data.jibunAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }
      
     
    }
  }).open();
}

</script>
</head>
<body>
	<br><br><br><br>
	<div class="content_box">
		<div class="seller_wrap">
			<div class="member_tit">
				<h2>사업자 가입</h2>
			</div>

	<div class="member_cont">

		<form id="formjoin" method="post" action="${contextPath}/seller/addSeller.do" novalidate="novalidate" enctype="multipart/form-data">
			
			<div class="member_join_box">
			<img src="/image/Babee_Logo.png"><br><br>
		<div class="join_input_sec">
		<table>
		<tr>
         <td width="150"><h4 align="center"> 기본정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
   
      <tr>
         <td width="200"><p align="center">사업자 아이디</td>
         <td  width="300"><input type="text" name="seller_id" style="width: 189px; margin-right: 0;  display: inherit;">*
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
         <td><input type="text" size="5" name="seller_tel1"style="width: 75px; display: inline-block;">-<input type="text" size="5" name="seller_tel2"style="width: 75px; display: inline-block;">-<input type="text" size="5" name="seller_tel3" style="width: 75px; display: inline-block;"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">휴대전화</td>
         <td><input type="text" size="5" name="seller_hp1" style="width: 75px; display: inline-block;">-<input type="text" size="5" name="seller_hp2" style="width: 75px; display: inline-block;">-<input type="text" size="5" name="seller_hp3" style="width: 75px; display: inline-block;"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">주소</td>
         <td><input type="text" size="7"  style=" margin-bottom: 5px;" name="seller_zipcode" id="seller_zipcode">
            <a href="javascript:execDaumPostcode()"> &nbsp;우편 검색</a>  <br>
               <input type="text" placeholder="도로명 주소" name="seller_roadAddr" id="seller_roadAddr" style="margin-bottom: 5px;"><br>
                 <input type="text" placeholder="지번 주소" name="seller_jibunAddr" id="seller_jibunAddr" style="margin-bottom: 5px;"><br>
                 <input type="text" placeholder="나머지 주소"  name="seller_namujiAddr" id="seller_namujiAddr" style="margin-bottom: 15px;"></td>
      </tr>
   </table>

</div>

<div>
   <table  class="join_input_sec">
      <tr>
         <td width="150"><h4 align="right"><h4>사업자 정보 </h4>
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
</div>

<br>
    <p><input type="submit" value="등록하기" class="member_join_order_btn" style="width: 300px; height: 50px; background-color: #007bff; color: white; font-size: 16px; font-weight: bold; border: none; border-radius: 8px;"></p>

    
</form>
</div>
<br><br><br>
</body>
</html>
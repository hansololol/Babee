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



<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
      document.getElementById('member_zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('member_roadAddr').value = fullRoadAddr;
      document.getElementById('member_jibunAddr').value = data.jibunAddress;

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
<script>
window.onload = function() {
    function toggleAllCheckboxes() {
        var allCheckbox = document.getElementById('allCheckbox');
        var checkboxes = document.querySelectorAll('.agreeCheckbox');

        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = allCheckbox.checked;
        }
    }
}
</script>



<style>

	.member_cont {
	padding: 20px 100px;
    border: 1px solid #dbdbdb;
	width: 690px;
	margin: 0 auto;
}
  	.mod_input_sec > div {
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
	.mod_input_sec > button {
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
	.btn_member_mod {
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
	

	</style>
</head>
<body>

	<div class="content_box">
		<div class="member_wrap">
			<div class="member_tit">
				<h2>내 정보 수정</h2>
			</div>

	<div class="member_cont">

		<form id="membermodfrom" method="post" action="${contextPath}/member/updateMember.do?page=adminPage" novalidate="novalidate">
			
			<div class="member_mod_box">
			<img src="/image/Babee_Logo.png"><br><br>
		<div class="join_input_sec">
		<table>
		<tr>
         <td width="150"><h4 align="center"> 기본정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
	 <tr>
         <td width="150"><p align="right">아이디 *</td>
         <td  width="300"><input type="text" name="member_id" value="${memberInfo.member_id}" disabled>
         					<input type="hidden" name="member_id" value="${memberInfo.member_id}" ></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">비밀번호 *</td>
         <td><input type="password" name="member_pw" value="${memberInfo.member_pw}" ></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">이름 *</td>
         <td><input type="text" name="member_name" value="${memberInfo.member_name}"></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">이메일</td>
         <td><input type="email" name="member_email" value="${memberInfo.member_email}"></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">일반전화</td>
         <td><input type="text" name="member_tel1" value="${memberInfo.member_tel1}" style="width: 75px; display: inline-block;">
         	 <input type="text" name="member_tel2" value="${memberInfo.member_tel2}" style="width: 80px; display: inline-block;">
         	 <input type="text" name="member_tel3" value="${memberInfo.member_tel3}" style="width: 80px; display: inline-block;"></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">휴대전화 *</td>
       <td>
        <input type="text" name="member_hp1" value="${memberInfo.member_hp1}" style="width: 75px; display: inline-block;">
        <input type="text" name="member_hp2" value="${memberInfo.member_hp2}" style="width: 80px; display: inline-block;">
        <input type="text" name="member_hp3"  value="${memberInfo.member_hp3}" style="width: 80px; display: inline-block;">
    	</td>    
    </tr>
      	<tr>
      		<td>&nbsp; </td>
      	</tr>
      <tr>
         <td width="150"><p align="right">주소</td>
         <td> <a href="javascript:execDaumPostcode()"> &nbsp;우편 검색</a> <br>
        	   <input type="text" placeholder="우편 번호"  name="member_zipcode" style=" margin-bottom: 5px;" value="${memberInfo.member_zipcode}" name="member_zipcode"  id="member_zipcode">
               <input type="text" placeholder="도로명 주소" name="member_roadAddr"  value="${memberInfo.member_roadAddr}" id="member_roadAddr" style="margin-bottom: 5px;"><br>
               <input type="text" placeholder="지번 주소" name="member_jibunAddr"   value="${memberInfo.member_jibunAddr}" id="member_jibunAddr"style="margin-bottom: 5px;"><br>
               <input type="text" placeholder="나머지 주소"  name="member_namujiAddr"   value="${memberInfo.member_namujiAddr}" id="member_namujiAddr"  style="margin-bottom: 15px;"></td>
      </tr>
   </table>
   <br>
   <table>
      <tr>
         <td width="150"><h4 align="right"> 추가정보 </h4></td>
         <td> &nbsp;</td>
      </tr>

      <tr>
         <td width="150"><p align="right">성별</td>
		 <td width="300" style="display: flex; flex-direction: column;">
  			<label style="display: inline-flex; align-items: center; margin-bottom: 5px;">
    		<input type="radio" name="member_gender" value="남자" style="width:20px; margin-right: 5px;">남자
    		<input type="radio" name="member_gender" value="여자" style="width:20px; margin-right: 5px;">여자
  			</label>
		</td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">생년월일</td>
         <td><input type="date" name="member_birth"></td>
      </tr>
      
      <tr>
         <td width="150"><p align="right">자녀 성별</td>
        <td width="300" style="display: flex; flex-direction: column;">
  			<label style="display: inline-flex; align-items: center; margin-bottom: 5px;">
    		<input type="radio" name="baby_gender" value="남자" style="width:20px; margin-right: 5px;">남자
    		<input type="radio" name="baby_gender" value="여자" style="width:20px; margin-right: 5px;">여자
  			</label>
		</td>
      </tr>
      
      <tr>
          <td width="150" height="100"><p align="right">자녀 나이 <span style="font-size: 8px; display: inline;">(개월수)</span></p></td>
          <td width="300" style="display: flex; flex-direction: column;">
  			<label style="display: inline-flex; align-items: center; margin-bottom: 5px;">
    		<input type="radio" name="baby_age" value="0~12" style="width:20px; margin-right: 5px;"> 0~12개월
    		<input type="radio" name="baby_age" value="12~24" style="width:20px; margin-right: 5px;"> 12~24개월
    		</label>
    		<label style="display: inline-flex; align-items: center; margin-bottom: 5px;">
    		<input type="radio" name="baby_age" value="24~36" style="width:20px; margin-right: 5px;"> 24~36개월
    		<input type="radio" name="baby_age" value="36~" style="width:20px; margin-right: 5px;"> 36개월 이상
  			</label>
		</td>
      </tr>s
      </table>
		<button type="submit" class="member_mod_order_btn" style="width: 300px; height: 50px; background-color: #007bff; color: white; font-size: 16px; font-weight: bold; border: none; border-radius: 8px;">수정하기</button>
					
	</div>
</div>
			
	</form>

			
</div>
</div>
</div>
<br><br><br><br><br><br><br>
</body>
</html>
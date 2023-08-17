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
<title>회원가입(일반) 목롱창</title>


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
    width: 600px;
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
    width: 600px;
    
}




</style>
</head>
<body>
   <br><br><br><br>
   
<div style="text-align: center;">
    <img src="/image/Babee_Logo.png" style="margin: 0 auto; display: block;" />
</div>
<br>
<form method="post" action="${contextPath}/member/addMember.do" enctype="utf-8">
<div>
   <table class="tb" align="center">
      <tr>
         <td width="200"><h4 align="center"> 기본정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
   
      <tr>
         <td width="200"><p align="center">아이디</td>
         <td  width="300"><input type="text" name="member_id">*
         <button type="button">중복확인</button></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">비밀번호</td>
         <td><input type="password" name="member_pw">*</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">이름</td>
         <td><input type="text"name="member_name">*</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">이메일</td>
         <td><input type="email" name="member_email"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">일반전화</td>
         <td><input type="text" size="5" name="member_tel1">-<input type="text" size="5" name="member_tel2">-<input type="text" size="5" name="member_tel3"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">휴대전화</td>
         <td><input type="text" size="5" name="member_hp1">-<input type="text" size="5" name="member_hp2">-<input type="text" size="5" name="member_hp3"></td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">주소</td>
         <td><input type="text" size="7"  style=" margin-bottom: 5px;" name="member_zipcode"  id="member_zipcode">
       
          <a href="javascript:execDaumPostcode()">우편 검색</a> <br>
               <input type="text" placeholder="도로명 주소" name="member_roadAddr" id="member_roadAddr" style="margin-bottom: 5px;"><br>
               <input type="text" placeholder="지번 주소" name="member_jibunAddr"  id="member_jibunAddr"style="margin-bottom: 5px;"><br>
               <input type="text" placeholder="나머지 주소"  name="member_namujiAddr"  id="member_namujiAddr"  style="margin-bottom: 15px;"></td>
      </tr>
   </table>

</div>

<br><br><br>

<div>
<table class="tb" align="center" style="height: 350px;">
      <tr>
         <td width="200"><h4 align="center"> 추가정보 </h4></td>
         <td> &nbsp;</td>
      </tr>

      <tr>
         <td width="200"><p align="center">성별</td>
         <td  width="300"><input type="radio" name="member_gender" value="남자"> 남자 
                      <input type="radio" name="member_gender" value="여자"> 여자</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">생년월일</td>
         <td><input type="date" name="member_birth">일</td>
      </tr>
      
      <tr>
         <td width="200"><p align="center">자녀 성별</td>
         <td  width="300"><input type="radio" value="남자" name="baby_gender"> 남자 
                      <input type="radio"value="여자" name="baby_gender"> 여자</td>
      </tr>
      
      <tr>
          <td width="200" height="100"><p align="center">자녀 나이 <span style="font-size: 8px; display: inline;">(개월수)</span></p></td>
          <td  width="300"><input type="radio" value="0~12" name="baby_age"> 0 ~ 12개월 
                          <input type="radio" value="12~24" name="baby_age"> 12 ~ 24개월 <br>
                          <input type="radio" value="24~36" name="baby_age"> 24 ~ 36개월
                          <input type="radio" value="36~" name="baby_age"> 36개월 이상
                          </td>
      </tr>
      </table>
</div>


<br>

<div class="text_center">
<img src="/image/line.png">

<h3>개인정보 수집·이용 안내</h3>
<table class="Personal_Data">
   <tr>
      <td height="50">수집·이용목적</td>
      <td>이용항목</td>
   </tr>
   
   <tr>
      <td height="50">온라인 서비스 회원가입, 본인식별, 정보수정, 불만처리, 서비스 관련 의사소통</td>
      <td>아이디, 비밀번호, 이름, 휴대전화번호, 이메일</td>
   </tr>
   
</table>
<br>
</div>
<div >
    <label>
    <input type="checkbox" style="vertical-align: middle;"> 
    <h4 style="display: inline-block; margin: 0; vertical-align: middle;">전체 동의</h4>
   </label>

   <p>이용약관 및 개인정보 수집 및 이용에 모두 동의합니다.
   <p>&nbsp; <input type="checkbox" > 동의함 이용약관 동의 (필수)
   <p>&nbsp; <input type="checkbox" > 동의함 개인정보 수집 및 이용 동의 (필수)
</div>

   <br>

   <div style="text-align: center;">
    <p><input type="submit" value="회원가입"></p>
</div>
    
</form>
<br><br><br><br>
</body>
</html>
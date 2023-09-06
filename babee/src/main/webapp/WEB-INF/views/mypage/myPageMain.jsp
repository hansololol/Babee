<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" isELIgnored="false" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}" />

<head>
  <style>
    .basic_tb,
    .add_tb {
      width: 100%;
      border-top: 1px solid #7e7e7e;
      border-bottom: 1px solid #7e7e7e;
      border-radius: 10px;
    }

    .basic_tb td {
      border-right: 1px solid #d4d4d4;
      border-bottom: 1px solid #d4d4d4;
      padding: 10px;
    }

    .add_tb td {
      border-right: 1px solid #d4d4d4;
      border-bottom: 1px solid #d4d4d4;
      padding: 10px;
    }
    
    .my { 
	width: 66%;
    margin: auto;
   }
    
  </style>

  <title>마이페이지 메인창</title>
</head>
<body>



<div class="my" style="margin-left:165px;">

	<h3 style="display:inline-block;">내 정보</h3>
   <hr>
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;"> ${memberInfo.member_name} 님 안녕하세요 </p>
               
            </td>
         </tr>
      </table>
      
      <hr>
	<br>
	
	 <div style="text-align: left">
	<h4><span style="color: #cc9900">●</span> 기본정보</h4>

      <c:if test="${userType == 'M'}">
        <table class="basic_tb" width="455px">
          <tr>
            <td width="150">이름</td>
            <td style="border-right: none">
              <strong>${memberInfo.member_name }</strong>
            </td>
          </tr>

          <tr>
            <td>이메일</td>
            <td style="border-right: none">
              <strong>${memberInfo.member_email}</strong>
            </td>
          </tr>

          <tr>
            <td>일반전화</td>
            <td style="border-right: none">
              <strong
                >${memberInfo.member_hp1}-${memberInfo.member_hp2}-${memberInfo.member_hp3
                }</strong
              >
            </td>
          </tr>

          <tr>
            <td>휴대전화</td>
            <td style="border-right: none">
              <strong
                >${memberInfo.member_hp1
                }-${memberInfo.member_hp2}-${memberInfo.member_hp3 }</strong
              >
            </td>
          </tr>

          <tr>
            <td>도로명</td>
            <td style="border-right: none">
              <strong>${memberInfo.member_roadAddr }</strong>
              <br />
            </td>
          </tr>
          <tr>
            <td style="border-bottom: none">지번</td>
            <td style="border-right: none; border-bottom: none">
              <strong>${memberInfo.member_jibunAddr }</strong>
            </td>
          </tr>
        </table>
		
        <br />

        <div style="text-align: left">
          <h4><span style="color: #cc9900">●</span> 추가정보</h4>
          <table class="add_tb" width="455px">
            <tr>
              <td width="150">성별</td>
              <td style="border-right: none">
                <strong>${memberInfo.member_gender}</strong>
              </td>
            </tr>

            <tr>
              <td>생년월일</td>
              <td style="border-right: none">
                <strong>${memberInfo.member_birth } </strong>
              </td>
            </tr>

            <tr>
              <td>자녀 성별</td>
              <td style="border-right: none">
                <strong>${memberInfo.baby_gender }</strong>
              </td>
            </tr>

            <tr>
              <td style="border-bottom: none">자녀 나이 (개월수)</td>
              <td style="border-right: none; border-bottom: none">
                <strong>${memberInfo.baby_age }</strong>
              </td>
            </tr>
          </table>
        </div>
      </c:if>

      <c:if test="${userType == 'S'}">
        <table class="basic_tb" width="455px">
          <tr>
            <td width="150">이름</td>
            <td style="border-right: none">
              <strong>${memberInfo.seller_name }</strong>
            </td>
          </tr>

          <tr>
            <td>이메일</td>
            <td style="border-right: none">
              <strong>${memberInfo.seller_email}</strong>
            </td>
          </tr>

          <tr>
            <td>일반전화</td>
            <td style="border-right: none">
              <strong
                >${memberInfo.seller_hp1}-${memberInfo.seller_hp2}-${memberInfo.seller_hp3
                }</strong
              >
            </td>
          </tr>

          <tr>
            <td>휴대전화</td>
            <td style="border-right: none">
              <strong
                >${memberInfo.seller_hp1
                }-${memberInfo.seller_hp2}-${memberInfo.seller_hp3 }</strong
              >
            </td>
          </tr>

          <tr>
            <td>도로명</td>
            <td style="border-right: none">
              &nbsp;&nbsp; <strong>${memberInfo.seller_roadAddr }</strong>
              <br />
            </td>
          </tr>
          <tr>
            <td>지번</td>
            <td style="border-right: none">
              &nbsp;&nbsp; <strong>${memberInfo.seller_jibunAddr }</strong>
            </td>
          </tr>
          <tr>
            <td style="border-bottom: none">승인여부</td>
            <td style="border-right: none; border-bottom: none">
              &nbsp;&nbsp; <strong>${memberInfo.seller_status }</strong>
            </td>
          </tr>
        </table>
      </c:if>
    </div>
    </div>
    
    <br><br><br>

</body>

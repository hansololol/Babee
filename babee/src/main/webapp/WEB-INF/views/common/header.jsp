<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head> 
    <link rel="stylesheet" href="/css/font.css" type="text/css">
   <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<style>
/* 기본 링크 스타일 */
.category {
    font-size: 20px;
    text-decoration: none;
    color: black;
    
}


    
       
        .category-list {
         
         margin-top: -20px;
     
                 position: absolute;
                 padding : 4px;
                 width:130px;
                 display:none;
                  background-color:gray;
                  opacity:90%;
                 box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /* 추가된 부분 */
                 z-index: 2;
             }
            
           
             .middlecategory-list {
            display: none;
            position: absolute;
            top: 100%;
            left: -10px; /* 왼쪽 padding만큼 위치 조정 */
            background-color: #f4f4f4;
            padding: 10px; /* padding으로 영역을 늘림 */
            width: 230px; /* padding 포함한 전체 너비 */
            height: 400px;
            opacity: 0;
            margin-top: -10px;
            z-index: 1; /* 다른 요소 위에 나오도록 설정 */
            transition: opacity 0.3s; /* 투명도 변화에 대한 트랜지션 설정 */
          
        }
        .middlecategory-list a {
            display: block;
            margin: 5px 0;
        }
        .category-list:hover .middlecategory-list,
        .middlecategory-list:hover {
            display: block;
            opacity: 1;
        }
        .category-list .middlecategory-list li:hover {
            background-color: rgba(0, 0, 0, 0.7); /* 선택된 호버 영역의 배경색을 연한 검은색으로 변경 */
        }
        .category-list .middlecategory-list:hover {
            opacity: 1;
        }
        .category-list li:hover .child-container {
            display: flex;
        }
        .child-container {
            display: none;
            position: absolute;
            top: 0;
            left: 100%; /* 오른쪽에 위치하도록 변경 */
            background-color: #f4f4f4;
            padding: 10px;
            width: 123px; /* 너비 조정 */
            height: -webkit-fill-available;
         
            font-size: large;
        }
   
     
        /* 세로선 스타일 추가 */
        .vertical-line {
            border-left: 1px solid #ccc;
            height: 100%;
            margin-left: 10px; /* 세로선과 카테고리 간의 간격 조정 */
        }
    

.top-link{
   display: flex;
}
.last {
   width:100px;
}
.last > a{
   color: black;
}
.btn-secondary {
   --bs-btn-color: #000;
   
}
.middlecategory-list-li >li{
    padding-bottom: 15px;
    
    font-size: large;
}
.middlecategory-list-li > li >a{
  
    color: black;
    
}
</style>

<script>
function showCategory() {

   $(".category-list").css("display","block");
  }

  function hideCategory() {
   $(".category-list").css("display","none");
  }

  


    var isLogOn = '${isLogOn}';
   
    $(document).ready(function() {
    if(isLogOn){
        if("${memberInfo.baby_age}" != ""){
    	$("#fit").prop("href","${contextPath}/goods/fitGoods.do");
        }
       /*  $("#dir").prop("href","${contextPath}/diary/diaryList.do"); */
    }
    });

    function login() {
    	 var userType = '<%= session.getAttribute("userType") %>';
    	 var member_id_ = '<%= session.getAttribute("memberInfo") %>';
    	 var member_id = member_id_.member_id;
    if(! isLogOn){
        alert("로그인 이후 이용 가능한 서비스입니다.");
        location.replace("${contextPath}/member/loginForm.do")
    }
    
    if(isLogOn && userType === 'M' ){
    	if("${memberInfo.baby_age}" == "" && !member_id === "admin" ){
    		alert("아동 정보 입력 후 이용 가능합니다.")
       		 if(confirm("아동정보 입력 창으로 이동할까요?")){
           		 location.replace("${contextPath}/member/modpassword.do");
       		 }
        } else {
        	alert("일반회원에게 제공되어지는 서비스 입니다.") 
       	 if(confirm("관리자 로그아웃 후 일반 회원가입 창으로 이동 하시겠습니까?")){
				
    		 location.replace("${contextPath}/member/logout.do")	;
    		 location.replace("${contextPath}/member/memberForm.do")	;
   		 }
        }
    } else if(isLogOn && userType === 'S'){
    	alert("일반회원에게 제공되어지는 서비스 입니다.") 
    		 if(confirm("사업자 로그아웃 후 일반 회원가입 창으로 이동 하시겠습니까?")){
    				
    		 location.replace("${contextPath}/member/logout.do")	;
    		 location.replace("${contextPath}/member/memberForm.do")	;
   		 }
    	} 
    
    }
    
    function login2() {
    	
      	 var userType = '<%= session.getAttribute("userType") %>';
      	 var member_id_ = '<%= session.getAttribute("memberInfo") %>';
    	 var member_id = "${memberInfo.member_id}"
      if(! isLogOn){
          alert("로그인 이후 이용 가능한 서비스입니다.");
          location.replace("${contextPath}/member/loginForm.do")
      }
      
      if(isLogOn && userType === 'S'){
         		alert("일반회원에게 제공되어지는 서비스 입니다.")
         		 if(confirm("사업자 로그아웃 후 일반 회원가입 창으로 이동 하시겠습니까?")){
       				
         	   		 location.replace("${contextPath}/member/logout.do")	;
         	   		 location.replace("${contextPath}/member/memberForm.do")	;
         		 }
          } else if (isLogOn && userType === 'M'){
        	  if(member_id !== 'admin'){
       	   location.replace("${contextPath}/diary/diaryList.do");
       	   } else {
       		alert("일반회원에게 제공되어지는 서비스 입니다.")
    		 if(confirm("관리자 로그아웃 후 일반 회원가입 창으로 이동 하시겠습니까?")){
  				
    	   		 location.replace("${contextPath}/member/logout.do")	;
    	   		 location.replace("${contextPath}/member/memberForm.do")	;
    		 }
       	   }
          }
      
      }
  
</script>

<meta charset="utf-8">
<title>헤더</title>
</head>
<body>

<div >
<table width="70%" style="margin: 10px auto " >

   <tr>
		<td>
			<a href="${contextPath}/main/main.do">
			<img src="/image/Babee_Logo.png" width="132px" height="49px"/>
			</a>
		</td>
		
   		<span style="width: 40px;"></span>
		<td>
         	<a href="${contextPath}/goods/goodsList.do" style="font-size: 20px;" class="category" onmouseenter="showCategory()">카테고리</a>
		</td>
		
		<span style="width: 40px;"></span>
		<td> 
			<a href="javascript:login()" style="font-size: 20px;" class="category" id="fit">맞춤상품</a>
		</td>  
                	
		<span style="width: 40px;"></span>
		<td>
			<a href="javascript:login2()" style="font-size: 20px;" class="category" id="dir">다이어리</a> 
		</td>
             

      <span style="width: 40px;"></span>
      <td>
         <a href="${contextPath}/member/babyinfo.do" style="font-size: 20px;" class="category">육아정보</a>
      </td>
      <span style="width: 40px;"></span>
      <td>
         
         <div class="dropdown">
            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              커뮤니티
            </a>
      
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${contextPath}/community/infoList.do">공지사항</a></li>
              <li><a class="dropdown-item" href="${contextPath}/community/freeboardList.do">자유게시판</a></li>
              <li><a class="dropdown-item" href="${contextPath}/community/questionList.do">고객센터</a></li>
            </ul>
          </div>


        	
      </td>
      <td class="loginside">
        <c:choose>
            <c:when test="${isLogOn ==true}">
                <c:if test="${memberInfo.member_id=='admin'}">
                    <p><img src="/image/admin.png" width="50px">&nbsp; ${memberInfo.member_name}님 환영합니다</p>
                </c:if>
                <c:if test="${memberInfo.seller_id!=null}">
                    <p><img src="/image/seller.png" width="50px">&nbsp; ${memberInfo.seller_name}님 환영합니다</p>
                </c:if>
                <c:if test="${!(memberInfo.member_id=='admin'||memberInfo.seller_id!=null)}">
                    <p><img src="/image/user.png" width="50px">&nbsp; ${memberInfo.member_name}님 환영합니다</p>
                </c:if>
           
                <div>
                    <ul class="top-link" style="margin-left: 50px;">
                       <li class="last"><a href="${contextPath}/member/logout.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_login.png" alt="로그아웃"><br>로그아웃</a></li>
                      
                       <li class="last"><a href="${contextPath}/cart/myCartList.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_cart.png" alt="장바구니"><br>장바구니</a></li>
                     
                       <li class="last"><a href="${contextPath}/member/myPageMain.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_mypage.png" alt="마이페이지"><br>마이페이지</a></li>
                       <c:if test="${memberInfo.seller_id!=null}">
                            <li class="last">
<!-- 이부분 -->                                <a href="${contextPath}/member/myPageMain.do?page=sellerPage">
                                    <img src="/image/setting.png" width="35px" height="35px" alt="마이페이지"><br>사업자페이지
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${memberInfo.member_id=='admin'}">
                            <li class="last">
                                <a href="${contextPath}/member/myPageMain.do?page=adminPage">
                                    <img src="/image/setting.png" width="35px" height="35px" alt="마이페이지"><br>관리자페이지
                                </a>
                            </li>
                        </c:if>
                        
                    </ul>
                    
                  </div>
                      
            </c:when>
            <c:otherwise>
                <div>
                    <ul class="top-link" style="margin-left: 50px;">
                       <li class="last"><a href="${contextPath}/member/loginForm.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_login.png" alt="로그인/회원가입"><br>로그인</a></li>
                      
                       <li class="last"><a href="javascript:login()"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_cart.png" alt="장바구니"><br>장바구니</a></li>
                     
                       <li class="last"><a href="javascript:login()"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_mypage.png" alt="마이페이지" id="mypage"><br>마이페이지</a></li>
                    </ul>
                  </div>	
    
            </c:otherwise>
        </c:choose>
        
                                             
          </td>
   
   </tr>
   <tr>
   	<td></td>
   	<td>
   	
         
        <ul class="category-list" onmouseleave="hideCategory()">
            <label><li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=출산준비" style="font-size: 20px; color: white;"><img src="/image/icon-1.png" width="30px" style="float: left; ">출산준비</a></label>
                <div class="child-container">
                    
                    <ul class="middlecategory-list-li">
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=출산준비&middle_category=임산부복대">임산부 복대</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=출산준비&middle_category=스킨케어">스킨케어</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=출산준비&middle_category=임부복">임부복</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=출산준비&middle_category=산후용품">산후용품</a></li>
                     </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품" style="font-size: 20px; color: white;"><img src="/image/icon-2.png" width="30px" style="float: left; clear: both;">생활용품</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품&middle_category=구강용품">구강용품</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품&middle_category=목욕용품">목욕용품</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품&middle_category=위생용품">위생용품</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품&middle_category=세탁용품">세탁용품</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=생활용품&middle_category=유아스킨케어">유아스킨케어</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=유아식품" style="font-size: 20px; color: white;"><img src="/image/icon-3.png" width="30px" style="float: left; clear: both; ">유아식품</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=유아식품&middle_category=분유">분유</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=유아식품&middle_category=이유식">이유식</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=유아식품&middle_category=유아음료">유아음료</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=유아식품&middle_category=유아간식">유아간식</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품" style="font-size: 20px; color: white;"><img src="/image/icon-4.png" width="30px" style="float: left; clear: both;">외출용품</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                    
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품&middle_category=유모차">유모차</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품&middle_category=아기띠">아기띠</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품&middle_category=보호대">보호대</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품&middle_category=마스크">마스크</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=외출용품&middle_category=우산">우산</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션" style="font-size: 20px; color: white;"><img src="/image/icon-4.png" width="30px" style="float: left; clear: both;">아동패션</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                                     
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=상의">상의</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=하의">하의</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=내의">내의</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=아우터">아우터</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=신발">신발</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동패션&middle_category=잡화">잡화</a></li>
                    </ul>
              
                
            </div>
            </li>
           
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=완구/교구" style="font-size: 20px; color: white;"><img src="/image/icon-6.png" width="30px" style="float: left; clear: both;">완구/교구</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=완구/교구&middle_category=신생아 완구">신생아 완구</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=완구/교구&middle_category=교육 완구">교육 완구</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=완구/교구&middle_category=인형">인형</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=완구/교구&middle_category=캐릭터 완구">캐릭터 완구</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=안전용품" style="font-size: 20px; color: white;"><img src="/image/icon-7.png" width="30px" style="float: left; clear: both; ">안전용품</a>
                <div class="child-container">
                    
                    <ul  class="middlecategory-list-li">
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=안전용품&middle_category=보호대">보호대</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=안전용품&middle_category=안전문">안전문</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=안전용품&middle_category=잠금장치">잠금장치</a></li>
                  <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=안전용품&middle_category=안전소품">안전소품</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li >
                <a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구" style="font-size: 20px; color: white;"><img src="/image/icon-5.png" width="30px" style="float: left; clear: both;">아동가구</a>
                <div class="child-container">
                    
                        <ul class="middlecategory-list-li">
                     <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구&middle_category=침대">침대</a></li>
                     <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구&middle_category=놀이가구">놀이가구</a></li>
                     <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구&middle_category=소품">소품</a></li>
                     <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구&middle_category=책상">책상</a></li>
                     <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=아동가구&middle_category=의자">의자</a></li>   
                        </ul>

                  
                    
                </div>
            </li>
        </ul>
   	</td>

   
</table>
</div>
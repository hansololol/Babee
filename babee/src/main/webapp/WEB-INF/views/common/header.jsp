<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head> 
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
            
           
             .subcategory-list {
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
        .subcategory-list a {
            display: block;
            margin: 5px 0;
        }
        .category-list:hover .subcategory-list,
        .subcategory-list:hover {
            display: block;
            opacity: 1;
        }
        .category-list .subcategory-list li:hover {
            background-color: rgba(0, 0, 0, 0.7); /* 선택된 호버 영역의 배경색을 연한 검은색으로 변경 */
        }
        .category-list .subcategory-list:hover {
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
.last a{
   color: black;
}
.btn-secondary {
   --bs-btn-color: #000;
   
}
.subcategory-list-li >li{
    padding-bottom: 15px;
    
    font-size: large;
}
.subcategory-list-li >li >a{
  
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

  function login(href){

    var isLogOn = '${isLogOn}';
    if(isLogOn){
        document.getElementById("fit").href = "${contextPath}/goods/fitGoods.do";
        document.getElementById("dir").href = "${contextPath}/diary/diaryList.do";
        document.getElementById("mypage").href = "${contextPath}/member/myPageMain.do";
        
     
    }else{
        alert("로그인 이후 이용 가능한 서비스입니다.");
        location.replace("${contextPath}/member/loginForm.do")
    }
    }
  
</script>

<meta charset="utf-8">
<title>헤더</title>
</head>
<body>

<div >
<table width="70%" style="margin: 0 auto " >

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
                </td>  <span style="width: 40px;"></span>
                <td>
                    <a href="javascript:login()" style="font-size: 20px;" class="category" id="dir">다이어리</a>
                    </td>
             

      <span style="width: 40px;"></span>
      <td>
         <a href="${contextPath}/goods/questionList.do" style="font-size: 20px;" class="category">고객센터</a>
      </td>
      <span style="width: 40px;"></span>
      <td>
         
         <div class="dropdown">
            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              커뮤니티
            </a>
      
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${contextPath}/member/babyinfo.do">육아정보</a></li>
              <li><a class="dropdown-item" href="${contextPath}/goods/infoList.do">공지사항</a></li>
              <li><a class="dropdown-item" href="${contextPath}/goods/freeList.do">자유게시판</a></li>
            </ul>
          </div>


        	
      </td>
      <td class="loginside">
        <c:choose>
            <c:when test="${isLogOn ==true}">
                <c:if test="${memberInfo.member_id=='admin'}">
                    <p><img src="/image/admin.png" width="50px">&nbsp; 관리자님 환영합니다</p>
                </c:if>
                <c:if test="${memberInfo.seller_id!=null}">
                    <p><img src="/image/seller.png" width="50px">&nbsp; 사업자님 환영합니다</p>
                </c:if>
                <c:if test="${!(memberInfo.member_id=='admin'||memberInfo.seller_id!=null)}">
                    <p><img src="/image/user.png" width="50px">&nbsp; 사용자님 환영합니다</p>
                </c:if>
           
                <div>
                    <ul class="top-link" style="margin-left: 50px;">
                       <li class="last"><a href="${contextPath}/member/logout.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_login.png" alt="로그아웃"><br>로그아웃</a></li>
                      
                       <li class="last"><a href="${contextPath}/cart/myCartList.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_cart.png" alt="장바구니"><br>장바구니</a></li>
                     
                       <li class="last"><a href="${contextPath}/member/myPageMain.do"><img src="https://agabantr6740.cdn-nhncommerce.com/data/skin/front/moment/img/dimg/top_mypage.png" alt="마이페이지"><br>마이페이지</a></li>
                       <c:if test="${memberInfo.seller_id!=null}">
                            <li class="last">
                                <a href="${contextPath}/member/myPageMain.do?page=sellerPage">
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
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=ready" style="font-size: 20px; color: white;"><img src="/image/icon-1.png" width="30px" style="float: left; ">출산준비</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=ready&middle_category=bokdae">임산부 복대</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=ready&middle_category=skin">스킨케어</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=ready&middle_category=imbubok">임부복</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=ready&middle_category=sanhu">산후용품</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life" style="font-size: 20px; color: white;"><img src="/image/icon-2.png" width="30px" style="float: left; clear: both;">생활용품</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=mouth">구강용품</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=bath">목욕용품</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=clean">위생용품</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=laundry">세탁용품</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=babyskin">유아스킨케어</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=food" style="font-size: 20px; color: white;"><img src="/image/icon-3.png" width="30px" style="float: left; clear: both; ">유아식품</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=milk">분유</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=eu">이유식</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=drink">유아음료</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=life&middle_category=snack">유아간식</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out" style="font-size: 20px; color: white;"><img src="/image/icon-4.png" width="30px" style="float: left; clear: both;">외출용품</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out&middle_category=youmocar">유모차</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out&middle_category=babyline">아기띠</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out&middle_category=protect">보호대</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out&middle_category=mask">마스크</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=out&middle_category=umb">우산</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion" style="font-size: 20px; color: white;"><img src="/image/icon-4.png" width="30px" style="float: left; clear: both;">아동패션</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                   
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=top">상의</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=bottom">하의</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=inner">내의</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=outter">아우터</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=shoes">신발</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=fashion&middle_category=jap">잡화</a></li>
                    </ul>
              
                
            </div>
            </li>
           
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=toy" style="font-size: 20px; color: white;"><img src="/image/icon-6.png" width="30px" style="float: left; clear: both;">완구/교구</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=toy&middle_category=babytoy">신생아 완구</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=toy&middle_category=edutoy">교육 완구</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=toy&middle_category=doll">인형</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=toy&middle_category=character">캐릭터 완구</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li style="padding-bottom: 15px;"><a href="${contextPath}/goods/goodsCategoryList.do?main_category=safe" style="font-size: 20px; color: white;"><img src="/image/icon-7.png" width="30px" style="float: left; clear: both; ">안전용품</a>
                <div class="child-container">
                    
                    <ul  class="subcategory-list-li">
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=safe&middle_category=boho">보호대</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=safe&middle_category=safedoor">안전문</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=safe&middle_category=safelock">잠금장치</a></li>
                    <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=safe&middle_category=safeso">안전소품</a></li>
                    </ul>
              
                
            </div>
            </li>
            <li >
                <a href="${contextPath}/goods/goodsCategoryList.do?main_category=house" style="font-size: 20px; color: white;"><img src="/image/icon-5.png" width="30px" style="float: left; clear: both;">아동가구</a>
                <div class="child-container">
                    
                        <ul class="subcategory-list-li">
                        <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=house&middle_category=bed">침대</a></li>
                        <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=house&middle_category=play">놀이가구</a></li>
                        <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=house&middle_category=sopum">소품</a></li>
                        <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=house&middle_category=desk">책상</a></li>
                        <li><a href="${contextPath}/goods/goodsCategoryList.do?main_category=house&middle_category=chair">의자</a></li>
                        </ul>
                  
                    
                </div>
            </li>
        </ul>
   	</td>

   
</table>
</div>
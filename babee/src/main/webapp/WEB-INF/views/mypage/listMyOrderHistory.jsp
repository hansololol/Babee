<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">

<style>

.order_delivery{
   text-align:center;
   border-collapse: collapse;

}
.order_delivery td {
    border-top: 1px solid gray;
    
}




.order_delivery_list { 
	width: 66%;
    margin: auto;
   }

.goods li {
   list-style-type: none;
}


.order_delivery_search {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 5px 5px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
    font-size:1px;
}
 .paging-container {
            text-align: center;
            margin-top: 20px;
        }
        .paging-button {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f0f0f0;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }
        .paging-button:hover {
            background-color: #ccc;
        }


/* 버튼에 호버 효과 */
.order_delivery_search :hover{
    background-color: #cca300; /* 호버 시 배경색 변경 */
}


/* 이미지에 여백과 둥근 테두리 추가 */
.hover-zoom-image {
  width: 100px;
  height: 100px;
  margin: 10px 0; /* 이미지 위아래 여백 조절 */
  border-radius: 5px; /* 둥근 테두리 적용 */
  overflow: hidden; /* 둥근 테두리에 이미지가 넘칠 경우 자르기 */
}
.order_delivery img:hover {
    transform: scale(1.1); /* Enlarge the image by 10% on hover */
    filter: brightness(0.7); /* Darken the image to 70% brightness on hover */
    transition: transform 0.3s ease, filter 0.3s ease; /* Smooth transition */

  }

/* order_id에 호버 효과 추가 */
.goods li a:hover {
  font-weight: bold; /* 호버 시 진하게 만듭니다. */
}
</style>
<title>주문내역/배송조회 창</title>
<script>
function search_order_history(fixedSearchPeriod){
   var fixedSearch_period = fixedSearchPeriod;
   var formObj=document.dateForm;
   
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name="beginDate";
	
   var now = new Date();
   if(fixedSearch_period =='today'){
	   var today = new Date(now.setDate(now.getDate()));	
	   var year = today.getFullYear();
	   var month = ('0' + (today.getMonth() + 1)).slice(-2);
	   var day = ('0' + today.getDate()).slice(-2);
	   var dateString = year + '-' + month  + '-' + day;
	   console.log(dateString);
	   i_fixedSearch_period.value=dateString;
	  
   }else if(fixedSearch_period =='week'){
	   var week = new Date(now.setDate(now.getDate()-7));
	   i_fixedSearch_period.value=week;
	 
   }else if(fixedSearch_period =='month'){
	   var month = new Date(now.setMonth(now.getMonth() - 1));
	   i_fixedSearch_period.value=month;
	  
   }else if(fixedSearch_period =='threemonth'){
	   var threemonth = new Date(now.setMonth(now.getMonth() - 3));
	   i_fixedSearch_period.value=threemonth;
	  
   }
   formObj.appendChild(i_fixedSearch_period);
 
   document.body.appendChild(formObj); 
   formObj.method="get";
   formObj.action="${contextPath}/mypage/listMyOrderHistory.do";
   formObj.submit();
   
}

</script>
</head>
<body>
<br><br>
   <div class="order_delivery_list">
   <H3>주문내역/배송조회</H3>
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
      <form  method="post" name = "dateForm">   
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td>
               <a href="javascript:search_order_history('today')" id="today">
                  <img   src="/image/btn_search_one_day.jpg">
               </a>
               <a href="javascript:search_order_history('one_week')" id="week">
                  <img   src="/image/btn_search_1_week.jpg">
               </a>
    
               <a href="javascript:search_order_history('one_month')" id="month">
                  <img   src="/image/btn_search_1_month.jpg">
               </a>
               <a href="javascript:search_order_history('three_month')" id="threemonth">
                  <img   src="/image/btn_search_3_month.jpg">
               </a>
      </td>
         <tr>
            <td>    
               조회한 기간 : <input  type="date"  size="4" value="${beginYear}" />
                      ~
                     <input  type="date"  size="4" value="${endYear}" />
            </td>
            
             <td><input   type="button"  value="조회"/> </td>
         </tr>
      </table>
      
      <div class="clear">
   </div>
   </form>   
   
   <br>

<table class="order_delivery"  width="100%">
         <tr >
            <td colspan="2" width="300px" style="padding-left:15px;">주문정보</td>
            <td>결제금액</td>
            <td>진행상태</td>
            <td >&nbsp;&nbsp;&nbsp;</td>
            
         </tr>
        <c:forEach items="${myOrderList}" var="order" varStatus="status">
    <tr>
    	
      <td>
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${order.goods_id}">
		    <img src="${contextPath}/thumbnails.do?goods_id=${order.goods_id}&fileName=${order.goods_image_name}" alt="${order.goods_title}" class="hover-zoom-image" style="width:100px; height:100px;" >
		  </a>
		</td>
      <td>
        <ul class="goods">
          <li style="text-align:left;"> ${order.goods_title} [<a href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}">${order.order_id}</a>] </li>
          <li style="text-align:left;"> 주문일자: ${order.payment_order_time} </li>
        </ul>
      </td>
      <td> ${order.final_total_price} 원</td>
      <c:choose>
        <c:when test="${order.delivery_status=='delivery_prepared'}">
          <td> 배송준비중 </td>
          <td> 
            <a class="order_delivery_search" href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}"><b>주문/배송조회</b></a><br>
            <a class="order_delivery_search" href="${contextPath}/mypage/cancelMyOrder.do?order_id=${order.order_id}"><b>주문취소</b></a><br>
          </td>
        </c:when>
        <c:when test="${order.delivery_status=='delivering' }">
          <td> 배송중 </td>
          <td> 
            <a class="order_delivery_search" href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}"><b>주문/배송조회</b></a><br>
          </td>
        </c:when>
        <c:when test="${order.delivery_status=='finished_delivering' }">
          <td> 배송완료 </td>
          <td>
          	<input type="hidden" name="orderNO" value="${order.orderNO}">
            <a class="order_delivery_search" href="${contextPath}/mypage/myrefund.do?orderNO=${order.orderNO}&order_id=${order.order_id}"><b>반품/교환</b></a>
          </td>
        </c:when>
        <c:when test="${order.delivery_status=='cancel_order' }">
          <td> 주문취소 </td>
          <td> 
            <a class="order_delivery_search" href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}"><b>주문상세</b></a><br>
          </td>
        </c:when>
        <c:when test="${order.delivery_status=='refund' }">
          <td> 반품/교환신청 </td>
          <td> 
            <a class="order_delivery_search" href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}"><b>주문상세</b></a><br>
          </td>
        </c:when>
      </c:choose>
    </tr>
  </c:forEach>
   </table>
   
   </div>
   
       <div class="paging-container">
   <c:if test="${totArticles !=null}">
      <c:choose>
         <c:when test="${totArticles > 100 }"> 
            <c:forEach var="page" begin="1" end="10" step="1">
               <c:if test="${section >1 && page==1 }" >
                  <a class="paging-button"  href="${contextPath}/mypage/listMyOrderHistory.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
               </c:if>
                  <a class="paging-button"  href="${contextPath}/mypage/listMyOrderHistory.do?section=${section-1}&pageNum=${(section-1)*10 +page }"> </a>
               <c:if test="${page ==10 }">
               <a class="paging-button"  href="${contextPath}/mypage/listMyOrderHistory.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next </a>
               </c:if>
            </c:forEach>
         </c:when>
         
         <c:when test="${totArticles ==100 }">
            <c:forEach var="page" begin="1" end="10" step="1">
            <a class="paging-button"  href="#"> ${page }</a>
            </c:forEach>
         </c:when>
         
         <c:when test="${totArticles <100 }">
            <c:forEach var="page" begin="1" end="${totArticles/10 +1 }" step="1">
               <c:choose>
                  <c:when test="${page==pageNum }">
                  <a class="paging-button" href="${contextPath}/mypage/listMyOrderHistory.do?section=${section}&pageNum=${page}">${page }</a>
                  </c:when>
               <c:otherwise>
                  <a class="paging-button"  href="${contextPath}/mypage/listMyOrderHistory.do?section=${section}&pageNum=${page}">${page }</a>
               </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:when>
      </c:choose>
   </c:if>
            
</div>
      
   
   <br><br><br><br>
   <script>
  // HTML 마지막 부분인 </body> 태그 바로 전에 이 JavaScript를 추가하세요.
  document.addEventListener('DOMContentLoaded', function() {
    const hoverImages = document.querySelectorAll('.hover-zoom-image');

    hoverImages.forEach(image => {
      image.addEventListener('mouseenter', function() {
        // 호버 시 이미지에 클래스 추가하기 (이 클래스는 CSS에서 정의할 수 있습니다)
        this.classList.add('hovered');
      });

      image.addEventListener('mouseleave', function() {
        // 마우스가 벗어날 때 추가된 클래스 제거하기
        this.classList.remove('hovered');
      });
    });
  });
</script>
</body>
</html>
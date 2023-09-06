<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    border-top: 1px solid #ccc;
    padding:10px;
    
}




.order_delivery_list { 
	width: 66%;
    margin: auto;
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


/* 버튼에 호버 효과 */
.order_delivery_search :hover{
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

/*이미지 어두워지는 호버*/
.image-hover-effect {
    transition: filter 0.3s; /* 호버 효과 애니메이션 */
    border-radius: 10px; /* 둥근 모서리 반경 */
    transition: transform 0.2s;
}

.image-hover-effect:hover {
    filter: brightness(70%); /* 어둡게 만들기 */
    transform: scale(1.1);
}

/*페이징*/
.pagination {
    display: flex; /* Flexbox를 사용하여 가운데 정렬 */
    justify-content: center; /* 가로 가운데 정렬 */
    margin-top: 20px;
    position: relative; /* position 속성 추가 */
    z-index: 11; /* 적절한 z-index 값 설정 */
}

.pagination a,
.pagination span {
    display: inline-block;
    padding: 5px 10px;
    margin: 2px;
    border: 1px solid #ccc;
    background-color: #fff;
    color: #333;
    text-decoration: none;
    border-radius: 3px;
}

.pagination a:hover {
    background-color: #f0f0f0;
}

.pagination .current {
    background-color: #ffcd29;
    color: #fff;
    border:none;
}

.pagination .disabled {
    color: #ccc;
}

/* 버튼 스타일 */
input[type="submit"] {
  background-color: #ffcd29; /* 배경색 */
  color: black; /* 텍스트색 */
  padding: 3px 14px; /* 내부 여백 */
  border: none; /* 테두리 없음 */
  border-radius: 5px; /* 테두리 반경 */
  cursor: pointer; /* 커서 모양 변경 */
  font-size: 13px; /* 폰트 크기 */
}

/* 버튼에 호버 효과 */
input[type="submit"]:hover {
  background-color: #cca300; /* 호버 시 배경색 변경 */
  color: #fff;
}



</style>
<title>주문 관리창</title>

</head>
<body>

   <div class="order_delivery_list" style="margin-left:165px;">
   <H3>주문 관리</H3>
   <hr>
   <form action="${contextPath}/seller/getSellerOrderListDATE.do?page=sellerPage&date=true" method="POST">   
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;">${memberInfo.seller_name}님 안녕하세요 </p>
               
            </td>
         </tr>
      </table>
      
      <hr>
      
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td>
               <a href="${contextPath}/seller/getSellerOrderListTODAY.do?page=sellerPage"  style="text-decoration:none;">
                  <img   src="/image/btn_search_one_day.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListONEWEEK.do?page=sellerPage"  style="text-decoration:none;">
                  <img   src="/image/btn_search_1_week.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTWOWEEK.do?page=sellerPage"  style="text-decoration:none;">
                  <img   src="/image/btn_search_2_week.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListONEMONTH.do?page=sellerPage" style="text-decoration:none;">
                  <img   src="/image/btn_search_1_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTWOMONTH.do?page=sellerPage" style="text-decoration:none;">
                  <img   src="/image/btn_search_2_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTHREEMONTH.do?page=sellerPage" style="text-decoration:none;">
                  <img   src="/image/btn_search_3_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListFOURMONTH.do?page=sellerPage" style="text-decoration:none;">
                  <img   src="/image/btn_search_4_month.jpg">
               </a>
      </td>
         <tr>
         
            <td>    
			    조회한 기간 :
			    <input type="date" size="4"  name="startDate" />
			    ~
			    <input type="date" size="4" name="endDate" />
			</td>
			<td>
			        <input type="submit" value="조회" />
			</td>
		 
         </tr>
      </table>
      
      <div class="clear">
   </div>
   </form>   
   
   <br>

<table class="order_delivery"  width="100%">
         <tr >
            <td colspan="2"style="padding-left:15px;">상품정보</td>
            <td width="130px">가격</td>
            <td width="190px">진행상태</td>
          
         </tr>
        <c:forEach items="${sellerOrderList}" var="order">
         <tr>
        
            <td>
            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${order.goods_id}">

            <img src="${contextPath}/thumbnails.do?goods_id=${order.goods_id}&fileName=${order.goods_image_name1}" style="width:100px; height:100px;  margin-top: 5px; margin-bottom: 5px;" class="image-hover-effect"></a></td>
            </td>
            <td style="text-align:left;"> 
               [<a href="${contextPath}/seller/sellerOrderDetail.do?order_id=${order.order_id}&page=sellerPage">${order.order_id}</a>]
                 ${order.goods_title}           </td>
            <td><fmt:formatNumber value="${order.final_total_price}" type="Number"  />원</td>
            
            <td>
			    <form action="${contextPath}/seller/updateDeliveryStatus" method="post">
				    <input type="hidden" name="order_id" value="${order.order_id}" />
				    <input type="hidden" name="orderNO" value="${order.orderNO}" />
				    <select name="delivery_status" style="width: 100px; height: 25px; text-align: center; border: 1px solid #ccc; border-radius: 5px;">
				        <option value="delivering" ${order.delivery_status eq 'delivering' ? 'selected' : ''}>배송중</option>
				        <option value="finished_delivering" ${order.delivery_status eq 'finished_delivering' ? 'selected' : ''}>배송완료</option>
				        <option value="cancel_order" ${order.delivery_status eq 'cancel_order' ? 'selected' : ''}>주문취소</option>
				        <option value="delivery_prepared" ${order.delivery_status eq 'delivery_prepared' ? 'selected' : ''}>배송준비중</option>
				        <option value="refund" ${order.delivery_status eq 'refund' ? 'selected' : ''}>교환/환불</option>
				    </select>
				    <input type="submit" value="등록" />
				</form>
			</td>
           

            </tr>
           </c:forEach> 
           
      </table>
      </div>      
  
  <!-- 페이징 -->
     <div class="pagination">
    <c:if test="${totalPages >= 1}">
        <c:set var="startPage" value="${currentPage - 5}" />
        <c:if test="${startPage < 1}">
            <c:set var="startPage" value="1" />
        </c:if>
        <c:set var="endPage" value="${currentPage + 5}" />
        <c:if test="${endPage > totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="?page=sellerPage&pageNum=1">First</a>
                <a href="?page=sellerPage&pageNum=${currentPage - 1}">&lt;&lt;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">First</span>
                <span class="disabled">&lt;&lt;</span>
            </c:otherwise>
        </c:choose>
        <c:forEach var="page" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="current">${page}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=sellerPage&pageNum=${page}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="?page=sellerPage&pageNum=${currentPage + 1}">&gt;&gt;</a>
                <a href="?page=sellerPage&pageNum=${totalPages}">Last</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&gt;&gt;</span>
                <span class="disabled">Last</span>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>
</body>
</html>
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






</style>
<title>상품 관리창</title>

</head>
<body>
<br><br>
   <div class="order_delivery_list">
   <H3>상품관리</H3>
   <hr>
   <form action="${contextPath}/seller/getSellerOrderListDATE.do?page=sellerPage&date=true&" method="GET">   
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;"> 사업자님 안녕하세요 </p>
               
            </td>
         </tr>
      </table>
      
      <hr>
      
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td>
               <a href="${contextPath}/seller/getSellerOrderListTODAY.do?page=sellerPage&today=true">
                  <img   src="/image/btn_search_one_day.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListONEWEEK.do?page=sellerPage&oneweek=true">
                  <img   src="/image/btn_search_1_week.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTWOWEEK.do?page=sellerPage&twoweek=true">
                  <img   src="/image/btn_search_2_week.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListONEMONTH.do?page=sellerPage&onemonth=true">
                  <img   src="/image/btn_search_1_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTWOMONTH.do?page=sellerPage&twomonth=true">
                  <img   src="/image/btn_search_2_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListTHREEMONTH.do?page=sellerPage&threemonth=true">
                  <img   src="/image/btn_search_3_month.jpg">
               </a>
               <a href="${contextPath}/seller/getSellerOrderListFOURMONTH.do?page=sellerPage&fourmonth=true">
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
            <td colspan="2" width="250px" style="padding-left:15px;">상품정보</td>
            <td>가격</td>
            <td>진행상태</td>
          
         </tr>
        <c:forEach items="${sellerOrderList}" var="order">
         <tr>
        
            <td>
            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${order.goods_id}">
            <img src="${contextPath}/thumbnails.do?goods_id=${order.goods_id}&fileName=${order.goods_image_name1}" style="width:100px;"> </a>
            </td>
            <td style="text-align:left;"> 
               [<a href="${contextPath}/mypage/myOrderDetail.do?order_id=${order.order_id}&page=sellerPage">${order.order_id}</a>]
                 ${order.goods_title}           </td>
            <td>${order.final_total_price} 원</td>
            
            
            <td>
			    <form action="${contextPath}/seller/updateDeliveryStatus" method="post">
				    <input type="hidden" name="order_id" value="${order.order_id}" />
				    <select name="delivery_status">
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
  
</body>
</html>
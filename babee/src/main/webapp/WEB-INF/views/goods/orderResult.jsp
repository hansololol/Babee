<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<fmt:parseNumber var="discounted_price" integerOnly="true" value="${goods.goods_price/10}"	/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<style>
.text_center{ 
   text-align:center;
   }

.order_ilst {
    border-collapse: collapse;
  }
.order_ilst th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
  }



/* '주문 내역 보기' 버튼 스타일 */
.myorder > a {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
}


/* 버튼에 호버 효과 */
.myorder > a:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}


</style>
<title>상품 구매 완료창</title>
</head>
<body>
   <br><br>
<div >
   <div class="text_center">
      <img src="/image/check.png" style="display:inline-block; margin-block-end: -6px;"/>
      <h3 style="display:inline-block;">상품 구매가 완료 되었습니다.</h3>
      <h5>입금계좌 정보 ${total_goods_price} ${total_goods_price} ${total_goods_price}</h5>
      <h6>3일 이내에 입금이 완료되지 않을 시 주문이 취소됩니다.</h6>
   </div>



      <table  class="order_ilst" align="center" width="50%" >
         <tr height="10" >
               <td colspan="5" style="border: none; border-bottom: 1px solid gray;"><h4 style="margin-bottom:0px;">주문내역</h4></td>
         </tr>
           <tr height="10" align="center" >
              <td width="50%" >주문상품</td>
              <td>판매금액</td>
              <td>할인금액</td>
              <td>수량</td>
              <td>소계금액</td>
           </tr>
           
           <c:forEach  var="order" items="${myOrderList}" varStatus="articleNum" >
             <tr width="80px;" height="10">
                 
                  <td style="width:100px;"> <img src="${contextPath}/thumbnails.do?goods_id=${order.goods.goods_id}&fileName=${order.goods.goods_image_name1}" width="100px">  ${order.goods.goods_title}</td>
                  <td>${order.goods.goods_price * order.order_goods_qty} 원</td>
                  <td>${discounted_price * order.order_goods_qty} 원</td>
                  <td>${order.order_goods_qty} </td>
                  <td>${(order.goods.goods_price - discounted_price) * order.order_goods_qty} 원</td>
             </tr>
            </c:forEach>
            <tr height="10" >
               <td colspan="5" style="border: none; border-bottom: 1px solid gray;" text-align="right"><h5>상품 금액  ${total_goods_price} 원 </h5><h4> + </h4><h5>배송비  3000 원</h5></td>
         	</tr>
            <tr height="10" >
               <td colspan="5" style="border: none; border-bottom: 1px solid gray;" text-align="right"><h4> 최종 결제 금액  ${total_goods_price + 3000} 원</h4></td>
         		</tr>
             
      </table>
      <br><br>
   
   <div style="text-align: center;" class="myorder">
    <a href="${contextPath}/mypage/listMyOrderHistory.do"><b>주문 내역 보기</b></a>
   </div>

   
</div>


<br><br><br><br>


</body>
</html>
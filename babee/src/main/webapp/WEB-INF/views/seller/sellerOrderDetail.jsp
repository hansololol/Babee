<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%
request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>주문 정보/배송조회</title>
    <style>
      .orange-button {
        background-color: orange;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
        margin-top: 30px;
      }

      .orange-button:hover {
        background-color: darkorange;
      }

      .orderTable {
        width: 66%;
        margin: 20px auto;
        border-collapse: collapse;
      }
      .orderTable th {
        padding: 8px;
        text-align: center;
        border-bottom: 1px solid #ddd;
      }

      .orderTable td {
        padding: 8px;
        text-align: center;
        border-bottom: 1px solid #ddd;
      }

      .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
      }

      .infoTable {
        width: 100%;
        border-collapse: collapse;
      }

      .infoTable th {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }
      .order_delivery_search {
        background-color: #ffcd29; /* 배경색 */
        color: black; /* 텍스트색 */
        padding: 5px 5px; /* 내부 여백 */
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 테두리 반경 */
        cursor: pointer; /* 커서 모양 변경 */
        text-decoration: none;
        font-size: 1px;
      }
      
    </style>
  </head>
  <body>
    <h2 style="text-align: center">주문 내역/배송조회</h2>
    <hr style="width: 66%; margin: 20px auto" />
    <table class="orderTable">
      <tr>
        <th>NO</th>
        <th>상품명</th>
        <th>수량</th>
        <th>가격</th>
        <th>주문일자</th>
        <th>주문상태</th>
        <th>반품가격(포함)</th>
      </tr>
      <c:set var="totalEarnings" value="0" />
      <c:forEach var="order" items="${orderInfoList}">
        <tr>
          <td>${order.orderNO}</td>
          <td>${order.goods_title}</td>
          <td>${order.order_goods_qty}</td>
          <td>${order.total_goods_price}</td>
          <td>${order.payment_order_time}</td>
          
          <td>
            <c:if test="${order.delivery_status=='delivery_prepared'}">
              <b>배송준비중</b>
            </c:if>

            <c:if test="${order.delivery_status=='delivering'}">
              <b>배송중</b>
            </c:if>

            <c:if test="${order.delivery_status=='finished_delivering'}">
              <b>배송완료</b>
            </c:if>

            <c:if test="${order.delivery_status=='cancel_order'}">
              <b>주문취소</b>
              <c:set var="cancelPrice" value="${(order.total_goods_price * 0.9)}" />
			  <c:set var="cancelPriceInt" value="${cancelPrice.intValue()}" />
			  
			  
			  <c:set var="totalEarnings" value="${order.final_total_price - 3000 -  cancelPriceInt}" /> <!-- 개별 주문 취소 금액을 합산 -->
            </c:if>

            <c:if test="${order.delivery_status=='refund'}">
              <b>반품/교환</b>
              <c:set var="rePrice" value = "${order.total_goods_price - order.total_goods_price - order.total_goods_price}" />
              <c:set var="returnPrice" value = "${order.returnPrice}" />
              <c:set var="deliveryPricerefund" value = "3000" />
            </c:if>

            <c:if test="${order.delivery_status=='review_write' }">
              <b>리뷰작성완료</b>
              </c:if>
              </td>
              <td>
              <c:if test="${order.delivery_status=='refund'}">
              <p style="display: flex; justify-content: center; margin-top: 15px;">${order.returnPrice}</p>
              <c:set var="totalEarnings" value="${orderInfoList[0].final_total_price - 3000 - deliveryPricerefund - returnPrice - cancelPrice}" />
              </c:if>
              
        </tr>
        <c:set var="totalGoodsPrice" value="${order.total_goods_price}" />
    <c:set var="orderGoodsQty" value="${order.order_goods_qty}" />
    <c:set var="returnPrice" value = "${order.returnPrice}"/>
    
    <c:set var="seller" value="${order.seller_name}" />
    <c:set var="orderNum" value="${order.order_id}" />
      </c:forEach>
    </table>
    
    <div class="container">
    <c:set var="totalEarnings" value="${totalEarnings}" />
    <h2 style="font-size: 24px; font-weight: bold;">[${orderNum}]</h2>
    <h3 style="font-size: 18px; margin-top: 10px;">배송비 미포함 총 수익금</h3>
    <p class="total-price" style="font-size: 20px;">
        [<span style="font-weight: bold;">
            ${orderInfoList[0].final_total_price - 3000}
        </span>] 원
    </p>
    <h3 style="font-size: 18px; margin-top: 20px;">사업자님의 실 수익금은</h3>
    <p class="earnings" style="font-size: 20px; color: #0101DF;">
        [<span style="font-weight: bold;">
            ${totalEarnings} 
        </span>] 원 입니다.
    </p>
</div>
    <div class="container">
  <h2 style="text-align: center">주문정보조회</h2>
  <div class="divider" style="border-top: 1px solid #ddd; margin: 20px 0"></div>

  <table class="infoTable">
    <tr>
      <th>결제방법</th>
      <th>${orderInfoList[0].payment_method} - ${orderInfoList[0].card_com_name}</th>
    </tr>
    <tr>
      <th>배송방법</th>
      <th>택배배송</th>
    </tr>
    <tr>
      <th>배송지</th>
      <th>${orderInfoList[0].deliveryAddr}</th>
    </tr>
    <tr>
      <th>배송 시 요청사항</th>
      <th>${orderInfoList[0].deliveryMessage}</th>
    </tr>
    <tr>
      <th>결제금액</th>
      <th>${orderInfoList[0].final_total_price} 원</th>
    </tr>
  </table>
  
      <a href="javascript:history.back()" class="orange-button">이전 페이지</a>
    </div>
    
  </body>
</html>

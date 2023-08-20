<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보/배송조회</title>
</head>
<body>
    <h2 style="text-align: center;">주문 정보/배송조회</h2>
    <hr style="width: 66%; margin: 20px auto;">
    <table style="width: 66%; margin: 20px auto; border-collapse: collapse;">
        <tr>
            <th style="width: 20%; padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">주문번호</th>
            <th style="width: 20%; padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">주문일자</th>
            <th style="width: 15%; padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">수량</th>
            <th style="width: 25%; padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">주문상태</th>
        </tr>
        <c:forEach var="order" items="${myOrderList}">
            <tr>
                <td style="padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">${order.order_id}</td>
                <td style="padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">${order.payment_order_time}</td>
                <td style="padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">${order.order_goods_qty}</td>
                <td style="padding: 8px; text-align: center; border-bottom: 1px solid #ddd;">
                <c:if test="${order.delivery_status=='delivery_prepared'}">
                	<b>배송준비중</b>
                </c:if>
                 <c:if test="${order.delivery_status=='delivering'}">
                	배송중
                </c:if>
                 <c:if test="${order.delivery_status=='finished_delivering'}">
                	배송완료
                </c:if>
                 <c:if test="${order.delivery_status=='cancel_order'}">
                	주문취소
                </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="container" style="max-width: 800px; margin: 0 auto; padding: 20px;">
        <h1 class="header" style="text-align: center;">주문내역조회</h1>
        <div class="divider" style="border-top: 1px solid #ddd; margin: 20px 0;"></div>
        
        <table class="info-table" style="width: 100%; border-collapse: collapse;">
            <tr>
                <th style="width: 40%; padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">결제방법
                 &nbsp;  &nbsp; &nbsp;  ${myOrder.payment_method} 
                 </th>
            </tr>
            <tr>
                <th style="width: 40%; padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">배송방법
                	  &nbsp;  &nbsp; &nbsp; 택배배송
                </th>
            </tr>
            <tr>
                <th style="width: 40%; padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">배송지
                  &nbsp;  &nbsp; &nbsp; ${myOrder.deliveryAddr} 
                </th>
            </tr>
            <tr>
                <th style="width: 40%; padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">배송 시 요청사항
                	  &nbsp;&nbsp; &nbsp;  ${myOrder.deliveryMessage} 
                </th>
            </tr>
            <tr>
                <th style="width: 40%; padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">결제금액
                	  &nbsp; &nbsp; &nbsp; ${myOrder.total_goods_price} 
                </th>
            </tr>
        </table>
    </div>
</body>
</html>
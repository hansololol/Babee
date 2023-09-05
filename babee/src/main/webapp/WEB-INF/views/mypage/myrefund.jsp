<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">
<style>
.shipping_address >ul li{ 
   list-style-type: none;
}

.shipping_address{
   border: 1px solid rgb(221, 221, 221);
   border-radius: 5px;
   width: 500px;
   
}

.order_list{
   border: 1px solid rgb(90, 90, 90);
   border-radius: 5px;
   width: 500px;
   display:inline-block;
}

.order_list td{

    padding-left: 7px;
    padding-top: 15px;

}

.detail_table{
   border: 1px solid rgb(221, 221, 221);
   border-radius: 5px;
   width: 500px;
   margin-top:-30px;
   padding: 0 10%;
}

#buttonRefund > input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '구매하기' 버튼 스타일 */
#buttonRefund > button[type="button"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
#buttonRefund > input[type="submit"]:hover, input[type="button"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

#selectBox {
 width: 400px;
 height: 30px;
}

.radio-1 input[type="radio"] {
        display: none;
    }

    .radio-1 input[type="radio"] + span {
        display: inline-block;
        padding: 15px 30px;
        border: 1px solid #dfdfdf;
        background-color: #ffffff;
        text-align: center;
        cursor: pointer;
        border-radius: 5px;
    }
    .radio-1 input[type="radio"]:checked + span {
        background-color: #ffe281;
        color: #000000;
    }
</style>

<title>교환 환불창</title>
</head>
<body>
    <form name="form_order" method="post" enctype="utf-8" action="${contextPath}/mypage/refundOrder.do">   
    <div style=" display: inline-block;">

      <H2 style="width:530px;">교환 환불 안내</H2>
       
      <div style=" display: inline-grid;" >
      <div class="shipping_address">
      <h3 style="display: inline-block; margin-right: 320px;"> &nbsp;&nbsp;안내사항</h3> 
      <ul>
         <li> 신청 후 상품을 문앞에 놓아주세요.</li>
      </ul>
      </div>
      
      
   
   
      <br><br>

     
      <div class="detail_table" style="display: inline-block;">
         <h3> &nbsp;&nbsp;교환 / 반품</h3> 
   
      <table style="padding-left:10px;">
            <tr>
               <td width="200px;" ><label class="radio-1" ><input type="radio" name="delivery_status" value="refund" checked><span>반품 </span></label></td>
               <td width="200px;"><label class="radio-1"><input type="radio" name="delivery_status" value="change">&nbsp;&nbsp;<span>교환 </span></label></td>
            </tr>
            
            <tr> <td colspan="2"> 
               <div class="selectopt">
               <select id="selectBox"  name = "reason_option">
                  <option value="not">불량&오배송</option>
                 <option  value="size">사이즈 교환</option>
                  <option value="heart">단순 변심</option>
                 <option value="other">기타</option> </select>
                 </div>
                 </td>
               </tr>
              <tr> <td colspan="2"> <textarea name="reason" cols="30" rows="5" style="width: 400px;"></textarea> </td> </tr>
              
                 <tr><td colspan="2"> <p style="text-align: left;">*주문 시 선택된 카드사로 환불이 요청되며 최대 3일까지 소요될 수 있습니다.</p></td></tr>
         
      </table>   
      
      <br>
    </div>
    </div>
   
    <br>
   
   
   
    </div>
   
      <div style="display: inline-table;">
      <H2>상품 선택</H2>
         <div class="order_list" >
            <table>

               <input type="hidden" name="order_id" value="${order.order_id}">
               <tr>
                  <td>목록</td>
                  <td>상품 이미지</td>
                  <td>상품명</td>
                  <td>수량</td>
                  <td>상품 옵션</td>
               </tr>
               <c:forEach var="order" items="${refundList}" varStatus="var">
               		<tr>
               		<p>${order.order_id}</p>
               		</tr>
				   <tr>
				      <input type="hidden" name="goods_id" value="${order.goods_id}" class="product-checkbox"/>
				      <input type="hidden" name="order_id" value="${order.order_id}">
				      <input type="hidden" name="goods_title" value="${order.goods_title}">
				      <input type="hidden" name="orderNO" value="${order.orderNO}"/>
				      
				      <td>${var.count}</td>
				      <td><img src="${contextPath}/thumbnails.do?goods_id=${order.goods_id}&fileName=${order.goods_image_name1}" width="100px"/></td>
				      <td width="180px;">${order.goods_title}</td>
				      <td width="80px;">${order.order_goods_qty}(개)</td>
				      <td width="80px;">${order.goods_option}</td>
				   </tr>
				</c:forEach>
            </table>   
    
               
         </div>
         <div style="display: block;">
           <H2>환불 예정 금액</H2>
         <div class="order_list">
             <table>
        <tr>
            <td width="180px;"> 취소 상품 계 </td>
            <td width="80px;">
                <c:forEach var="order" items="${refundList}">
                    ${order.total_goods_price}
                </c:forEach>
            </td>
        </tr>
        <tr>
            <td width="60px;"> 배송비 </td>
            <td width="80px;"> 3,000 </td>
        </tr>
        <tr>
            <td width="180px;"> 환불금액 </td>
            <td width="80px;">
                <b style="font-size: 20px;">
                    <c:set var="refundAmount" value="0" />
                    <c:forEach var="order" items="${refundList}">
                        <c:set var="refundAmount" value="${refundAmount + order.total_goods_price}" />
                    </c:forEach>
                    ${refundAmount - 3000}
                     <input type="hidden" name="returnPrice" value="${refundAmount - 3000}" />
                </b>
            </td>
        </tr>
    </table> 
	
         </div>
      </div>
      <div style="text-align: center; margin-top:10px;" id="buttonRefund">
              <input type="submit" value="환불하기">&nbsp;&nbsp;&nbsp;
              <button type="button"onclick="location.href='${contextPath}/mypage/listMyOrderHistory.do'">취소</button>
      </div>
      </div>
   </form>
</body>
</html>
         
         
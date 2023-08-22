<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />
<c:set var="goodsList"  value="${goodsList}"  />

<head>
<style>
.text_center {
   text-align: center;
   margin: 0 auto;
}

/* '삭제' 버튼 스타일 */
.cart_list td>a {
   background-color: #ffcd29; /* 배경색 */
   color: black; /* 텍스트색 */
   padding: 8px 8px; /* 내부 여백 */
   border: none; /* 테두리 없음 */
   border-radius: 5px; /* 테두리 반경 */
   cursor: pointer; /* 커서 모양 변경 */
   text-decoration: none;
}

/* 버튼에 호버 효과 */
.cart_list td>a:hover {
   background-color: #cca300; /* 호버 시 배경색 변경 */
}

ul li {
   list-style-type: none;
}

.cart_list {
   border-collapse: collapse;
   border-bottom: 1px solid gray;
}

.cart_list td {
   border-top: 1px solid gray;
}

.buy > a {
    background-position: 15px;
    background-color: rgb(255, 255, 166);
    color: rgb(0, 0, 0);
}
</style>



<title>장바구니 창</title>

<script type="text/javascript">

   function deleteProduct(button) {
      button.parentElement.remove();
   }

   function selectAll() {
      var checkboxes = document.querySelectorAll('.product-checkbox');
      var selectAllCheckbox = document.getElementById('select-all-checkbox');

      for (var i = 0; i < checkboxes.length; i++) {
         checkboxes[i].checked = selectAllCheckbox.checked;
      }
   }

   $(document).ready(function() {
                  // 클래스가 "product-checkbox"인 체크박스 변경 감지
                  $(".product-checkbox")
                        .change(
                              function() {

                                 var totalGoodsNum = 0;
                                 var totalGoodsPrice = 0;
                                 var totalDeliveryPrice = 0;

                                 $(".product-checkbox:checked").each(
                                             function() {
                                                var parent = $(this).closest("tr");
                                                var priceElement = parseInt(parent.find(".price").text());
                                                var quantityElement = document.getElementById('order_goods_qty').value; 
                                                var deliveryPriceElement = parseInt(parent.find(".deliveryPrice").text());

                                                
                                                totalGoodsNum++;
                                                totalGoodsPrice += (priceElement * quantityElement); 
                                                totalDeliveryPrice += deliveryPriceElement;
                                             });

                                 if (totalDeliveryPrice >= 3000) {
                                    totalDeliveryPrice = 3000;
                                 }

                                 var finalTotalPrice = totalGoodsPrice + totalDeliveryPrice;

                                 // 선택된 상품 정보 업데이트
                                 $("#p_totalGoodsNum").text(totalGoodsNum + "개");
                                 $("#p_totalGoodsPrice").text(totalGoodsPrice + "원");
                                 $("#p_totalDeliveryPrice").text(totalDeliveryPrice + "원");
                                 $("#p_final_totalPrice").text(finalTotalPrice + "원");
                              });
               });

   

   function delete_cart_goods(cart_id) {
      var cart_id = Number(cart_id);
      var formObj = document.createElement("form");
      var i_cart = document.createElement("input");
      i_cart.name = "cart_id";
      i_cart.value = cart_id;

      formObj.appendChild(i_cart);
      document.body.appendChild(formObj);
      formObj.method = "post";
      formObj.action = "${contextPath}/cart/removeCartGoods.do";
      formObj.submit();
   }

   
   function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
      var total_price,final_total_price,_goods_qty;
      var cart_goods_qty=document.getElementById("cart_goods_qty");
      
      _order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
      var formObj=document.createElement("form");
      var i_goods_id = document.createElement("input"); 
       var i_goods_title = document.createElement("input");
       var i_goods_sales_price=document.createElement("input");
       var i_fileName=document.createElement("input");
       var i_order_goods_qty=document.createElement("input");
       
       i_goods_id.name="goods_id";
       i_goods_title.name="goods_title";
       i_goods_sales_price.name="goods_sales_price";
       i_fileName.name="goods_fileName";
       i_order_goods_qty.name="order_goods_qty";
       
       i_goods_id.value=goods_id;
       i_order_goods_qty.value=_order_goods_qty;
       i_goods_title.value=goods_title;
       i_goods_sales_price.value=goods_sales_price;
       i_fileName.value=fileName;
       
       formObj.appendChild(i_goods_id);
       formObj.appendChild(i_goods_title);
       formObj.appendChild(i_goods_sales_price);
       formObj.appendChild(i_fileName);
       formObj.appendChild(i_order_goods_qty);

       document.body.appendChild(formObj); 
       formObj.method="post";
       formObj.action="${contextPath}/order/orderEachGoods.do";
       formObj.submit();
   }

   
</script>

</head>


<body>
<form action="${contextPath}/order/cartOrder.do" method="post" name="cartorderForm" enctype="multipart/form-data">
   
   <div class="text_center" style="width: 65%;">

      <div style="text-align: left;">
         <img src="/image/cart.png"
            style="display: inline-block; margin-block-end: 15px;" width="30" />
         <h3 style="display: inline-block;">나의 장바구니</h3>
         <hr>
         <br>
      </div>

      <div class="text_center">
         <table class="cart_list">
            <tr>
               <td width="80px;" height="15px;">
                  <div class="text_center">
                     <input type="checkbox" id="select-all-checkbox" onchange="selectAll()"> 전체 선택
                  </div>
               </td>
               <td colspan=3 width="600px">상품 정보</td>
            </tr>

            <c:forEach var="cartVO" items="${myCartList}">
               <tr>
                  <td class="text_center"><input type="checkbox" class="product-checkbox" style="margin-left: -71px;"></td>
                  <td><img src="${contextPath}/thumbnails.do?goods_id=${cartVO.goods_id}&fileName=${cartVO.cart_image_name}" width="100px" /></td>
                  <td>
                     <ul>
                        <li>${cartVO.goods_title}</li>
                        <li>가격 <span class="price">${cartVO.goods_price}</span></li>
                        <li>수량 <span class="quantity">
                              <input type="number" value="${cartVO.cart_goods_qty}" id="order_goods_qty" name="order_goods_qty" style="width: 200px; text-align: center;"></span> 개</li>
                        <li>옵션
                           
                              <select style="width: 200px; text-align: center" id="goods_option" name="goods_option" >
                              
                              <option value="${cartVO.goods_option1}">${cartVO.goods_option1}</option>
                              <option value="${cartVO.goods_option2}">${cartVO.goods_option2}</option>
                              <option value="${cartVO.goods_option3}">${cartVO.goods_option3}</option>
                              <option value="${cartVO.goods_option4}">${cartVO.goods_option4}</option>
                              <option value="${cartVO.goods_option5}">${cartVO.goods_option5}</option>
                           
                              </select>
                           
                              
                        </li>
                        <li>배송비 <span class="deliveryPrice">${cartVO.goods_delivery_price}</span> 원</li>
                     </ul>
                  </td>
                  <td><a href="javascript:delete_cart_goods(${cartVO.cart_id})" style="font-size: 3px;"><b><span>삭제</span></b></a>
                  </td>
               </tr>
            </c:forEach>

         </table>
      </div>
      <br> <br>

      <!-- 체크 한 상품의 정보 출력해주는 div -->
      <div class="text_center">
      
            <table width=80% class="text_center" style="background: #cacaff">
               <tbody>
                  <tr align=center class="fixed">
                     <td class="fixed">총 상품수</td>
                     <td>총 상품금액</td>
                     <td>총 배송비</td>
                     <td>최종 결제금액</td>
                  </tr>
                  
                  <tr cellpadding=40 align=center>
                     <td>
                        <p id="p_totalGoodsNum">0개</p>
                        <input id="h_totalGoodsNum" type="hidden" value="${totalGoodsNum}" />
                     </td>
                     <td>
                        <p id="p_totalGoodsPrice">
                           <fmt:formatNumber value="${totalGoodsPrice}" type="number" var="total_goods_price" />${total_goods_price}원
                        </p>
                        <input id="h_totalGoodsPrice" type="hidden" value="${totalGoodsPrice}" />
                     </td>
                     <td>
                        <p id="p_totalDeliveryPrice">${totalDeliveryPrice}원</p>
                        <input id="h_totalDeliveryPrice" type="hidden" value="${totalDeliveryPrice}" />
                     </td>
                     <td>
                        <p id="p_final_totalPrice">
                           <fmt:formatNumber value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" type="number" var="total_price" /> ${total_price}원
                        </p>
                        <input id="h_final_totalPrice" type="hidden" value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" />
                     </td>
                  </tr>
               </tbody>
            </table>
         
      </div>
   </div>


   <br><br>   <input type="submit" value="구매하기"/>
   
 </form>
</body>
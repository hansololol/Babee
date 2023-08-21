<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%-- <c:set var="myCartList"  value="${myCartList}"/> --%>
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />

<%-- <c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 --> --%>
<%-- <c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 -->  --%>
<%-- <c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 --> --%>
<head>
<style>
.text_center{ 
   text-align:center;
   margin: 0 auto;
   }

/* '삭제' 버튼 스타일 */
.cart_list td > a {
   background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 8px 8px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
}


/* 버튼에 호버 효과 */
.cart_list td > a:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

ul li {
   list-style-type:none;
}

.cart_list{
   border-collapse: collapse;
   border-bottom:1px solid gray;
}

.cart_list td {
    border-top: 1px solid gray;
    
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
    $(".product-checkbox").change(function() {
       
       var totalGoodsNum = 0;
      var totalGoodsPrice = 0;
      var totalDeliveryPrice = 0;
          
        $(".product-checkbox:checked").each(function() {
             var parent = $(this).closest("tr");
           var priceElement = parseInt(parent.find(".price").text());
            var quantityElement = parseInt(parent.find(".quantity").text());
            var deliveryPriceElement = parseInt(parent.find(".deliveryPrice").text());
            
            totalGoodsNum++;
            totalGoodsPrice += (priceElement * quantityElement);
            totalDeliveryPrice += deliveryPriceElement;
        });
        
        if(totalDeliveryPrice >= 3000){
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


function calcGoodsPrice(bookPrice,obj){
   var totalPrice,final_total_price,totalNum;
   var goods_qty=document.getElementById("select_goods_qty");
   alert("총 상품금액"+goods_qty.value);
   var p_totalNum=document.getElementById("p_totalNum");
   var p_totalPrice=document.getElementById("p_totalPrice");
   var p_final_totalPrice=document.getElementById("p_final_totalPrice");
   var h_totalNum=document.getElementById("h_totalNum");
   var h_totalPrice=document.getElementById("h_totalPrice");
   var h_totalDelivery=document.getElementById("h_totalDelivery");
   var h_final_total_price=document.getElementById("h_final_totalPrice");
   if(obj.checked==true){
   alert("체크 했음");
      
      totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
      //alert("totalNum:"+totalNum);
      totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
      //alert("totalPrice:"+totalPrice);
      final_total_price=totalPrice+Number(h_totalDelivery.value);
      //alert("final_total_price:"+final_total_price);

   }else{
   //   alert("h_totalNum.value:"+h_totalNum.value);
      totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
   //   alert("totalNum:"+ totalNum);
      totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
   //   alert("totalPrice="+totalPrice);
      final_total_price=totalPrice-Number(h_totalDelivery.value);
   //   alert("final_total_price:"+final_total_price);
   }
   
   h_totalNum.value=totalNum;
   
   h_totalPrice.value=totalPrice;
   h_final_total_price.value=final_total_price;
   
   p_totalNum.innerHTML=totalNum;
   p_totalPrice.innerHTML=totalPrice;
   p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(goods_id,bookPrice,index){
   //alert(index);
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
   if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
      _cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;      
   }else{
      _cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
   }
      
   var cart_goods_qty=Number(_cart_goods_qty);
   //alert("cart_goods_qty:"+cart_goods_qty);
   //console.log(cart_goods_qty);
   $.ajax({
      type : "post",
      async : false, //false인 경우 동기식으로 처리한다.
      url : "${contextPath}/cart/modifyCartQty.do",
      data : {
         goods_id:goods_id,
         cart_goods_qty:cart_goods_qty
      },
      
      success : function(data, textStatus) {
         //alert(data);
         if(data.trim()=='modify_success'){
            alert("수량을 변경했습니다!!");
            location.reload();
         }else{
            alert("다시 시도해 주세요!!");   
         }
         
      },
      error : function(data, textStatus) {
         alert("에러가 발생했습니다."+data);
      },
      complete : function(data, textStatus) {
         //alert("작업을완료 했습니다");
         
      }
   }); //end ajax   
}

function delete_cart_goods(cart_id){
   var cart_id=Number(cart_id);
   var formObj=document.createElement("form");
   var i_cart = document.createElement("input");
   i_cart.name="cart_id";
   i_cart.value=cart_id;
   
   formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
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

function fn_order_all_cart_goods(){
//   alert("모두 주문하기");
   var order_goods_qty;
   var order_goods_id;
   var objForm=document.frm_order_all_cart;
   var cart_goods_qty=objForm.cart_goods_qty;
   var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
   var checked_goods=objForm.checked_goods;
   var length=checked_goods.length;
   
   
   //alert(length);
   if(length>1){
      for(var i=0; i<length;i++){
         if(checked_goods[i].checked==true){
            order_goods_id=checked_goods[i].value;
            order_goods_qty=cart_goods_qty[i].value;
            cart_goods_qty[i].value="";
            cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
            //alert(select_goods_qty[i].value);
            console.log(cart_goods_qty[i].value);
         }
      }   
   }else{
      order_goods_id=checked_goods.value;
      order_goods_qty=cart_goods_qty.value;
      cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
      //alert(select_goods_qty.value);
   }
      
    objForm.method="post";
    objForm.action="${contextPath}/order/orderAllCartGoods.do";
   objForm.submit();
}

</script>
</head>
<body>

   <div class="text_center" style="width: 50%;">

      <div style="text-align: left;">
         <img src="/image/cart.png"
            style="display: inline-block; margin-block-end: -6px;" width="30" />
         <h3 style="display: inline-block;">나의 장바구니</h3>
         <hr>
         <br>
      </div>

      <div class="text_center">
         <table class="cart_list">
            <tr>
               <td width="30%" height="15px;">
                  <div class="text_center">
                     <input type="checkbox" id="select-all-checkbox" onchange="selectAll()"> 전체 선택
                  </div>
               </td>
               <td colspan=3 width="600px">상품 정보</td>
            </tr>

            <c:forEach var="cartVO" items="${myCartList}">
               <tr>
                  <td class="text_center"><input type="checkbox" class="product-checkbox" style="margin-left: -71px;"></td>
                  <td><img src="/image/lego.jpg" width="100px" /></td>
                  <td>
                     <ul>
                        <li>${cartVO.goods_title}</li>
                        <li>가격 <span class="price">${cartVO.goods_price}</span></li>
                        <li>수량 <span class="quantity">${cartVO.cart_goods_qty}</span> 개</li>
                        <li>옵션 <span>${cartVO.goods_option}</span> 번</li>
                        <li>배송비 <span class="deliveryPrice">${cartVO.goods_delivery_price}</span> 원</li>
                     </ul>
                  </td>
                  <td><a href="javascript:fn_order_all_cart_goods()" style="font-size: 3px;"><b><span>삭제</span></b></a>
                  </td>
               </tr>
            </c:forEach>

         </table>
      </div>
      <br> <br>

      <!-- 체크 한 상품의 정보 출력해주는 div -->
      <div class="text_center">
         <form action="">
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
         </form>
      </div>
   </div>


   <br><br>   
      <a href="javascript:fn_order_all_cart_goods()">
      <img width="75"  src="/image/btn_order_final.jpg">
   </a>
   <a href="#">
      <img width="75" src="/image/btn_shoping_continue.jpg">
   </a>
<br><br><br><br>   
</body>
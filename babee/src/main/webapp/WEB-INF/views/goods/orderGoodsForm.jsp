<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<fmt:parseNumber var="discounted_price" integerOnly="true" value="${goods.goods_price/10}"	/>


<head>
    
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<style>


ul li{ 
   list-style-type: none;
}

.shipping_address{
   border: 1px solid gray;
   width: 500px;
   
}

.order_list{
   border: 1px solid gray;
   width: 500px;
   display:inline-block;
}

.order_list td{

    padding-left: 30px;
    padding-top: 15px;

}

.detail_table{
   border: 1px solid gray;
   width: 500px;
   margin-top:-30px;

}

#layer {
   z-index: 2;
   position: absolute;
   top: 0px;
   left: 0px;
   width: 100%;
   /* background-color:rgba(0,0,0,0.8); */
}

#popup_order_detail {
   z-index: 3;
   position: fixed;
   text-align: center;
   left: 10%;
   top: 0%;
   width: 60%;
   height: 100%;
   background-color:#ccff99;
   border: 2px solid  #0000ff;
}

#close {
   z-index: 4;
   float: right;
}

.orderinput > input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '구매하기' 버튼 스타일 */
.orderinput > input[type="reset"], .shipping_address>button {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
.orderinput > input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('member_zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('member_roadAddr').value = fullRoadAddr;
      document.getElementById('member_jibunAddr').value = data.jibunAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }
      
     
    }
  }).open();
}

</script>
</head>
<body>
   <H1>상품 구매하기</H1>
   
   
      <div style=" display: inline-block;">
      
   <div style=" display: inline-grid;" >
      <H2 style="width:530px;">주문자 정보 입력</H2>

      <div class="shipping_address">
      <h3 style="display: inline-block; margin-right: 320px;"> &nbsp;&nbsp;배송지</h3> <button onclick="execDaumPostcode()" style="cursor: pointer;">배송지 변경</button>
      <form  name="form_order" action="${contextPath}/order/payToOrderGoods.do" enctype="utf-8" method="post">
      <ul>
         <li> 주문자 :  ${memberInfo.member_name } </li>         
     	 <li> 우편번호 : <input name="member_zipcode" type="text" size="10" value="${memberInfo.member_zipcode }"  id="member_zipcode" ><br>
 		 	  도로명 주소 <input name="member_roadAddr" type="text" size="50" value="${memberInfo.member_roadAddr }"  id="member_roadAddr" > <br>
 			  지번 주소 <input name="member_jibunAddr" type="text" size="50" value="${memberInfo.member_jibunAddr }" id="member_jibunAddr" > <br>
 			  나머지 주소<input name="member_namujiAddr" type="text" size="50" value="${memberInfo.member_namujiAddr }" id="member_namujiAddr" ></li>
 
         <li> 연락처 : ${memberInfo.member_hp1} - ${memberInfo.member_hp2} - ${memberInfo.member_hp3} </li>
         <br>
         <li><input type="text" size="50" placeholder="요청사항을1 입력해주세요." name="deliveryMessage"></li>
      </ul>
      </div>
      
      
   
   
   <br><br>

   
   <div class="detail_table" style="display: inline-block;">
         <h3> &nbsp;&nbsp;결제 수단</h3> 
   
      <table style="padding-left:10px;">
            <tr>
               <td width="180px;" ><input type="radio" id="card" name="pay_method" value="체크/신용카드"   onClick="fn_pay_card()" checked>체크/신용카드 
               <td width="180px;"><input type="radio" id="kakaopay" name="pay_method" value="카카오 페이"  >&nbsp;&nbsp;카카오 페이 </td>
               <td width="180px;"><input type="radio" id="bankbook" name="pay_method" value="무통장 입금">&nbsp;무통장 입금 </td>
            </tr>
         <tr>
         <td  colspan="3" ><a href="#"><img src="/image/pay.png" width="460px" style="padding-top: 10px;"></a></td>
         <tr>
      </table>   
   </div>
   
   <br>
   
   
   
   </div>
   
   <div style="display: inline-table;">
      <H2>주문 상품 목록</H2>
         <div class="order_list" >
            <table>
               <c:forEach var="order" items="${orderInfo}">
               <tr>
                  <td width="180px;"><img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" width="80px;"/></td>
                  <td width="180px;"> ${goods.goods_title} </td>
                  <td  width="80px;"> ${order.order_goods_qty} (개) </td>
                  <input type="hidden" name="order_goods_qty" value="${order.order_goods_qty}">
               </tr>
               <tr>
                  <td>상품 옵션 ${order.goods_option}</td>

               </tr>
               </c:forEach>
            </table>   
            <hr>
               <h4 style="padding-left:30px;">상품 금액 ${goods.goods_price}</h4>
               <h4 style="padding-left:30px;">할인 금액 ${discounted_price}</h4>
            <hr>
               <h5 style="padding-left:30px;" name="goods_delivery_price" value=" ${goods.goods_delivery_price}">배송비  ${goods.goods_delivery_price}</h5>
               <input type="hidden" name="goods_delivery_price" value="${goods.goods_delivery_price}">
            <hr>
               <c:set var="total_goods_price" value="${(goods.goods_price - discounted_price)}"/>
               <h4 style="padding-left:30px;">총 결제 금액   ${total_goods_price}</h4>
               <h3 style="padding-right:30px; text-align:right;"></h3>
               <input type="hidden" name="total_goods_price" value="${total_goods_price}">
               
         </div>

         
                  <div style="text-align: center; margin-top:10px;" class="orderinput">
                         <input type="submit"  value="구매하기">&nbsp;&nbsp;&nbsp;
                        <input type="reset" value="취소">
                  </div>


    	</div>
</form>
   </body>
         
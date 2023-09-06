<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />


<head>
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>


ul li{ 
   list-style-type: none;
}

.shipping_address{
   border: 1px solid gray;
   width: 500px;
   
}
.shipping_address > li {
   width: 400px;
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
   width: 500px;
   border: 1px solid gray;
   margin-top:-30px;

}
/*
#cardList {
   width: 70px;
   display:block;
   margin-left: 20px;
}
#cardList button {
   margin: 10px;
   border: none;
}
#cardList img {
   width: 80px;
   height: 70px;
}
*/

#kakaopayBtn img{
   width: 150px;
   margin: 100px;
}
#bankbookBtn img{
   width: 300px;
   margin: 100px;
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

.cardList input[type=radio]{
    display: none;
}
.cardList input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
}
.cardList input[type=radio]+label img{
    width: 80px;
    margin: 10px;
}
.cardList input[type=radio]+label{
   border: none;
}
.cardList input[type=radio]:checked+label{
   border: 2px solid #ffcd29;;
}
.pay_method span {
   margin-right: 10px;
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


function fnOrderGoods() {
    var cartOrderArr = [];

    var selectedCheckboxes = $(".product-checkbox:checked");
    if (selectedCheckboxes.length === 0) {
        alert("선택된 상품이 없습니다.");
        return;
    }

    selectedCheckboxes.each(function () {
        var row = $(this).closest("tr");
        var goodsId = row.find(".goodsId").val();
        var quantity = row.find("#order_goods_qty").val();
        var option = row.find("#_goods_option").val();

        cartOrderArr.push({
            goodsId: goodsId,
            quantity: quantity,
            option: option
        });
    });


    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "${contextPath}/order/payToOrderGoods.do");

    // cartOrderArr을 반복하며 입력 생성 및 추가
    for (var i = 0; i < cartOrderArr.length; i++) {
        var orderData = cartOrderArr[i];

        var inputGoodsId = document.createElement("input");
        inputGoodsId.setAttribute("type", "hidden");
        inputGoodsId.setAttribute("name", "selected_goods_id");
        inputGoodsId.setAttribute("value", orderData.goodsId);
        form.appendChild(inputGoodsId);

        var inputQuantity = document.createElement("input");
        inputQuantity.setAttribute("type", "hidden");
        inputQuantity.setAttribute("name", "selected_quantity");
        inputQuantity.setAttribute("value", orderData.quantity);
        form.appendChild(inputQuantity);

        var inputOption = document.createElement("input");
        inputOption.setAttribute("type", "hidden");
        inputOption.setAttribute("name", "selected_option");
        inputOption.setAttribute("value", orderData.option);
        form.appendChild(inputOption);
    }

    document.body.appendChild(form);
    form.submit();
}


$(function (){
  $('input[type="radio"][id="card"]').on('click', function(){
   var chkValue = $('input[type=radio][id="card"]:checked').val();
   if(chkValue){
              $('.cardList').css('display','block');
              $('#kakaopayBtn').css('display','none');
              $('#bankbookBtn').css('display','none');
              $('#normalOrder').css('display','block');
              $('#kakaoOrder').css('display','none');
   } 
 }); 
});
$(function (){
  $('input[type="radio"][id="kakaopay"]').on('click', function(){
   var chkValue = $('input[type=radio][id="kakaopay"]:checked').val();
   if(chkValue){
              $('.cardList').css('display','none');
              $('#kakaopayBtn').css('display','block');
              $('#bankbookBtn').css('display','none');
              $('#normalOrder').css('display','none');
              $('#kakaoOrder').css('display','block');
   } 
 }); 
});

$(function (){
  $('input[type="radio"][id="bankbook"]').on('click', function(){
   var chkValue = $('input[type=radio][id="bankbook"]:checked').val();
   if(chkValue){
              $('.cardList').css('display','none');
              $('#kakaopayBtn').css('display','none');
              $('#bankbookBtn').css('display','block');
              $('#normalOrder').css('display','block');
              $('#kakaoOrder').css('display','none');
   } 
 }); 
});
var popup;
$(function(){
	$('#apiBtn').click(function(){
		$.ajax({
			url:'${contextPath}/jq/kakaopay.do',
			dataType:'json',
			success: function(data){
            var box = data.next_redirect_pc_url;
            const width = 800;
            const height = 200;

let left = (document.body.offsetWidth / 2) - (width / 2);
let tops = (document.body.offsetHeight) - (height / 10);
               
            popup=window.open(box,"카카오페이 결제창", "width=800, height=700, top="+tops+",left=" +left);
			},
			error: function(error) {
				alert(error);
			}
		})
	})
})

if("${kakaoSuccess}"!= '' ){
               window.close();
            
               }  
               
</script>
</head>
<body>
   <br>
   <H1>상품 구매하기 </H1>
   
   
      <div style=" display: inline-block;">
      
   <div style=" display: inline-grid;" >
      <H2 style="width:530px;">주문자 정보 입력</H2>

      <div class="shipping_address">
         <br>
      <h3 style="display: inline-block; margin-right: 320px;"> &nbsp;&nbsp;배송지</h3> <button onclick="execDaumPostcode()" style="cursor: pointer; float: right;
      margin: 0 58px;">배송지 변경</button>
      <form  name="form_order" action="${contextPath}/order/payToOrderGoods.do" enctype="utf-8" method="post" id="kakaoForm">
      <ul>
         <li style="margin-top: 20px;"></li>      
         <c:if test="${memberInfo.member_id !=null}">   
     	 <li> 우편번호 : <input name="member_zipcode" type="text" size="10" value="${memberInfo.member_zipcode }"  id="member_zipcode" ><br>
 		 	  도로명 주소 <input name="member_roadAddr" type="text" size="45" value="${memberInfo.member_roadAddr }"  id="member_roadAddr" > <br>
 			  지번 주소 <input name="member_jibunAddr" type="text" size="45" value="${memberInfo.member_jibunAddr }" id="member_jibunAddr" > <br>
 			  나머지 주소<input name="member_namujiAddr" type="text" size="45" value="${memberInfo.member_namujiAddr }" id="member_namujiAddr" ></li>
 
         <li> 연락처 : ${memberInfo.member_hp1} - ${memberInfo.member_hp2} - ${memberInfo.member_hp3} </li>
      </c:if>
      <c:if test="${memberInfo.member_id ==null}">   
         <li> 우편번호 : <input name="member_zipcode" type="text" size="10" value="${memberInfo.seller_zipcode }"  id="member_zipcode" ><br>
            도로명 주소 <input name="member_roadAddr" type="text" size="45" value="${memberInfo.seller_roadAddr }"  id="member_roadAddr" > <br>
           지번 주소 <input name="member_jibunAddr" type="text" size="45" value="${memberInfo.seller_jibunAddr }" id="member_jibunAddr" > <br>
           나머지 주소<input name="member_namujiAddr" type="text" size="45" value="${memberInfo.seller_namujiAddr }" id="member_namujiAddr" ></li>

        <li> 연락처 : ${memberInfo.seller_hp1} - ${memberInfo.seller_hp2} - ${memberInfo.seller_hp3} </li>   
      </c:if>
         <br>
         <li><input type="text" size="45" placeholder="요청사항을 입력해주세요." name="deliveryMessage"></li>
      </ul>
      </div>
      
      
   
   
     <br><br>

   
    <div class="detail_table">
         <h3>결제 수단</h3> 
         <div class="pay_method">
               <span><input type="radio" id="card" name="pay_method" value="체크/신용카드" checked>체크/신용카드</span>
               <span id="apiBtn"><input type="radio" id="kakaopay" name="pay_method" value="카카오 페이" >카카오 페이</span>
               <span><input type="radio" id="bankbook" name="pay_method" value="무통장 입금">무통장 입금</span>
         </div>
    
      <div class="cardList">
         <input type="radio" id="HDcard" name="card_com_name" value="현대카드"><label for="HDcard"><img src="/image/1.현대카드.png"></label>
         <input type="radio" id="KMcard" name="card_com_name" value="국민카드"><label for="KMcard"><img src="/image/2.국민카드.png"></label>
         <input type="radio" id="SHcard" name="card_com_name" value="신한카드"><label for="SHcard"><img src="/image/3.신한카드.png"></label>
         <input type="radio" id="SScard" name="card_com_name" value="삼성카드"><label for="SScard"><img src="/image/4.삼성카드.png"></label>
         <input type="radio" id="BCcard" name="card_com_name" value="비씨카드"><label for="BCcard"><img src="/image/5.비씨카드.png"></label>
         <input type="radio" id="WRcard" name="card_com_name" value="우리카드"><label for="WRcard"><img src="/image/6.우리카드.png"></label>
         <input type="radio" id="NHcard" name="card_com_name" value="농협카드"><label for="NHcard"><img src="/image/7.농협카드.png"></label>
         <input type="radio" id="HNcard" name="card_com_name" value="하나카드"><label for="HNcard"><img src="/image/8.하나카드.png"></label>
         <input type="radio" id="LTcard" name="card_com_name" value="롯데카드"><label for="LTcard"><img src="/image/9.롯데카드.png"></label>
         <input type="radio" id="MTcard" name="card_com_name" value="마스터카드"><label for="MTcard"><img src="/image/10.마스터카드.png"></label>
         <input type="radio" id="CTcard" name="card_com_name" value="씨티카드"><label for="CTcard"><img src="/image/11.씨티카드.png"></label>
         <input type="radio" id="KKOcard" name="card_com_name" value="카카오뱅크"><label for="KKOcard"><img src="/image/12.카카오뱅크.png"></label>

      </div>
      <div id="kakaopayBtn" style="display:none; cursor: pointer;"><img src="/image/payment_icon_yellow_medium.png"  name="card_com_name" value="카카오페이"></div>   
      <div id="bankbookBtn" style="display:none;"><img src="/image/무통장입금.png" name="card_com_name" value="카카오뱅크 3333-02-9467466"></div>
    </div>
   
    <br>

   
   
      </div>
   
    <div style="display: inline-table;">
      <H2>주문 상품 목록</H2>
         <div class="order_list" >
            <table>
               <c:forEach var="order" items="${orderInfo}" varStatus="status">
               <tr>
                  <td width="180px;"><img src="${contextPath}/thumbnails.do?goods_id=${order.goods.goods_id}&fileName=${order.goods.goods_image_name1}" width="80px;"/></td>
                  <td width="180px;"> ${order.goods_title}</td>  
                  <td  width="80px;"> ${order.order_goods_qty}<input type="hidden" name="order_goods_qty" value="${order.order_goods_qty}"> (개) </td> 
                  
               </tr>
               <tr>
                  <td>상품 옵션 ${order.goods_option}</td>
               </tr>
               </c:forEach>
            </table>   
            <hr>  
               <h5 style="padding-left:30px;">상품 합계 <fmt:formatNumber value="${total_goods_price}"  pattern="##,###,### 원"/></h4>
               <h5 style="padding-left:30px;">할인 금액 <fmt:formatNumber value="${discounted_price}"  pattern="##,###,### 원"/></h4>
            <hr>
               
               <h6 style="padding-left:30px;" name="goods_delivery_price">배송비  3,000 원</h5>
               <input type="hidden" name="goods_delivery_price" value="3000">
            <hr>
               <h4 style="padding-left:30px;">총 결제 금액  <fmt:formatNumber value="${total_goods_price - discounted_price + 3000}"  pattern="##,###,### 원"/></h4>
               <input type="hidden" name="total_goods_price" value="${total_goods_price - discounted_price}">
         </div>

         
                  <div id="normalOrder" style="text-align: center; margin-top:10px;" class="orderinput">
                        <input type="submit"  value="구매하기">&nbsp;&nbsp;&nbsp;
                        <input type="reset" value="취소">
                  </div>
                  <div id="kakaoOrder" style="display:none; text-align: center; margin-top:10px;" class="orderinput">
                     <input type="submit"  value="카카오페이 결제 완료하기">&nbsp;&nbsp;&nbsp;
                     <input type="reset" value="취소">
               </div>


    	</div>
	</form>
   </body>
         
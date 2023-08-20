<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!-- 주문자 휴대폰 번호 -->
<c:set  var="orderer_hp" value=""/>
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0" />

<head>
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

input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '구매하기' 버튼 스타일 */
input[type="reset"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}


#selectBox {
 width: 200px;
}
</style>
<title>교환 환불창</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>


   
function fn_pay_phone(){
   
   
   var e_card=document.getElementById("tr_pay_card");
   var e_phone=document.getElementById("tr_pay_phone");
   e_card.style.visibility="hidden";
   e_phone.style.visibility="visible";
}

function fn_pay_card(){
   var e_card=document.getElementById("tr_pay_card");
   var e_phone=document.getElementById("tr_pay_phone");
   e_card.style.visibility="visible";
   e_phone.style.visibility="hidden";
}

function imagePopup(type) {
   if (type == 'open') {
      // 팝업창을 연다.
      jQuery('#layer').attr('style', 'visibility:visible');

      // 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
      jQuery('#layer').height(jQuery(document).height());
   }

   else if (type == 'close') {

      // 팝업창을 닫는다.
      jQuery('#layer').attr('style', 'visibility:hidden');
   }
}

var goods_id="";
var goods_title="";
var goods_fileName="";

var order_goods_qty
var each_goods_price;
var total_order_goods_price;
var total_order_goods_qty;
var orderer_name
var receiver_name
var hp1;
var hp2;
var hp3;

var tel1;
var tel2;
var tel3;

var receiver_hp_num;
var receiver_tel_num;
var delivery_address;
var delivery_message;
var delivery_method;
var gift_wrapping;
var pay_method;
var card_com_name;
var card_pay_month;
var pay_orderer_hp_num;

function fn_show_order_detail(){
   goods_id="";
   goods_title="";
   
   var frm=document.form_order;
   var h_goods_id=frm.h_goods_id;
   var h_goods_title=frm.h_goods_title;
   var h_goods_fileName=frm.h_goods_fileName;
   var r_delivery_method  =  frm.delivery_method;
   var h_order_goods_qty=document.getElementById("h_order_goods_qty");
   var h_total_order_goods_qty=document.getElementById("h_total_order_goods_qty");
   var h_total_sales_price=document.getElementById("h_total_sales_price");
   var h_final_total_Price=document.getElementById("h_final_total_Price");
   var h_orderer_name=document.getElementById("h_orderer_name");
   var i_receiver_name=document.getElementById("receiver_name");
   
   
   if(h_goods_id.length <2 ||h_goods_id.length==null){
      goods_id+=h_goods_id.value;
   }else{
      for(var i=0; i<h_goods_id.length;i++){
         goods_id+=h_goods_id[i].value+"<br>";
         
      }   
   }
   
   if(h_goods_title.length <2 ||h_goods_title.length==null){
      goods_title+=h_goods_title.value;
   }else{
      for(var i=0; i<h_goods_title.length;i++){
         goods_title+=h_goods_title[i].value+"<br>";
         
      }   
   }
   
   
   if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
      goods_fileName+=h_goods_fileName.value;
   }else{
      for(var i=0; i<h_goods_fileName.length;i++){
         goods_fileName+=h_goods_fileName[i].value+"<br>";
         
      }   
   }
   
   
   total_order_goods_price=h_final_total_Price.value;
   total_order_goods_qty=h_total_order_goods_qty.value;
   
   for(var i=0; i<r_delivery_method.length;i++){
     if(r_delivery_method[i].checked==true){
       delivery_method=r_delivery_method[i].value
       break;
     }
   } 
      
   var r_gift_wrapping  =  frm.gift_wrapping;
   
   
   for(var i=0; i<r_gift_wrapping.length;i++){
     if(r_gift_wrapping[i].checked==true){
        gift_wrapping=r_gift_wrapping[i].value
       break;
     }
   } 
   
   var r_pay_method  =  frm.pay_method;
   
   for(var i=0; i<r_pay_method.length;i++){
     if(r_pay_method[i].checked==true){
        pay_method=r_pay_method[i].value
        if(pay_method=="신용카드"){
         var i_card_com_name=document.getElementById("card_com_name");
         var i_card_pay_month=document.getElementById("card_pay_month");
         card_com_name=i_card_com_name.value;
         card_pay_month=i_card_pay_month.value;
         pay_method+="<Br>"+
                   "카드사:"+card_com_name+"<br>"+
                   "할부개월수:"+card_pay_month;
         pay_orderer_hp_num="해당없음";
         
        }else if(pay_method=="휴대폰결제"){
         var i_pay_order_tel1=document.getElementById("pay_order_tel1");
         var i_pay_order_tel2=document.getElementById("pay_order_tel2");
         var i_pay_order_tel3=document.getElementById("pay_order_tel3");
         pay_orderer_hp_num=i_pay_order_tel1.value+"-"+
                            i_pay_order_tel2.value+"-"+
                         i_pay_order_tel3.value;
         pay_method+="<Br>"+"결제휴대폰번호:"+pay_orderer_hp_num;
         card_com_name="해당없음";
         card_pay_month="해당없음";
        } //end if
       break;
     }// end for
   }
   
   var i_hp1=document.getElementById("hp1");
   var i_hp2=document.getElementById("hp2");
   var i_hp3=document.getElementById("hp3");
   
   var i_tel1=document.getElementById("tel1");
   var i_tel2=document.getElementById("tel2");
   var i_tel3=document.getElementById("tel3");
   
   var i_zipcode=document.getElementById("zipcode");
   var i_roadAddress=document.getElementById("roadAddress");
   var i_jibunAddress=document.getElementById("jibunAddress");
   var i_namujiAddress=document.getElementById("namujiAddress");
   var i_delivery_message=document.getElementById("delivery_message");
   var i_pay_method=document.getElementById("pay_method");

//   alert("총주문 금액:"+total_order_goods_price);
   order_goods_qty=h_order_goods_qty.value;
   //order_total_price=h_order_total_price.value;
   
   orderer_name=h_orderer_name.value;
   receiver_name=i_receiver_name.value;
   hp1=i_hp1.value;
   hp2=i_hp2.value;
   hp3=i_hp3.value;
   
   tel1=i_tel1.value;
   tel2=i_tel2.value;
   tel3=i_tel3.value;
   
   receiver_hp_num=hp1+"-"+hp2+"-"+hp3;
   receiver_tel_num=tel1+"-"+tel2+"-"+tel3;
   
   delivery_address="우편번호:"+i_zipcode.value+"<br>"+
                  "도로명 주소:"+i_roadAddress.value+"<br>"+
                  "[지번 주소:"+i_jibunAddress.value+"]<br>"+
                          i_namujiAddress.value;
   
   delivery_message=i_delivery_message.value;
   
   var p_order_goods_id=document.getElementById("p_order_goods_id");
   var p_order_goods_title=document.getElementById("p_order_goods_title");
   var p_order_goods_qty=document.getElementById("p_order_goods_qty");
   var p_total_order_goods_qty=document.getElementById("p_total_order_goods_qty");
   var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
   var p_orderer_name=document.getElementById("p_orderer_name");
   var p_receiver_name=document.getElementById("p_receiver_name");
   var p_delivery_method=document.getElementById("p_delivery_method");
   var p_receiver_hp_num=document.getElementById("p_receiver_hp_num");
   var p_receiver_tel_num=document.getElementById("p_receiver_tel_num");
   var p_delivery_address=document.getElementById("p_delivery_address");
   var p_delivery_message=document.getElementById("p_delivery_message");
   var p_gift_wrapping=document.getElementById("p_gift_wrapping");   
   var p_pay_method=document.getElementById("p_pay_method");
   
   p_order_goods_id.innerHTML=goods_id;
   p_order_goods_title.innerHTML=goods_title;
   p_total_order_goods_qty.innerHTML=total_order_goods_qty+"개";
   p_total_order_goods_price.innerHTML=total_order_goods_price+"원";
   p_orderer_name.innerHTML=orderer_name;
   p_receiver_name.innerHTML=receiver_name;
   p_delivery_method.innerHTML=delivery_method;
   p_receiver_hp_num.innerHTML=receiver_hp_num;
   p_receiver_tel_num.innerHTML=receiver_tel_num;
   p_delivery_address.innerHTML=delivery_address;
   p_delivery_message.innerHTML=delivery_message;
   p_gift_wrapping.innerHTML=gift_wrapping;
   p_pay_method.innerHTML=pay_method;
   imagePopup('open');
}

function fn_process_pay_order(){
   
   alert("최종 결제하기");
   var formObj=document.createElement("form");
    var i_receiver_name=document.createElement("input");
    
    var i_receiver_hp1=document.createElement("input");
    var i_receiver_hp2=document.createElement("input");
    var i_receiver_hp3=document.createElement("input");
   
    var i_receiver_tel1=document.createElement("input");
    var i_receiver_tel2=document.createElement("input");
    var i_receiver_tel3=document.createElement("input");
    
    var i_delivery_address=document.createElement("input");
    var i_delivery_message=document.createElement("input");
    var i_delivery_method=document.createElement("input");
    var i_gift_wrapping=document.createElement("input");
    var i_pay_method=document.createElement("input");
    var i_card_com_name=document.createElement("input");
    var i_card_pay_month=document.createElement("input");
    var i_pay_orderer_hp_num=document.createElement("input");
   
    i_receiver_name.name="receiver_name";
    i_receiver_hp1.name="receiver_hp1";
    i_receiver_hp2.name="receiver_hp2";
    i_receiver_hp3.name="receiver_hp3";
   
    i_receiver_tel1.name="receiver_tel1";
    i_receiver_tel2.name="receiver_tel2";
    i_receiver_tel3.name="receiver_tel3";
   
    i_delivery_address.name="delivery_address";
    i_delivery_message.name="delivery_message";
    i_delivery_method.name="delivery_method";
    i_gift_wrapping.name="gift_wrapping";
    i_pay_method.name="pay_method";
    i_card_com_name.name="card_com_name";
    i_card_pay_month.name="card_pay_month";
    i_pay_orderer_hp_num.name="pay_orderer_hp_num";
  
    i_receiver_name.value=receiver_name;
    i_receiver_hp1.value=hp1;
    i_receiver_hp2.value=hp2;
    i_receiver_hp3.value=hp3;
    
    i_receiver_tel1.value=tel1;
    i_receiver_tel2.value=tel2;
    i_receiver_tel3.value=tel3;
    ;
    i_delivery_address.value=delivery_address;
    i_delivery_message.value=delivery_message;
    i_delivery_method.value=delivery_method;
    i_gift_wrapping.value=gift_wrapping;
    i_pay_method.value=pay_method;
    i_card_com_name.value=card_com_name;
    i_card_pay_month.value=card_pay_month;
    i_pay_orderer_hp_num.value=pay_orderer_hp_num;
    
    formObj.appendChild(i_receiver_name);
    formObj.appendChild(i_receiver_hp1);
    formObj.appendChild(i_receiver_hp2);
    formObj.appendChild(i_receiver_hp3);
    formObj.appendChild(i_receiver_tel1);
    formObj.appendChild(i_receiver_tel2);
    formObj.appendChild(i_receiver_tel3);

    formObj.appendChild(i_delivery_address);
    formObj.appendChild(i_delivery_message);
    formObj.appendChild(i_delivery_method);
    formObj.appendChild(i_gift_wrapping);
    
    formObj.appendChild(i_pay_method);
    formObj.appendChild(i_card_com_name);
    formObj.appendChild(i_card_pay_month);
    formObj.appendChild(i_pay_orderer_hp_num);
    

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/payToOrderGoods.do";
    formObj.submit();
   imagePopup('close');
}
</script>
</head>
<body>
   
<form  name="form_order">   
    <div style=" display: inline-block;">
      <h3>주문번호 $[] </h3>
 	 
      
      <H2 style="width:530px;">교환 환불 안내</H2>
       <div style=" display: inline-grid;" >
      <div class="shipping_address">
      <h3 style="display: inline-block; margin-right: 320px;"> &nbsp;&nbsp;요청사항</h3> 
      <ul>
         <li> 상품을 문앞에 놓아주세요.</li>
      </ul>
      </div>
      
      
   
   
   <br><br>

   
   <div class="detail_table" style="display: inline-block;">
         <h3> &nbsp;&nbsp;교환 / 반품</h3> 
   
      <table style="padding-left:10px;">
            <tr>
               <td width="180px;" ><input type="radio" id="pay_method" name="pay_method" value="반품"   onClick="fn_pay_card()" checked>반품 
               <td width="180px;"><input type="radio" id="pay_method" name="pay_method" value="교환"  >&nbsp;&nbsp;교환 </td>
               <td> </td>
            </tr>
            
            <tr> <td colspan="2"> 
               <div class="selectopt">
               <select id="selectBox">
                  <option value="option1">옵션 1</option>
                 <option value="option2">옵션 2</option>
                  <option value="option3">옵션 3</option>
                 <option value="option4">옵션 4</option> </select>
                 </div>
                 </td>
                 
              <tr> <td>  <textarea name="opinion" cols="30" rows="5"></textarea> </td> </tr>
              
                 <tr><td colspan="3"> <h5>*주문 시 선택된 카드사로 환불이 요청되며 최대 3일까지 소요될 수 있습니다.</h5></td>
              </tr>
            
         
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
               <tr>
                  <td><input type="checkbox" class="product-checkbox"/></td>
                  <td width="180px;"><img src="images/doog.jpg" width="80px;"/></td>
                  <td width="180px;"> 상품명 </td>
                  <td  width="80px;"> 수량 (개) </td>
               </tr>
               <tr>
                  <td><input type="checkbox" class="product-checkbox"/></td>
                  <td width="180px;"><img src="images/doog.jpg" width="80px;"/></td>
                  <td width="60px;"> 상품명 </td>
                  <td width="80px;"> 수량 (개) </td>
               </tr>
               <tr>
                  <td><input type="checkbox" class="product-checkbox"/></td>
                  <td width="180px;"><img src="images/doog.jpg" width="80px;"/></td>
                  <td width="180px;"> 상품명 </td>
                  <td  width="80px;"> 수량 (개) </td>
               </tr>
               
   
               
            </table>   
            
            
               
         </div>
         <div style="display: block;">
      <H2>환불 예정 금액</H2>
         <div class="order_list" >
            <table>
               <tr>
                  

                  <td width="180px;"> 취소 상품 총 함계 </td>
                  <td  width="80px;"> 30,000 </td>
               </tr>
               <tr>
                  
                  
                  <td width="60px;"> 배송비 </td>
                  <td width="80px;"> 2,500 </td>
               </tr>
               <tr>
                  
                  <td width="180px;"> 실 환불금액 </td>
                  <td  width="80px;"> <b>27,000</b> </td>
               </tr>
               
   
               
            </table>   
            
            
               
         </div>
                  

      </div>
      <div class="clear"></div>   
      <div style="text-align: center; margin-top:10px;">
                         <input type="submit" value="환불하기">&nbsp;&nbsp;&nbsp;
                        <input type="reset" value="취소">
                  </div>
      
   </form>
   
   <br>
  <br> 
   
         </body>
         
         
         
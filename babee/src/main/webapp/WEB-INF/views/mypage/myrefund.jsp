<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<head>
<style>
.shipping_address >ul li{ 
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
</head>
<body>
   
<form  name="form_order">   
    <div style=" display: inline-block;">
      <h3>주문번호 $[] </h3>
 	 
      
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
               <td width="180px;" ><input type="radio" id="pay_method" name="pay_method" value="반품"   onClick="fn_pay_card()" checked>반품 
               <td width="180px;"><input type="radio" id="pay_method" name="pay_method" value="교환"  >&nbsp;&nbsp;교환 </td>
               <td> </td>
            </tr>
            
            <tr> <td colspan="2"> 
               <div class="selectopt">
               <select id="selectBox">
                  <option value="option1">불량&오배송</option>
                 <option value="option2">사이즈 교환</option>
                  <option value="option3">단순 변심</option>
                 <option value="option4">기타</option> </select>
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
   
         
         
         
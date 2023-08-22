<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta   charset="utf-8">

<style>

.order_delivery{
   text-align:center;
   border-collapse: collapse;

}
.order_delivery td {
    border-top: 1px solid gray;
    
}




.order_delivery_list { 
	width: 66%;
    margin: auto;
   }

.goods li {
   list-style-type: none;
}


.order_delivery_search {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 5px 5px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
    font-size:1px;
}


/* 버튼에 호버 효과 */
.order_delivery_search :hover{
    background-color: #cca300; /* 호버 시 배경색 변경 */
}






</style>
<title>상품 관리창</title>

</head>
<body>
<br><br>
   <div class="order_delivery_list">
   <H3>상품관리</H3>
   <hr>
   <form  method="post">   
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;"> 사업자님 안녕하세요 </p>
               
            </td>
         </tr>
      </table>
      
      <hr>
      
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td>
               <a href="javascript:search_order_history('today')">
                  <img   src="/image/btn_search_one_day.jpg">
               </a>
               <a href="javascript:search_order_history('one_week')">
                  <img   src="/image/btn_search_1_week.jpg">
               </a>
               <a href="javascript:search_order_history('two_week')">
                  <img   src="/image/btn_search_2_week.jpg">
               </a>
               <a href="javascript:search_order_history('one_month')">
                  <img   src="/image/btn_search_1_month.jpg">
               </a>
               <a href="javascript:search_order_history('two_month')">
                  <img   src="/image/btn_search_2_month.jpg">
               </a>
               <a href="javascript:search_order_history('three_month')">
                  <img   src="/image/btn_search_3_month.jpg">
               </a>
               <a href="javascript:search_order_history('four_month')">
                  <img   src="/image/btn_search_4_month.jpg">
               </a>
      </td>
         <tr>
            <td>    
               조회한 기간 : <input  type="date"  size="4" value="${beginYear}" />
                      ~
                     <input  type="date"  size="4" value="${endYear}" />
            </td>
            
             <td><input   type="button"  value="조회"/> </td>
         </tr>
      </table>
      
      <div class="clear">
   </div>
   </form>   
   
   <br>
   <a class="order_delivery_search" href="${contextPath}/seller/addNewGoodsForm.do?page=sellerPage" style="width: 125px;
   float: right;
   font-size: 18px;
   margin-bottom: 10px;"><b>상품 등록하기</b></a>
<table class="order_delivery"  width="100%">
         <tr >
            <td colspan="2" width="300px" style="padding-left:15px;">상품정보</td>
            <td>배송비</td>
            <td>상품 관리</td>
            <td >&nbsp;&nbsp;&nbsp;</td>
            
         </tr>
        <c:forEach var="i" begin="0" end="3"> 
         <tr>
        
            <td><img src="/image/lego.jpg" width="100px"/></td>
            <td> 
               <ul class="goods">
                  <li style="text-align:left;"> 레고장난감 [주문번호] </li>
                  <li style="text-align:left;"> 가격: 25,000원 </li>
               </ul>
            </td>
            <td> 2,500원 </td>
            
            <td> 
            <a class="order_delivery_search" href="${contextPath}/seller/addNewGoodsForm.do?page=sellerPage"><b>수정하기</b></a><br>
             <a class="order_delivery_search?page=sellerPage" href=""><b>삭제</b></a><br>

            </tr>
           </c:forEach> 
           
      </table>
      </div>      
  
</body>
</html>
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
<title>주문내역/배송조회 창</title>
<script>
function search_order_history(fixedSearchPeriod){
   var formObj=document.createElement("form");
   var i_fixedSearch_period = document.createElement("input");
   i_fixedSearch_period.name="fixedSearchPeriod";
   i_fixedSearch_period.value=fixedSearchPeriod;
    formObj.appendChild(i_fixedSearch_period);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/mypage/listMyOrderHistory.do";
    formObj.submit();
}

function fn_cancel_order(order_id){
   var answer=confirm("주문을 취소하시겠습니까?");
   if(answer==true){
      var formObj=document.createElement("form");
      var i_order_id = document.createElement("input"); 
       
       i_order_id.name="order_id";
       i_order_id.value=order_id;
      
       formObj.appendChild(i_order_id);
       document.body.appendChild(formObj); 
       formObj.method="post";
       formObj.action="${contextPath}/mypage/cancelMyOrder.do";
       formObj.submit();   
   }
}

</script>
</head>
<body>
<br><br>
   <div class="order_delivery_list">
   <H3>주문내역/배송조회</H3>
   <hr>
   <form  method="post">   
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;"> user님 안녕하세요 </p>
               
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

<table class="order_delivery"  width="100%">
         <tr >
            <td colspan="2" width="300px" style="padding-left:15px;">상품정보</td>
            <td>배송비</td>
            <td>진행상태</td>
            <td >&nbsp;&nbsp;&nbsp;</td>
            
         </tr>
        <c:forEach var="i" begin="0" end="3"> 
         <tr>
        
            <td><img src="/image/lego.jpg" width="100px"/></td>
            <td> 
               <ul class="goods">
                  <li style="text-align:left;"> 레고장난감 [주문번호] </li>
                  <li style="text-align:left;"> 가격: 25,000원 </li>
                  <li style="text-align:left;"> 주문일자 </li>
               </ul>
            </td>
            <td> 2,500원 </td>
            <td> 배송중 </td>
            <td> 
            <a class="order_delivery_search" href="${contextPath}/member/reviewForm.do"><b>후기작성</b></a><br>
             <a class="order_delivery_search" href="${contextPath}/member/myOrderDetail.do"><b>주문/배송조회</b></a><br>
            <a class="order_delivery_search" href="#"><b>주문취소</b></a><br>
            <a class="order_delivery_search" href="${contextPath}/member/myrefund.do"><b>반품/교환</b></a>
            
            </tr>
           </c:forEach> 
           
            
         
   <c:choose>
     <c:when test="${empty myOrderHistList }">         
         <tr>
             <td colspan=8 class="fixed">
              <strong> </strong>
            </td>
           </tr>
    </c:when>
    <c:otherwise> 
     <c:forEach var="item" items="${myOrderHistList }" varStatus="i">
        <c:choose>
          <c:when test="${item.order_id != pre_order_id }">   
            <tr>       
            <td>
              <a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><strong>${item.order_id }</strong>  </a>
            </td>
            <td >
             <strong>${item.pay_order_time }</strong> 
            </td>
            <td> 
                <strong>
                  <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
                      <c:if  test="${item.order_id ==item2.order_id}" >
                        <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_title }</a><br>
                     </c:if>   
                </c:forEach>
                </strong>
            </td>
            <td>
               <strong>
                  <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
                      <c:if  test="${item.order_id ==item2.order_id}" >
                         ${item.goods_sales_price*item.order_goods_qty }원/${item.order_goods_qty }<br>
                     </c:if>   
                </c:forEach>
               </strong>
            </td>
            <td>
              <strong>
                <c:choose>
                   <c:when test="${item.delivery_state=='delivery_prepared' }">
                      배송준비중
                   </c:when>
                   <c:when test="${item.delivery_state=='delivering' }">
                      배송중
                   </c:when>
                   <c:when test="${item.delivery_state=='finished_delivering' }">
                      배송완료
                   </c:when>
                   <c:when test="${item.delivery_state=='cancel_order' }">
                      주문취소
                   </c:when>
                   <c:when test="${item.delivery_state=='returning_goods' }">
                      반품
                   </c:when>
              </c:choose>
              </strong>
            </td>
            <td>
             <strong>${item.orderer_name }</strong> 
            </td>
            <td>
               <strong>${item.receiver_name }</strong>
            </td>
            <td>
              <c:choose>
            <c:when test="${item.delivery_state=='delivery_prepared'}">
                <input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소"  />
            </c:when>
            <c:otherwise>
               <input  type="button" onClick="fn_cancel_order('${item.order_id}')" value="주문취소" disabled />
            </c:otherwise>
           </c:choose>
             </td>
         </tr>
         <c:set  var="pre_order_id" value="${item.order_id }" />
         </c:when>   
     </c:choose>      
   </c:forEach>
   </c:otherwise>
  </c:choose>            
      </tbody>
   </table>
        
   
   </div>
   <br><br><br><br>
</body>
</html>
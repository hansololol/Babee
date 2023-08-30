<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
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
   
   <br>
   <script>
    $(document).ready(function() {
         if("${memberInfo.seller_status}" =='승인'){
            $(".order_delivery_search").prop("href","${contextPath}/seller/addNewGoodsForm.do");
         }

    });
    function insertGoods(){
                  alert("사업자 승인 이후 이용 가능합니다. \n사업자 승인은 평균 2~3일 소요됩니다. ")
               }
   </script>
   <a class="order_delivery_search" href="javascript:insertGoods()" style="width: 125px;
   float: right;
   font-size: 18px;
   margin-bottom: 10px;"><b>상품 등록하기</b></a>
      <table class="order_delivery" width="100%">
         <tr>
             <td colspan="2" width="300px" style="padding-left: 15px;">상품정보</td>
             <td>배송비</td>
             <td>상품 관리</td>
             <td>&nbsp;&nbsp;&nbsp;</td>
         </tr>
         <c:forEach items="${sellerGoodsList}" var="goods">
             <tr>
            
                 <td>
                 <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1_id}">
                 <img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="width:100px;"> </a></td>
                 
                 <input type="hidden" name="goods_image_name2" value="${goods.goods_image_name2}">
                 <input type="hidden" name="goods_image_name2_id" value="${goods.goods_image_name2_id}">
                 <td>
                     <ul class="goods">
                         <li style="text-align: left;"> ${goods.goods_title} </li>
                         <li style="text-align: left;"> 가격: ${goods.goods_price}원 </li>
                     </ul>
                 </td>
                 <td> 3,000원 </td>
                 <td>
                 
                     <a class="order_delivery_search" href="${contextPath}/seller/modGoodsForm.do?goods_id=${goods.goods_id}"><b>수정하기</b></a><br>
                     <a class="order_delivery_search" href="${contextPath}/seller/removeGoodsImage.do?goods_id=${goods.goods_id}&goods_image_name1=${goods.goods_image_name1}&goods_image_name1_id=${goods.goods_image_name1_id}"><b>삭제</b></a><br>
                 </td>
             </tr>
         </c:forEach>
      </table>
   </form>
      </div>
      
      
      <!-- 페이징  -->
      <div class="paging-container">
        <c:if test="${totArticles !=null}">
           <c:choose>
              <c:when test="${totArticles > 100 }"> 
                 <c:forEach var="page" begin="1" end="10" step="1">
                    <c:if test="${section >1 && page==1 }" >
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
                    </c:if>
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${(section-1)*10 +page }"> </a>
                    <c:if test="${page ==10 }">
                    <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next </a>
                    </c:if>
                 </c:forEach>
              </c:when>
              
              <c:when test="${totArticles ==100 }">
                 <c:forEach var="page" begin="1" end="10" step="1">
                 <a class="paging-button"  href="#"> ${page }</a>
                 </c:forEach>
              </c:when>
              
              <c:when test="${totArticles <100 }">
                 <c:forEach var="page" begin="1" end="${totArticles/10 +1 }" step="1">
                    <c:choose>
                       <c:when test="${page==pageNum }">
                       <a class="paging-button" href="${contextPath}/mypage/myReviewList.do?section=${section}&pageNum=${page}">${page }</a>
                       </c:when>
                    <c:otherwise>
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section}&pageNum=${page}">${page }</a>
                    </c:otherwise>
                    </c:choose>
                 </c:forEach>
              </c:when>
           </c:choose>
        </c:if>
                 
     </div>
  
</body>
</html>
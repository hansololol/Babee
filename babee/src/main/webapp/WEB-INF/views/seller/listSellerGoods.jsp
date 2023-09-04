<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
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




.order_delivery_search, .modify_delivery_search {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 5px 5px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration: none;
    font-size: 1px;
	
    width: 100%; /* 버튼 너비 100%로 꽉 차게 설정 */
    text-align: center; /* 텍스트 가운데 정렬 */
    transition: background-color 0.3s; /* 호버 효과 애니메이션 */
}

/* 버튼에 어두워지는 호버 효과 */
.order_delivery_search:hover, .modify_delivery_search:hover {
    background-color: #cca300; /* 어두워진 배경색 */

}
/*이미지 어두워지는 호버*/
.image-hover-effect {
    transition: filter 0.3s; /* 호버 효과 애니메이션 */
    border-radius: 10px; /* 둥근 모서리 반경 */
    transition: transform 0.2s;
}

.image-hover-effect:hover {
    filter: brightness(70%); /* 어둡게 만들기 */
    transform: scale(1.1); /* 호버 시 둥근 모서리 크게 적용 */
}

/*페이징*/
.pagination {
    display: flex; /* Flexbox를 사용하여 가운데 정렬 */
    justify-content: center; /* 가로 가운데 정렬 */
    margin-top: 20px;
    position: relative; /* position 속성 추가 */
    z-index: 11; /* 적절한 z-index 값 설정 */
}

.pagination a,
.pagination span {
    display: inline-block;
    padding: 5px 10px;
    margin: 2px;
    border: 1px solid #ccc;
    background-color: #fff;
    color: #333;
    text-decoration: none;
    border-radius: 3px;
}

.pagination a:hover {
    background-color: #f0f0f0;
}

.pagination .current {
    background-color: #ffcd29;
    color: #fff;
    border:none;
}

.pagination .disabled {
    color: #ccc;
}
</style>
<title>상품 관리창</title>

</head>
<body>
<br><br>
   <div class="order_delivery_list">
   <H3>상품관리</H3>
   <hr>
      <form action="${contextPath}/seller/getDateGoods.do?page=sellerPage" method="POST">
      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               
                  <p  style="display:inline-block;"> ${memberInfo.seller_name}님 안녕하세요 </p>
               
            </td>
         </tr>
      </table>
      
      <hr>

      <table align="center" style="margin-left: 0px;">
         <tr>
            <td> 
               <a href="${contextPath}/seller/getTodayGoods.do?page=sellerPage">
				    <img src="${contextPath}/image/btn_search_one_day.jpg">
			   </a>
               <a href="${contextPath}/seller/getOneWeekGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_1_week.jpg">
               </a>
               <a href="${contextPath}/seller/getTwoWeekGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_2_week.jpg">
               </a>
               <a href="${contextPath}/seller/getOneMonthGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_1_month.jpg">
               </a>
               <a href="${contextPath}/seller/getTwoMonthGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_2_month.jpg">
               </a>
               <a href="${contextPath}/seller/getThreeMonthGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_3_month.jpg">
               </a>
               <a href="${contextPath}/seller/getFourMonthGoods.do?page=sellerPage">
                  <img   src="/image/btn_search_4_month.jpg">
               </a>

      </td>
         <tr>
         
            <td>    
			    조회한 기간 :
			    <input type="date" size="4"  name="startDate" />
			    ~
			    <input type="date" size="4" name="endDate" />
			</td>
			<td>
			    <a href="${contextPath}/seller/getDateGoods.do">
			        <input type="submit" value="조회" />
			    </a>
			</td>
		 
         </tr>
      </table>
      
      <div class="clear">
   </div>  
   </form>
   <form  method="post">
   <br>
   <script>
    $(document).ready(function() {
         if("${memberInfo.seller_status}" =='승인'){
            $(".order_delivery_search").prop("href","${contextPath}/seller/addNewGoodsForm.do?page=sellerPage");
         }

    });
    function insertGoods(){
                  alert("사업자 승인 이후 이용 가능합니다. \n사업자 승인은 평균 2~3일 소요됩니다. ")
               }
   </script>
   <a class="order_delivery_search" href="javascript:insertGoods()" style="width: 125px;
   float: right;
   font-size: 13px;
   margin-bottom: 10px;"><b>상품 등록하기</b></a>
      <table class="order_delivery" width="100%">
         <tr>
         	 <td>상품번호</td>
             <td colspan="2" width="300px" style="padding-left: 15px;">상품명</td>
             <td>가격</td>
             <td>상품 관리</td>
             <td>&nbsp;&nbsp;&nbsp;</td>
         </tr>
         
         <c:choose>
		    <c:when test="${empty sellerGoodsList}">
		        <tr>
		            <td colspan="4">조회된 결과가 없습니다.</td>
		        </tr>
		    </c:when>
		    <c:otherwise>
         <c:forEach items="${sellerGoodsList}" var="goods">
             <tr>
            	<td style="text-align:center;">${goods.goods_id}</td>
                 <td>
                 <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1_id}">
                 <img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="width:100px; height:100px; margin-top: 5px; margin-bottom: 5px;" class="image-hover-effect"></a></td>
                 
                 <input type="hidden" name="goods_image_name2" value="${goods.goods_image_name2}">
                 <input type="hidden" name="goods_image_name2_id" value="${goods.goods_image_name2_id}">
                 <td style="text-align:left;">${goods.goods_title}</td>
                 <td>${goods.goods_price}원</td>
                 <td>
                 
                     <a class="modify_delivery_search" href="${contextPath}/seller/modGoodsForm.do?page=sellerPage&goods_id=${goods.goods_id}"><b>수정하기</b></a><br>
                     <a class="modify_delivery_search" href="${contextPath}/seller/removeGoodsImage.do?page=sellerPage&goods_id=${goods.goods_id}&goods_image_name1=${goods.goods_image_name1}&goods_image_name1_id=${goods.goods_image_name1_id}"><b>삭제</b></a><br>
                 </td>
             </tr>
         </c:forEach>
         </c:otherwise>
</c:choose>
      </table>
   </form>
   
      </div>
      
      
    <!-- 페이징 -->
     <div class="pagination">
    <c:if test="${totalPages >= 1}">
        <c:set var="startPage" value="${currentPage - 5}" />
        <c:if test="${startPage < 1}">
            <c:set var="startPage" value="1" />
        </c:if>
        <c:set var="endPage" value="${currentPage + 5}" />
        <c:if test="${endPage > totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="?page=sellerPage&pageNum=1">First</a>
                <a href="?page=sellerPage&pageNum=${currentPage - 1}">&lt;&lt;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">First</span>
                <span class="disabled">&lt;&lt;</span>
            </c:otherwise>
        </c:choose>
        <c:forEach var="page" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="current">${page}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=sellerPage&pageNum=${page}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="?page=sellerPage&pageNum=${currentPage + 1}">&gt;&gt;</a>
                <a href="?page=sellerPage&pageNum=${totalPages}">Last</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&gt;&gt;</span>
                <span class="disabled">Last</span>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>

</body>
</html>
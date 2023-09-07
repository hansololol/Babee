<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    border-top: 1px solid #ccc;
    
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
.search-container {
        display: flex;
        align-items: center;
        width: 70%;
    }
    .search-input {
        width: 300px;
        border: 1px solid #FFA500;
        text-align: center;
        padding: 5px;
        flex: 3;
        border-radius: 5px;
        margin-left: 20px;
    }
    .search-button {
        border: none;
        background: none;
    }


        a {
            color: black;
            text-decoration: none;
        }
        
        .paging-container {
            text-align: center;
            margin-top: 20px;
        }
        .paging-button {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f0f0f0;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }
        .paging-button:hover {
            background-color: #ccc;
        }

        .menu-container >hr, #foreachhr {
          margin:  1rem 25%;
         color: inherit;
        border: 0;
           border-top: var(--bs-border-width) solid;
         opacity: .25;
}

.admin_goods_list {
	width: 66%;
	margin: 0 auto;
}

</style>
<title>상품 관리창</title>

</head>
<body>

  <div class="admin_goods_list" style="margin-left: 165px;">
		<H3 style="display: inline-grid;">상품 관리</H3>
		<div style="background:rgb(255, 255, 202);">
		
		<hr style="margin-top: revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td><img src="/image/people.png" width="60px;"
					style="display: inline-block; padding-left: 15px;" />
					<p style="display: inline-block;">${memberInfo.member_name}님
						안녕하세요</p></td>
			</tr>
		</table>
		<hr style="margin-bottom: 50px;">
		</div>

<div style="width: 100%;">
			<table class="seller-table" style="width: 100%;">
		         <tr>
            <td colspan="2" width="300px" style="padding-left:15px; font-weight:bold;">상품정보</td>
            <td style="font-weight:bold">배송비</td>
            <td style="font-weight:bold" >상품 관리</td>
            <td >&nbsp;&nbsp;&nbsp;</td>
            
         </tr>
        <c:forEach items="${allGoodsList}" var="all"> 
         <tr  style="border-top: 1px solid #ccc;">
        
            <td>
				<a href="${contextPath}/goods/goodsDetail.do?goods_id=${all.goods_id}">
	            <img src="${contextPath}/thumbnails.do?goods_id=${all.goods_id}&fileName=${all.goods_image_name1}" style="width:100px;"> </a>
            <td> 
               <ul class="goods">
                  <li style="text-align:left;"> ${all.goods_title} [${all.goods_id}] </li>
                  <li style="text-align:left;"> 가격: <fmt:formatNumber value="${all.goods_price}" pattern="#,###,###" />원 </li>
                  
              
               </ul>
            </td>
            <td> 3,000원 </td>
            
            <td> 
            

             <a class="order_delivery_search" href="${contextPath}/admin/goods/removeGoodsImage.do?goods_id=${all.goods_id}&goods_image_name1=${all.goods_image_name1}&goods_image_name1_id=${all.goods_image_name1_id}"><b>삭제</b></a><br>

            </tr>
           </c:forEach> 
           
      </table>
       </div>
      	 <div class="paging-container">
   <c:if test="${totArticles !=null}">
      <c:choose>
         <c:when test="${totArticles > 100 }"> 
            <c:forEach var="page" begin="1" end="10" step="1">
               <c:if test="${section >1 && page==1 }" >
                  <a class="paging-button"  href="${contextPath}/admin/goods/listSellerGoodsAdmin.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
               </c:if>
                  <a class="paging-button"  href="${contextPath}/admin/goods/listSellerGoodsAdmin.do?section=${section-1}&pageNum=${(section-1)*10 +page }"> </a>
               <c:if test="${page ==10 }">
               <a class="paging-button"  href="${contextPath}/admin/goods/listSellerGoodsAdmin.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next </a>
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
                  <a class="paging-button" href="${contextPath}/admin/goods/listSellerGoodsAdmin.do?section=${section}&pageNum=${page}">${page }</a>
                  </c:when>
               <c:otherwise>
                  <a class="paging-button"  href="${contextPath}/admin/goods/listSellerGoodsAdmin.do?section=${section}&pageNum=${page}">${page }</a>
               </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:when>
      </c:choose>
   </c:if>
           
</div>
      </div>      
  
</body>
</html>
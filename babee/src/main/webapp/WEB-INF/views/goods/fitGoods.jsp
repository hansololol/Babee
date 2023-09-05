<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<!DOCTYPE html>
<html>
<head>

 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<meta charset="UTF-8">
<title>맞춤상품 목롱창</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  
<style>
 
button[type="button"] {
    background-color: #ffff80;
    color: black;
    padding: 10px 20px;
    border: none;
    border-radius: 35%;
    cursor: pointer;
}

.form-select{
    width: 15%;
    margin-left: 65%;
}
.fitGoods_list {
    display: inline-block;
    margin: -15px;
    padding: 10px;
    width:300px;
    height:450px;
    
}

.fitGoods_list ul {
    list-style: none;
    padding: 0;
}

.fitGoods_list li {
    margin-bottom: 5px;
}

.fitGoods_list li.checkbox{
    text-align: left;
}


.fitGoods_list li img{
    width: 250px;
    height: 300px;
}

.ellipsis2 {
  width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  margin: 10px auto;
}

/*페이징*/
.pagination {
    display: flex; /* Flexbox를 사용하여 가운데 정렬 */
    justify-content: center; /* 가로 가운데 정렬 */
    margin-top: 20px;
    position: relative; /* position 속성 추가 */
    z-index: 11; /* 적절한 z-index 값 설정 */
    margin-bottom: 20px;
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
</head>
<body>
     
    <div style="margin: 60px;">
        <p size="20px"> 💖 ${memberInfo.baby_age} 친구들이 가장 많이 구매했어요 💖</p>
        <c:forEach var="fit" items="${fit}">
           
        <button type="button" class="btn btn-outline-warning" onclick="location.href='${contextPath}/goods/fitGoods.do?sub_category=${fit.sub_category}'"># ${fit.sub_category}</button>
      </c:forEach>      

    </div>


      
   <div style= "padding: 0 15%;" >
      <c:forEach var="goods" items="${goods}">
      <div class="fitGoods_list">
         <ul>
            <li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"><img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="border-radius: 9%"> </a></li>
            <div class="ellipsis2">
             <li style="font-weight: bold; height:48px;"> ${goods.goods_title} </li>
            </div>
            <li> <fmt:formatNumber value="${goods.goods_price}"  pattern="##,###,### 원"/></li>
           
         </ul>

      </div>
   </c:forEach>        
   </div>
 
 
 <!-- 페이징 -->
<div class="pagination">
    <c:if test="${totalPages >= 1}">
        <c:set var="itemsPerPage" value="10" /> <!-- 한 페이지당 항목 수 설정 -->
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
                <a href="?pageNum=1&itemsPerPage=${itemsPerPage}&sort=${sort}">First</a>
                <a href="?pageNum=${currentPage - 1}&itemsPerPage=${itemsPerPage}&sort=${sort}">&lt;&lt;</a>
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
                    <a href="?pageNum=${page}&itemsPerPage=${itemsPerPage}&sort=${sort}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="?pageNum=${currentPage + 1}&itemsPerPage=${itemsPerPage}&sort=${sort}">&gt;&gt;</a>
                <a href="?pageNum=${totalPages}&itemsPerPage=${itemsPerPage}&sort=${sort}">Last</a>
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
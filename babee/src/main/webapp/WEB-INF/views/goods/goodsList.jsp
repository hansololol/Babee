<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    String mainCategory = request.getParameter("main_category");
    String middleCategory = request.getParameter("middle_category");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다어이리 목롱창</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script type="text/javascript">
  
    function order(obj){
        $("#check").attr('hidden', 'visibility')
            if($("#check").change){
                obj.submit();
            }

    }

</script>

<style>
 #search {
        background-color: #FEF7DD;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        width: 70%;
        margin: 50px auto -10px;
    }
.diary_list {
    display: inline-block;
    margin: -15px;
    padding: 10px;
    width:300px;
    
}

.diary_list ul {
    list-style: none;
    padding: 0;
}

.diary_list li {
    margin-bottom: 5px;
}

.diary_list li.checkbox{
    text-align: left;
}


.diary_list li img{
    width: 250px;
    height: 300px;
}
 
 
.btn-outline-warning { /* 수정된 부분 */
    background-color: #ffff80;
    color: black;
    padding: 10px 20px;
    border: none;
    border-radius: 35%;
    cursor: pointer;
}

.form-select{
    width: 15%;
    margin-left: 80%;
}
.breadcrumb-item >a { 
 text-decoration: none;
 color: black;
}
 
</style>

</head>
<body>
    <c:if test="${newGoodsList !=null}">
    <div style= "padding:19px 21%;" >
        <nav style="--bs-breadcrumb-divider: '>'; font-size: 20px;" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <c:if test="${category.main_category !=null}">
                <li class="breadcrumb-item" id="mainCategory">${category.main_category}</li>
                </c:if>
                <c:if test="${category.middle_category !=null}">
                <li class="breadcrumb-item" id="middleCategory"> ${category.middle_category}</li>
                </c:if>
                <c:if test="${category.sub_category !=null}">
                <li class="breadcrumb-item active" id="subCategory" aria-current="page"> ${category.sub_category}</li>
                </c:if>
            </ol>
        </nav>
	    <div style="margin: 60px;">
	        <c:forEach var="subcategory" items="${sub_category}">
	            <button type="button" class="btn btn-outline-warning" onclick="location.href='${contextPath}/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${subcategory.sub_category}'">${subcategory.sub_category}</button>
	        </c:forEach>
	    </div>
     <select class="form-select form-select-lg mb-3" aria-label="Large select example" name="sortSearch"  onchange="if(this.value) location.href=(this.value);">
        <option selected>정렬 기준</option>
        <option value="/goods/goodsList.do?sort=popular">인기순</option>
        <option value="/goods/goodsList.do?sort=new">최신순</option>
        <option value="/goods/goodsList.do?sort=low">낮은가격순</option>
        <option value="/goods/goodsList.do?sort=high">높은가격순</option>
      </select>
          <div>
          <c:forEach var="goods" items="${newGoodsList}">
      <div class="diary_list">
         <ul>                                                                                                            
            <li style="text-align: left;"> <input type="checkbox" id="check" hidden> </li>
            <li> <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"><img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="border-radius: 9%"> </a></li>
            <li>${goods.goods_title}</li>
            <li>${goods.goods_price}원</li>
         </ul>
      </div>
        </c:forEach>
        </div>
        </div>
        </c:if>
        <c:if test="${newGoodsList==null}">
            <div style="height: 800px;">
                <br>
                <img src="/image/glass.png" style="width: 60px;"> <br> <br>
            <p>검색된 상품이 없습니다.</p>
         </div>
         </c:if>
</body>
</html>
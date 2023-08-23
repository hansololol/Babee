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
    
   
   
    $(document).ready(function() {
        // 대분류 링크 클릭 이벤트 처리
        $(".category-list > li > a").click(function() {
            // 대분류 값을 가져와서 업데이트
            var mainCategory = $(this).text().trim();
            $("#mainCategory").text(mainCategory);
        });

        // 중분류 링크 클릭 이벤트 처리
        $(".middlecategory-list li a").click(function() {
            // 대분류, 중분류 값을 가져와서 업데이트
            var mainCategory = $("#mainCategory").text();
            var middleCategory = $(this).text();
            var subCategory = $(this).data("sub-category");

            $("#mainCategory").text(mainCategory);
            $("#middleCategory").text(middleCategory);
            $("#subCategory").text(subCategory);
        });
    });
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

    <div style= "padding:19px 21%;" >
    <nav style="--bs-breadcrumb-divider: '>'; font-size: 20px;" aria-label="breadcrumb">
	    <ol class="breadcrumb">
	        <li class="breadcrumb-item" id="mainCategory">대분류</li>
	        <li class="breadcrumb-item" id="middleCategory">중분류</li>
	        <li class="breadcrumb-item active" id="subCategory" aria-current="page">소분류</li>
	    </ol>
	</nav>
    <c:out value="${param.main_category}"/> - <c:out value="${param.middle_category}"/>
		<c:if test="${param.main_category == '출산준비' && param.middle_category == '임산부복대'}">
		    <p>조건 만족</p>
		</c:if>
    
	<c:if test="${param.main_category eq '출산준비' && param.middle_category eq '임산부복대'}">
	    <div style="margin: 60px;">
	        <c:forEach var="subCategory" items="${allCategories}">
	            <button type="button" class="btn btn-outline-warning">${subCategory.sub_Category}</button>
	        </c:forEach>
	    </div>
	</c:if>

    <select class="form-select form-select-lg mb-3" aria-label="Large select example">
        <option selected>정렬 기준</option>
        <option value="1">One</option>
        <option value="2">Two</option>
        <option value="3">Three</option>
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
</body>
</html>
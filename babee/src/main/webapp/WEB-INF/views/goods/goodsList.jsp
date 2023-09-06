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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<script type="text/javascript">
  
    function order(obj){
        $("#check").attr('hidden', 'visibility')
            if($("#check").change){
                obj.submit();
            }

    }
    document.addEventListener("DOMContentLoaded", function() {
        var currentURL = window.location.href;
        var selectElement = document.getElementsByName("sortSearch")[0];
        var urlParams = new URLSearchParams(window.location.search);
        var sortParam = urlParams.get("sort");

        for (var i = 0; i < selectElement.options.length; i++) {
            if (currentURL.includes(selectElement.options[i].getAttribute("value"))) {
                selectElement.options[i].selected = true;
                break;
            }
        }

        if (sortParam) {
            selectElement.value = "/goods/goodsList.do?sort=" + sortParam;
        }

        // 2번째 옵션에 대한 처리
        var selectElement2 = document.getElementById("sortSelect2"); // ID로 선택
        var sortParam2 = urlParams.get("sort");

        for (var j = 0; j < selectElement2.options.length; j++) {
            if (currentURL.includes(selectElement2.options[j].getAttribute("value"))) {
                selectElement2.options[j].selected = true;
                break;
            }
        }

        if (sortParam2) {
            selectElement2.value = "/goods/goodsCategoryList.do?main_category=" + urlParams.get("main_category") + "&middle_category=" + urlParams.get("middle_category") + "&sub_category=" + urlParams.get("sub_category") + "&sort=" + sortParam2;
        }
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
.goods_list {
    display: inline-block;
    margin: -15px;
    padding: 10px;
    width:300px;
    height:450px;
    
}

.goods_list ul {
    list-style: none;
    padding: 0;
}

.goods_list li {
    margin-bottom: 5px;
}

.goods_list li.checkbox{
    text-align: left;
}


.goods_list li img{
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
 select[name="sortSearch"] {
        font-size: 15px; /* 원하는 글자 크기로 조정하세요 */
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

.goods_list li img {
    width: 250px;
    height: 300px;
    transition: all 0.3s; /* 호버 효과에 애니메이션을 적용 */
}

.goods_list li img:hover {
    opacity: 0.7; /* 이미지를 어둡게 만듭니다. */
    transform: scale(1.1); /* 이미지 크기를 확대합니다. */
}
</style>

</head>
<body>
    <c:if test="${newGoodsList !=null}">
    <div style= "padding:19px 21%;" >
        <nav style="--bs-breadcrumb-divider: '>'; font-size: 20px;" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <c:if test="${category.main_category !=null and category.main_category !=''}">
                <li class="breadcrumb-item" id="mainCategory">${category.main_category}</li>
                </c:if>
                <c:if test="${category.middle_category !=null and category.middle_category !=''}">
                <li class="breadcrumb-item" id="middleCategory"> ${category.middle_category}</li>
                </c:if>
                <c:if test="${category.sub_category !=null  and category.sub_category !=''}">
                <li class="breadcrumb-item active" id="subCategory" aria-current="page"> ${category.sub_category}</li>
                </c:if>
            </ol>
        </nav>
	    <div style="margin: 60px;">
	        <c:forEach var="subcategory" items="${sub_category}">
	            <button type="button" class="btn btn-outline-warning" onclick="location.href='${contextPath}/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${subcategory.middle_category}&sub_category=${subcategory.sub_category}'">${subcategory.sub_category}</button>
	        </c:forEach>
	    </div>
        <c:if test="${sub_category==null}">
     <select id="sortSelect1" class="form-select form-select-lg mb-3" aria-label="Large select example" name="sortSearch"  onchange="if(this.value) location.href=(this.value);">
        <option value="/goods/goodsList.do?" selected>정렬 기준</option>
        <option value="/goods/goodsList.do?sort=popular">인기순</option>
        <option value="/goods/goodsList.do?sort=new">최신순</option>
        <option value="/goods/goodsList.do?sort=low">낮은가격순</option>
        <option value="/goods/goodsList.do?sort=high">높은가격순</option>
      </select>
    </c:if>
    <c:if test="${sub_category!=null}">
        <select id="sortSelect2" class="form-select form-select-lg mb-3" aria-label="Large select example" name="sortSearch"  onchange="if(this.value) location.href=(this.value);">
            <option value="/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${category.sub_category}">정렬 기준</option>
            <option value="/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${category.sub_category}&sort=popular">인기순</option>
            <option value="/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${category.sub_category}&sort=new">최신순</option>
            <option value="/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${category.sub_category}&sort=low">낮은가격순</option>
            <option value="/goods/goodsCategoryList.do?main_category=${category.main_category}&middle_category=${category.middle_category}&sub_category=${category.sub_category}&sort=high">높은가격순</option>
          </select>
    </c:if>
          <div>
          <c:forEach var="goods" items="${newGoodsList}">
      
      
      <div class="goods_list" >
         <ul>                                                                                                            
            <li style="text-align: left;"> <input type="checkbox" id="check" hidden> </li>
            <li> <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"><img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="border-radius: 9%"> </a></li>
            <div class="ellipsis2">
            <li style="font-weight: bold; height:48px;">${goods.goods_title}</li>
            </div>
            <li><fmt:formatNumber value="${goods.goods_price}"  pattern="##,###,### 원"/></li>
            
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
            	<a href="/main/main.do" class="btn btn-warning">메인 페이지로 이동</a>
         	</div>
         </c:if>
         
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
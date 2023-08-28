<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다어이리 목롱창</title>
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
 
 
</style>
</head>
<body>
     
    <div style="margin: 60px;">
        <p size="20px"> 💖 ${memberInfo.baby_age} 개월 친구들이 가장 많이 구매했어요 💖</p>
        <c:forEach var="fit" items="${fit}">
           
        <button type="button" class="btn btn-outline-warning" onclick="location.href='${contextPath}/goods/fitGoods.do?sub_category=${fit.sub_category}'"># ${fit.sub_category}</button>
      </c:forEach>      

    </div>


      
   <div style= "padding: 0 15%;" >
      <c:forEach var="goods" items="${goods}">
      <div class="diary_list">
         <ul>
            <li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"><img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="border-radius: 9%"> </a></li>
            <li> ${goods.goods_title} </li>
            <li> ${goods.goods_price}</li>
           
         </ul>

      </div>
   </c:forEach>        
   </div>


</body>
</html>
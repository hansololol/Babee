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
<script type="text/javascript">
  
    function order(obj){
        $("#check").attr('hidden', 'visibility')
            if($("#check").change){
                obj.submit();
            }

    }
   
</script>

<style>

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
 
</style>
</head>
<body>

    <div style="margin: 60px;">
        <c:forEach var="i" begin="0" end="5">
        <button type="button" class="btn btn-outline-warning">#아동복</button>
      </c:forEach>      

    </div>

  
    <select class="form-select form-select-lg mb-3" aria-label="Large select example">
        <option selected>정렬 기준</option>
        <option value="1">One</option>
        <option value="2">Two</option>
        <option value="3">Three</option>
      </select>
      
   <div style= "padding: 0 15%;" >
      <c:forEach var="i" begin="0" end="20">
      <div class="diary_list">
         <ul>
            <li style="text-align: left;"> <input type="checkbox" id="check" hidden> </li>
            <li> <a href="${contextPath}/goods/goodsDetail.do?goods_id=1&fileName=1"><img src="/image/shopping1.jpg" style="border-radius: 9%"> </a></li>
            <li> 상품 명 출력 </li>
            <li>상품 가격</li>
           
         </ul>

      </div>
   </c:forEach>        
   </div>


</body>
</html>
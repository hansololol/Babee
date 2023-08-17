<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<style>
.text_center{ 
   text-align:center;
   }

.order_ilst {
    border-collapse: collapse;
  }
.order_ilst th, td {
    border-bottom: 1px solid gray;
    padding: 10px;
  }



/* '주문 내역 보기' 버튼 스타일 */
.myorder > a {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
    text-decoration:none;
}


/* 버튼에 호버 효과 */
.myorder > a:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}


</style>
<title>상품 구매 완료창</title>
</head>
<body>
   <br><br>
<div >
   <div class="text_center">
      <img src="/image/check.png" style="display:inline-block; margin-block-end: -6px;"/>
      <h3 style="display:inline-block;">상품 구매가 완료 되었습니다.</h3>
      <h5>입금계좌 정보</h5>
      <h6>3일 이내에 입금이 완료되지 않을 시 주문이 취소됩니다.</h6>
   </div>



      <table  class="order_ilst" align="center" width="50%" >
         <tr height="10" >
               <td colspan="3" style="border: none; border-bottom: 1px solid gray;"><h4 style="margin-bottom:0px;">주문내역</h4></td>
         </tr>
           <tr height="10" align="center" >
              <td width="25%" >주문날짜</td>
              <td colspan="3" >주문상품</td>
           </tr>
           
      <c:choose>
        <c:when test="${articlesList ==null }" >
             <tr width="80px;" height="10">
                  <td > 2023-08-11 </td>
                  <td style="width:100px;"> <img src="/image/lego.jpg" width="100px"> </td>
                  <td >
                     <ul>
                        <li> 상품명 레고장난감 </li>
                        <li> 가격 35,000 원 </li>
                        <li> 상품옵션 기본 </li>                       
                     </ul> 
                  </td>  
             </tr>
             <tr width="80px;" height="10">
                  <td > 2023-08-11 </td>
                  <td style="width:100px;"> <img src="/image/lego.jpg" width="100px"> </td>
                  <td >
                     <ul>
                        <li> 상품명 레고장난감 </li>
                        <li> 가격 35,000 원 </li>
                        <li> 상품옵션 기본 </li>                       
                     </ul> 
                  </td>  
             </tr>
             
             
       </c:when>
        <c:when test="${articlesList !=null }" >
          <c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >
           <tr align="center">
               <td >${articleNum.count}</td>
               <td width="150px;">${article.id }</td>
               <td align='left'  width="300px;">
              <span style="padding-right:30px"></span>
            <c:choose>
         <c:when test='${article.level > 1 }'>  
            <c:forEach begin="1" end="${article.level }" step="1">
                 <span style="padding-left:20px"></span>    
            </c:forEach>
             </c:when>
             <c:otherwise>
               <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
             </c:otherwise>
           </c:choose>
           </td>
    
            </tr>
          </c:forEach>
        </c:when>
       </c:choose>
      </table>
      <br><br>
   
   <div style="text-align: center;" class="myorder">
    <a href="${contextPath}/goods/listMyOrderHistory.do"><b>주문 내역 보기</b></a>
   </div>

   
</div>


<br><br><br><br>


</body>
</html>
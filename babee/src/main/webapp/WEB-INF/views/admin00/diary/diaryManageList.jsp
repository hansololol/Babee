<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
  
    <meta charset="UTF-8">
<title>다이어리 관리창(관리자)</title>
<style>
   
    #search {
        background-color: #FEF7DD;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
        width: 66%;
    }
    .search-container {
        display: flex;
        align-items: center;
        width: 70%;/* 검색 입력 영역이 늘어나도록 설정 */
    }
    .search-input {
        border: 1px solid #FFA500;
        text-align: center;
        padding: 5px;
        flex: 3; /* Make the text box wider */
        border-radius: 5px;
        margin-left: 20px;
        width: 400px;
         height: 30px;
    }
    .search-button {
        border: none;
        background: none;
        margin-top: -10px;
    }
    .menu-container {
            text-align: center; /* 가운데 정렬 */
            margin-top: 50px; /* 여기서 100px 만큼 아래로 이동합니다. */
        }

        .menu-options {
            display: flex; /* 옆으로 정렬 */
            gap: 100px; /* 사이 간격 */
            align-items: flex-end; /* 메뉴와 아래 정렬 요소 정렬 */
            justify-content: center; /* 가운데 정렬 */
        }

        .menu-option > a {
            font-weight: normal;
            text-decoration: none;
            color: #333;
        }

        /* 선택 시 스타일 */
        .menu-option:hover {
            font-weight: bold;
            text-decoration: underline;
        }
        .paging-container > a:hover {
            font-weight: bold;
        }
        
       .paging-container > a {
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


</style>

</head>
<body>
    <br>
<div id="search">
    <h2 style=>다이어리 관리</h2>
    <div class="search-container">
    <form action="검색결과를_처리할_페이지_주소" method="GET"><!-- form 엘리먼트 추가 -->
        <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
        <button type="submit" name="search" class="search-button">
            <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px;">
        </button>
    </form>
</div>
</div>
<br>

    
    <div style="text-align:center;"> 
    <table style="text-align:center; margin:0 auto; width:850px;">
    	<tr style="border-bottom:1px solid gray; ">
			<td width="30px;"><b>NO</b></td>
			<td width="180px;"><b>다이어리 제목</b></td>
			<td width="90px;"><b>작성자</b></td>
			<td width="110px;"><b>작성일</b></td>
		</tr>
		
			
   <c:forEach var="diaryList" items="${diaryManageList}" varStatus ="free">
		<tr style="height: 50px; border-bottom:1px solid gray;">
			<td><img src="${contextPath}/image/set.png" width="20px"/></td>
			<td> <a href="${contextPath}/diary/diaryDetail.do?dir_no=${diaryList.dir_no}" style="text-decoration-line : none; color:black; "> <strong>${diaryList.dir_title}</strong></td>
			<td> ${diaryList.member_id} </a></td>
			<td> ${diaryList.dir_writeDate} </td>
		</tr>
    </c:forEach>
   
    
    </table>
    </div>
    
    
 
    <!-- 페이징 버튼 -->
      <div class="paging-container">
   <c:if test="${totArticles !=null}">
      <c:choose>
         <c:when test="${totArticles > 100 }"> 
            <c:forEach var="page" begin="1" end="10" step="1">
               <c:if test="${section >1 && page==1 }" >
                  <a class="paging-button"  href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${(section-1)*10 +1  }&page=adminPage">&nbsp; pre </a>
               </c:if>
                  <a class="paging-button"  href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage"> </a>
               <c:if test="${page ==10 }">
               <a class="paging-button"  href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp; next </a>
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
                  <a class="paging-button" href="${contextPath}/admin/order/diaryManageList.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
                  </c:when>
               <c:otherwise>
                  <a class="paging-button"  href="${contextPath}/admin/order/diaryManageList.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
               </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:when>
      </c:choose>
   </c:if>
            
</div>
    <br><br><br><br><br>
</body>
</html>
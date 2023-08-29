<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>자유게시판 목록(관리자)</title>
<style>
    body {
        margin: 0;
        padding: 0;
    }
    #search {
        background-color: #FEF7DD;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        width: 70%;
        margin: 50px auto -10px;
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

        .menu-option {
            font-weight: normal;
            text-decoration: none;
            color: #333;
        }

        /* 선택 시 스타일 */
        .menu-option:hover {
            font-weight: bold;
            text-decoration: underline;
        }
        a:hover {
            font-weight: bold;
            text-decoration: underline;
        }
        
        a {
            color: black;
            text-decoration: none;
        }
        
        .paging-container {
            text-align: center;
            margin-top: 40px;
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
        
       
        .menu-container {
        text-align: center;
        margin-top: 50px;
    }

    .menu-options {
        display: flex;
        gap: 100px;
        align-items: flex-end;
        justify-content: center;
    }

    .menu-option {
        font-weight: normal;
        text-decoration: none;
        color: #333;
    }

    .menu-option:hover {
        font-weight: bold;
        text-decoration: underline;
    }

    a:hover {
        font-weight: bold;
    }
    
    a {
        color: black;
        text-decoration: none;
    }
    
    .faq-content {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .faq-answer {
        margin-top: 10px;
        display: none;
    }
    .answer-textarea {
        width: 100%;
        height: 100px;
        resize: none;
        margin-top: 10px;
        border: 1px solid #ccc;
        padding: 5px;
    }
    .answer-button {
        
        padding: 5px 10px;
        border: none;
        border-radius: 5px;
        background-color: #f0f0f0;
        color: #333;
        cursor: pointer;
        
    }
    .answer-button:hover {
        background-color: #ccc;
    }
    .faq-table {
        width: 80%;
        margin: 60px auto;
        border-collapse: collapse;
    }
    .faq-table th, .faq-table td {
        padding: 10px;
        text-align: center;
        border: none; /* 기존 테두리 제거 */
        border-bottom: 1px solid #ccc; /* 아래쪽 경계선 추가 */
    }
    
    .menu-option-selected {
        font-weight: bold;
        text-decoration: underline;
    }
    
    .faq-content p {
        margin: 5px 0; /* 위아래 여백을 조절할 값 설정 */
    }
</style>
</head>
<body>
<div id="search">
    <h2 style="margin: 0;">자유게시판 관리</h2>
    <div class="search-container">
        <form action="검색결과를_처리할_페이지_주소" method="GET">
            <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="search-button">
                <img src="/images/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:0px"">
            </button>
        </form>
    </div>
</div>

  
    <!-- <hr width="80%" style= "margin-left: 190px; margin-top: 60px;"> -->

<div class="table-container">
    <table class="faq-table" style="width:900px;" >
        <thead style="border-top: 2px solid gray; ">
		    <tr>
		        <th style="width: 10%;">NO</th>
		        <th style="width: 30%;">제목</th>
		        <th style="width: 10%;">작성자</th>
		        <th style="width: 15%;">작성일</th>
		        <th style="width: 8%;">조회수</th>
		        <th style="width: 5%;">삭제</th>
		    </tr>
		</thead>
        <tbody>
		    <c:forEach var="free" items="${freeboard}">
		        <tr class="faq-content">
		            <td>
		            	<img src="${contextPath}/image/set.png" width="20px"/>
		            </td>
		            <td><a href="/community/freeboardDetail.do?articleNO=${free.articleNO} " style="display: flex; align-items: center;"><span style="color: black;">${free.free_title}</span></a></td>
		            <td><p style=" align-items: center;"><span style="color: black;">${free.member_id}</span></p></td>
		            <td><p style="align-items: center;"><span style="color: black;">${free.free_writeDate}</span></p></td>
		            <td><p style="align-items: center;"><span style="color: black;">${free.free_view_count}</span></p></td>
		            <td><a href="/member/delete/${free.articleNO}?page=adminPage" style="color: red;" onclick="return confirm('삭제하시겠습니까?');"><span style="font-size: 20px;">&#128683;</span></a></td>
		        </tr>
		    </c:forEach>
		</tbody>
        
    </table>
</div>

<div class="paging-container">
   <c:if test="${totArticles !=null}">
      <c:choose>
         <c:when test="${totArticles > 100 }"> 
            <c:forEach var="page" begin="1" end="10" step="1">
               <c:if test="${section >1 && page==1 }" >
                  <a class="paging-button"  href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${(section-1)*10 +1 }&page=adminPage">&nbsp; pre </a>
               </c:if>
                  <a class="paging-button"  href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage"> </a>
               <c:if test="${page ==10 }">
               <a class="paging-button"  href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp; next </a>
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
                  <a class="paging-button" href="${contextPath}/community/adminfreelist.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
                  </c:when>
               <c:otherwise>
                  <a class="paging-button"  href="${contextPath}/community/adminfreelist.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
               </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:when>
      </c:choose>
   </c:if>
            
</div>



</body>
</html>
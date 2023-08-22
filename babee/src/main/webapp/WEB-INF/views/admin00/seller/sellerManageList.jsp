<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>사업자 관리창(관리자)</title>
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
    <br><br><br>
<div id="search">
    <h2 style=>사업자 관리</h2>
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
<div class="menu-container">
        <div class="menu-options">
            <div class="menu-option" id="total">
                <a href="${contextPath}/member/sellerManageList.do?page=adminPage" style="color: black; background-color:orange; border-radius: 5px; padding: 10px;">사업자 목록</a>
            </div>
            <div class="menu-option" id="wait">
                <a href="${contextPath}/member/sellerManageWait.do?page=adminPage" style="color: black; margin-right: 380px;">사업자 등록 요청</a>
            </div>

        </div>
        <hr width="50%" >
    </div>
    
    <br>
    
    <div style="text-align:center;"> 
    <table style="text-align:center; margin:0 auto; ">
    	<tr style="border-bottom:1px solid gray; ">
			<td width="80px;"><b>NO</b></td>
			<td width="200px;"><b>사업자 번호</b></td>
			<td width="200px;"><b>사업체 명</b></td>
			<td width="150px;"><b>사업체 승인날짜</b></td>
		</tr>
		
			
    <c:forEach var="i" begin="0" end="5">
		<tr style="height: 50px; border-bottom:1px solid gray;">
			<td> { 1 }</td>
			<td>  <a href="${contextPath}/member/sellerDetail.do?page=adminPage"> { 123-00-1234567 } </a></td>
			<td>  <a href="${contextPath}/member/sellerDetail.do?page=adminPage">{ 별나라 베이비샵 } </a></td>
			<td> { 2023-08-12 } </td>
		</tr>
    </c:forEach>
   
    
    </table>
    </div>
    
    
    
 
   

    
    <!-- 페이징 버튼 -->
    <div class="paging-container">
        <a class="paging-button" href="#">이전</a>
        <a class="paging-button" href="#">1</a>
        <a class="paging-button" href="#">2</a>
        <a class="paging-button" href="#">3</a>
        <a class="paging-button" href="#">4</a>
        <a class="paging-button" href="#">5</a>
        <a class="paging-button" href="#">다음</a>
    </div>
    <br><br><br><br><br>
</body>
</html>
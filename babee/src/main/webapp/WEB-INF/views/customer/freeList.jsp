<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>자유게시판 목록</title>
<style>
   
    #search {
        background-color: #FEF7DD;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
        width: 50%;
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
        }
        
        a {
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

/* '다이어리 작성' 버튼 스타일 */
input[type="button"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}


/* 버튼에 호버 효과 */
input[type="button"]:hover, button[type="button"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}
</style>
</head>
<body>
    <br><br><br>
    
<div id="search">
    <h2 style=>자유게시판</h2>
    <div class="search-container">
    <form action="검색결과를_처리할_페이지_주소" method="GET"><!-- form 엘리먼트 추가 -->
        <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
        <button type="submit" name="search" class="search-button">
            <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px;">
        </button>
    </form>
</div>
</div>
	<div id="freeboardList" style="padding-top: 30px;">
		<table style="margin: auto;">
			<tr>
				<td width="50px" style="border-bottom:1px solid gray"> 번호 </td>
				<td width="500px" style="border-bottom:1px solid gray"> 제목 </td>
				<td width="100px" style="border-bottom:1px solid gray"> 조회수 </td>
				<td width="150px" style="border-bottom:1px solid gray"> 작성자 </td>
				<td width="150px" style="border-bottom:1px solid gray"> 작성일 </td>
			</tr>
			
			<c:forEach var="freeboard" items="${freeboard}" varStatus ="free">
			<tr> 
				<td style="padding-bottom:5px; padding-top:5px; height: 45px; border-bottom:1px solid gray"> ${free.count } </td>
				<td style="padding-bottom:5px; padding-top:5px; height: 45px; border-bottom:1px solid gray"> 
					<a href="${contextPath}/community/freeboardDetail.do?articleNO=${freeboard.articleNO}"> ${freeboard.free_title } [ ${freeboard.commentCnt } ]</a></td>
				<td style="padding-bottom:5px; padding-top:5px; height: 45px; border-bottom:1px solid gray"> ${freeboard.free_view_count} </td>
				<td style="padding-bottom:5px; padding-top:5px; height: 45px; border-bottom:1px solid gray"> ${freeboard.member_id } </td>
				<td style="padding-bottom:5px; padding-top:5px; height: 45px; border-bottom:1px solid gray"> ${freeboard.free_writeDate } </td>
			</tr>
			</c:forEach>
		</table>
	
	
	</div>

     <br><br><br><br>
    <a href="${contextPath}/community/freeForm.do"><input type="button" value="글쓰기" style="margin-left:700px;"></a>
	<br><br>
</body>
</html>
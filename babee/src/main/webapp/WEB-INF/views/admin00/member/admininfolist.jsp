<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 헤더</title>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
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
    <h2 style="margin: 0;">공지사항</h2>
    <div class="search-container">
        <form action="검색결과를_처리할_페이지_주소" method="GET">
            <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="search-button">
                <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:-5px">
            </button>
        </form>
    </div>
</div>

  
    <!-- <hr width="80%" style= "margin-left: 190px; margin-top: 60px;"> -->

<div class="table-container">
    <table class="faq-table" >
        <thead style="border-top: 2px solid gray; ">
		    <tr>
		        <th style="width: 10%;">NO</th>
		        <th style="width: 40%;">제목</th>
		        <th style="width: 10%;">작성자</th>
		        <th style="width: 10%;">작성일</th>
		        <th style="width: 8%;">조회수</th>
		        <th style="width: 5%;">삭제</th>
		    </tr>
		</thead>
        <tbody>
		    <c:forEach var="faq" items="${faqList}">
		        <tr class="faq-content">
		            
		            <td><p><img src="/image/bell.png" width="30px" height="30px"/></p></td>
		            <td><a href="/member/admininfodetail.do" style="display: flex; align-items: center;"><span style="color: black;">[공지사항][${faq.id}]</span></a></td>
		            <td><p style=" align-items: center;"><span style="color: black;">작성자 ${faq.author}</span></p></td>
		            <td><p style="align-items: center;"><span style="color: black;">작성일 ${faq.creationDate}</span></p></td>
		            <td><p style="align-items: center;"><span style="color: black;">조회수 ${faq.views}</span></p></td>
		            <td><a href="/member/deleteFaq/${faq.articleNO}" style="color: red;" onclick="return confirm('삭제하시겠습니까?');"><span style="font-size: 20px;">&#128683;</span></a></td>
		        </tr>
		    </c:forEach>
		</tbody>
        
    </table>
</div>
<div style="text-align: right; margin-top: -30px;">
    <a href="/member/admininfowrite.do" style="background-color: #ffffcc; padding: 5px 10px; border-radius: 5px; text-decoration: none; margin-right: 120px;">작성하기</a>
</div>
<div class="paging-container">
    <a class="paging-button" href="#">이전</a>
    <a class="paging-button" href="#">1</a>
    <a class="paging-button" href="#">2</a>
    <a class="paging-button" href="#">3</a>
    <a class="paging-button" href="#">4</a>
    <a class="paging-button" href="#">5</a>
    <a class="paging-button" href="#">다음</a>
</div>

</body>
</html>
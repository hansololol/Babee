<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 헤더</title>
<style>
    
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
        margin: 20px auto;
        border-collapse: collapse;
    }
    .faq-table th, .faq-table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ccc;
    }
    
    .menu-option-selected {
        font-weight: bold;
        text-decoration: underline;
    }
</style>
</head>
<body>
<div id="search">
    <h2 style="margin: 0;">나의 리뷰</h2>
    <div class="search-container">
        <form action="검색결과를_처리할_페이지_주소" method="GET">
            <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="search-button">
                <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:-5px">
            </button>
        </form>
    </div>
</div>


<div class="table-container">
    <table class="faq-table">
        <thead>
            <tr>
                <th style="width: 10%;">NO</th>
                <th style="width: 50%;">리뷰 내용</th>
                <th style="width: 20%;">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="faq" items="${faqList}">
                <tr class="faq-content">
                    <td>no${faq.articleNO}</td>
                    <td>
                        <a href="#" style="color: black; display: flex; align-items: center;" onclick="toggleAnswer('${faq.id}')">
                            [질문종류][${faq.id}]
                        </a>
                    </td>
                    <td>date${faq.joinDate}</td>
                </tr>
                <tr class="faq-answer" id="faqAnswer${faq.id}" style="display: none;">
                    <td colspan="3">
                        <p>${faq.questionContent}</p>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
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

<script>
    function toggleAnswer(answerId) {
        var answer = document.getElementById("faqAnswer" + answerId);
        if (answer.style.display === 'none') {
            answer.style.display = 'table-row';
        } else {
            answer.style.display = 'none';
        }
    }
</script>
</body>
</html>
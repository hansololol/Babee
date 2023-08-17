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
    .faq-content {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .faq-answer {
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
        margin-top: 20px;
    }
    .answer-button:hover {
        background-color: #ccc;
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
    
    
    .menu-option-selected {
        font-weight: bold;
        text-decoration: underline;
    }
</style>
</head>
<body>
<div id="search">
    <h2 style="margin: 0;">상품 문의</h2>
    <div class="search-container">
        <form action="검색결과를_처리할_페이지_주소" method="GET">
            <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="search-button">
                <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:-5px">
            </button>
        </form>
    </div>
</div>

<div class="menu-container">
    
    
    <hr width="66%" style= "margin-left: 170px">
</div>

<div class="table-container">
    <table class="faq-table">
        <thead>
            <tr>
                <th>글번호</th>
                <th>질문종류</th>
                <th>등록날짜</th>
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
                        <textarea class="answer-textarea" id="answerTextarea${faq.id}" placeholder="답변을 작성해주세요."></textarea>
                        <div style="text-align: center; margin-top: -10px;">
                            <form action="답변_처리_페이지_주소" method="post">
                                <input type="hidden" name="answerId" value="${faq.id}">
                                <button type="submit" class="answer-button">답변 제출</button>
                            </form>
                        </div>
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
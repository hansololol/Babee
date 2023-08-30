<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>고객센터</title>
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
    <h2 style="margin: 0;">고객센터</h2>
    <div class="search-container">
        <form action="검색결과를_처리할_페이지_주소" method="GET">
            <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="search-button">
                <img src="images/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:-5px">
            </button>
        </form>
    </div>
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
            <c:forEach var="faq" items="${qnaList}">
                      
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
                        <form action="${contextPath}/community/addQna.do?page=adminPage" method="post">
                        <textarea class="answer-textarea" id="answerTextarea${faq.id}" placeholder="답변을 작성해주세요."></textarea>
                  
                        <div style="text-align: center; margin-top: -10px;">
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
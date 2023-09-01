<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    /*페이징*/
.pagination {
    display: flex; /* Flexbox를 사용하여 가운데 정렬 */
    justify-content: center; /* 가로 가운데 정렬 */
    margin-top: 20px;
    position: relative; /* position 속성 추가 */
    z-index: 11; /* 적절한 z-index 값 설정 */
}

.pagination a,
.pagination span {
    display: inline-block;
    padding: 5px 10px;
    margin: 2px;
    border: 1px solid #ccc;
    background-color: #fff;
    color: #333;
    text-decoration: none;
    border-radius: 3px;
}

.pagination a:hover {
    background-color: #f0f0f0;
}

.pagination .current {
    background-color: #ffcd29;
    color: #fff;
    border:none;
}

.pagination .disabled {
    color: #ccc;
}
</style>
</head>
<body>

<div id="search">
    <h2 style="margin: 0;">상품 문의</h2>
    <div class="search-container">
        <form action="/seller/sellerQuestionAnswer.do?page=sellerPage" method="POST">
		    <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
		    <button type="submit" name="search" class="search-button">
		        <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:0px">
		    </button>
		</form>
    </div>
</div>
<form action="${contextPath}/seller/addGoodsQnaAnswer.do" method="post">
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
            <c:forEach items="${goodsQnaList}" var="goodsQna">
                <tr class="faq-content">
                    <td>${goodsQna.articleNO}</td>
                    <td>
                        <a href="#" style="color: black; display: flex; align-items: center; text-decoration: none;" onmouseover="this.style.textDecoration='underline';" onmouseout="this.style.textDecoration='none';" onclick="toggleAnswer('${goodsQna.articleNO}')">
						    [${goodsQna.goods_qna_middle_title}][${goodsQna.goods_qna_title}]
						</a>
                    </td>
                    <td>${goodsQna.goods_qna_writeDate}</td>
                </tr>
          
                <tr class="faq-answer" id="faqAnswer${goodsQna.articleNO}" style="display: none;">
				    <td colspan="3">
				        <p>${goodsQna.goods_qna_content}</p>
				        <c:choose>
				            <c:when test="${not empty goodsQna.goods_qna_answer}">
				                <p>[답변] ${goodsQna.goods_qna_answer}</p>
				            </c:when>
				            <c:otherwise>
				                <textarea class="answer-textarea" id="answerTextarea${goodsQna.seller_id}" name="goods_qna_answer" placeholder="답변을 작성해주세요."></textarea>
				                <div style="text-align: center; margin-top: -10px;">
				                    <input type="hidden" name="seller_id" value="${goodsQna.seller_id}">
				                    <input type="hidden" name="articleNO" value="${goodsQna.articleNO}">
				                    <button type="submit" class="answer-button">답변 제출</button>
				                </div>
				            </c:otherwise>
				        </c:choose>
				    </td>
				</tr>
               
            </c:forEach>
        </tbody>
    </table>
</div>
</form> 
<!-- 페이징 -->
<div class="pagination">
    <c:if test="${totalPages > 1}">
        <c:set var="startPage" value="${currentPage - 1}" />
        <c:if test="${startPage < 1}">
            <c:set var="startPage" value="1" />
        </c:if>
        <c:set var="endPage" value="${currentPage + 1}" />
        <c:if test="${endPage > totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>
        <c:if test="${endPage - startPage < 2}">
            <c:choose>
                <c:when test="${startPage > 1}">
                    <c:set var="startPage" value="${startPage - 1}" />
                </c:when>
                <c:otherwise>
                    <c:set var="endPage" value="${endPage + 1}" />
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="?page=sellerPage&pageNum=1&searchWord=${searchWord}">First</a>
                <a href="?page=sellerPage&pageNum=${currentPage - 1}&searchWord=${searchWord}">&lt;&lt;</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">First</span>
                <span class="disabled">&lt;&lt;</span>
            </c:otherwise>
        </c:choose>
        <c:forEach var="page" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="current">${page}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=sellerPage&pageNum=${page}&searchWord=${searchWord}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="?page=sellerPage&pageNum=${currentPage + 1}&searchWord=${searchWord}">&gt;&gt;</a>
                <a href="?page=sellerPage&pageNum=${totalPages}&searchWord=${searchWord}">Last</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">&gt;&gt;</span>
                <span class="disabled">Last</span>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>

<script>
    function toggleAnswer(answerId) {
        var answer = document.getElementById("faqAnswer" + answerId);
        if (answer.style.display !== 'table-row') {
            answer.style.display = 'table-row';
        } else {
            answer.style.display = 'none';
        }
    }
</script>
</body>
</html>
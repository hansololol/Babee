<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>문의내역 관리(관리자)</title>
<style>
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
	background-color: #ffcd29;
	color: #333;
	cursor: pointer;
}

.answer-button:hover {
	background-color: #cca300;
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

.admin-qna-table {
	width: 80%;
	margin: 60px auto;
	border-collapse: collapse;
}

.admin-qna-table th, .admin-qna-table td {
	padding: 8px;
	text-align: center;
	border: none; /* 기존 테두리 제거 */
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc; /* 아래쪽 경계선 추가 */
}
.admin_qna_list {
	width: 66%;
	margin: 0 auto;
}

</style>
</head>
<body>
<div class="admin_qna_list" style="margin-left: 165px;">
	<H3 style="display:inline-grid;"><span style="color:gray; font-size:20px; margin-bottom:3px;">[고객센터]</span>문의내역 관리</H3>
				<div style="background:rgb(255, 255, 202);">
		
		<hr style="margin-top: revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td><img src="/image/people.png" width="60px;"
					style="display: inline-block; padding-left: 15px;" />
					<p style="display: inline-block;">${memberInfo.member_name}님
						안녕하세요</p></td>
			</tr>
		</table>
		<hr style="margin-bottom: 50px;">
		</div>


<div class="table-container">
    <table class="admin-qna-table" style="width: 100%;">
        <thead>
            <tr>
                <th style="width: 10%; border-top:1px solid #ccc; padding: 5px;">답변상태</th>
                <th style="width: 50%; border-top:1px solid #ccc;">문의 내용</th>
                <th style="width: 20%; border-top:1px solid #ccc; border-right:none;">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="faq" items="${qnaList}" varStatus="cnt">
                <tr class="faq-content">
                    <td>
                    
                    <c:choose>
            		<c:when test="${faq.qna_answer != null}">
                	<span style="color: rgb(103, 185, 110);"><b>완료</b></span>
                    
                    </c:when>
                    <c:when test="${faq.qna_answer == null}">
                	
                   	대기
                    
                    </c:when>
                    </c:choose>
                    </td>
                    
                    <td>
                        <a href="#" style="color: black; display: flex; align-items: center;" onclick="toggleAnswer('${cnt.count}')">
                            ${faq.qna_title}
                        </a>
                    </td>
                    <td style="border-right:none;">${faq.qna_writeDate}</td>
                </tr>
                <tr class="faq-answer" id="faqAnswer${cnt.count}" style="display: none; ">
                    <td colspan="3" style="border-right:none;">
                    	<div style="background:#e6e6e6; padding:15px; border-radius:10px; display:flex; margin-bottom:10px;">
                    	<h5 style="float:left;"><span style="color: red;">Q.&nbsp;&nbsp;&nbsp;</span></h5>
   						<p>${faq.qna_content}</p>
   						</div>
   						
   						<div style="background:#e6e6e6; padding:15px; border-radius:10px; display:flex;  margin-bottom:10px;">
   						<h5 style="float:left;"><span style="color: green;">A.&nbsp;&nbsp;&nbsp;</span></h5>
   						<p>${faq.qna_answer}</p>
   						</div>
                        <div style="text-align: center; margin-top: -10px;">
                         
                  		<form action="${contextPath}/community/addQnaAnswer.do?page=adminPage" method="post">
                                      <input type="hidden" name="articleNO" value="${faq.articleNO}">
                                <textarea class="answer-textarea" id="answerTextarea${faq.member_id}" name="qna_answer" placeholder="답변을 작성해주세요."></textarea>
                       
                                <br>
                                <button type="submit" class="answer-button">답변 등록</button>
                            </form>
                        </div>
                    </td>
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
							<c:if test="${section >1 && page==1 }">
								<a class="paging-button"
									href="${contextPath}/community/adminAnswer.do?section=${section-1}&pageNum=${(section-1)*10 +1  }&page=adminPage">&nbsp;
									pre </a>
							</c:if>
							<a class="paging-button"
								href="${contextPath}/community/adminAnswer.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage">
							</a>
							<c:if test="${page ==10 }">
								<a class="paging-button"
									href="${contextPath}/community/adminAnswer.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp;
									next </a>
							</c:if>
						</c:forEach>
					</c:when>

					<c:when test="${totArticles ==100 }">
						<c:forEach var="page" begin="1" end="10" step="1">
							<a class="paging-button" href="#"> ${page }</a>
						</c:forEach>
					</c:when>

					<c:when test="${totArticles <100 }">
						<c:forEach var="page" begin="1" end="${totArticles/10 +1 }"
							step="1">
							<c:choose>
								<c:when test="${page==pageNum }">
									<a class="paging-button"
										href="${contextPath}/community/adminAnswer.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:when>
								<c:otherwise>
									<a class="paging-button"
										href="${contextPath}/community/adminAnswer.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:if>

		</div>

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
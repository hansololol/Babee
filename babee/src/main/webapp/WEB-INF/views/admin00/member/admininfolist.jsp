<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("utf-8");%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리(관리자)</title>
<style>
a:hover {
	font-weight: bold;
	text-decoration: underline;
}

a {
	color: black;
	text-decoration: none;
}

.info_add_btn > a {
  background-color: #ffcd29; /* 배경색 */
  color: black; /* 텍스트색 */
  padding: 10px 20px; /* 내부 여백 */
  border: none; /* 테두리 없음 */
  border-radius: 5px; /* 테두리 반경 */
  cursor: pointer; /* 커서 모양 변경 */
  font-size: 16px; /* 폰트 크기 */
}

.info_add_btn :hover {
background-color: #cca300; /* 호버 시 배경색 변경 */
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

.info-table {
	width: 80%;
	margin: 60px auto;
	border-collapse: collapse;
}

.info-table th, .faq-table td {
	padding: 8px;
	text-align: center;
	border: none; /* 기존 테두리 제거 */
	border-bottom: 1px solid #ccc; /* 아래쪽 경계선 추가 */
}

.admin_info_list {
	width: 66%;
	margin: 0 auto;
}


</style>
</head>
<body>

<div class="admin_info_list" style="margin-left: 165px;">
	<H3 style="display:inline-grid;">공지사항 관리</H3>
		<hr style="margin-top:revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td> 
					<img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
 					<p style="display:inline-block;"> ${memberInfo.member_name} 님 안녕하세요 </p>
				</td>
         	</tr>
      	</table>
		<hr style=" margin-bottom: 50px;">

		<div style="width: 100%;" >
			<table class="info-table" style="width: 100%;">
				<thead style="border-top: 1px solid #ccc;">
					<tr>
						<th style="width: 10%;">NO</th>
						<th style="width: 40%;">제목</th>
						<th style="width: 10%;">작성자</th>
						<th style="width: 5%;">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="info" items="${infoboard}">
						<tr>

							<td style="border-bottom:1px solid #ccc;">
								<p style="margin: revert;">
								<img src="/image/bell.png" width="25px" height="25px" />
								</p>
							</td>
							<td style="border-bottom:1px solid #ccc;">
								<a href="${contextPath}/community/admininfoDetail.do?articleNO=${info.articleNO}&page=adminPage"
									style="display: flex; align-items: center;"> 
									<span style="color: black;">[공지사항][${info.info_title}]</span>
								</a>
							</td>
							<td style="border-bottom:1px solid #ccc;">
								<p style="align-items: center; margin: revert;">
								<span style="color: black;">${info.member_id}</span>
								</p>
							</td>
							<td style="border-bottom:1px solid #ccc;">
								<a href="${contextPath}/community/deleteInfo.do?page=adminPage&articleNO=${info.articleNO}"
									style="color: red;" onclick="return confirm('삭제하시겠습니까?');"><span
									style="font-size: 20px;">&#128683;</span>
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		
		<div class="info_add_btn" style="text-align: right; margin-top: -30px;">
			<a href="/community/admininfowrite.do?page=adminPage"
				style="border-radius: 5px; text-decoration: none; ">공지사항 작성</a>
		</div>

		<div class="paging-container">
			<c:if test="${totArticles !=null}">
				<c:choose>
					<c:when test="${totArticles > 100 }">
						<c:forEach var="page" begin="1" end="10" step="1">
							<c:if test="${section >1 && page==1 }">
								<a class="paging-button"
									href="${contextPath}/community/admininfolist.do?section=${section-1}&pageNum=${(section-1)*10 +1  }&page=adminPage">&nbsp;
									pre </a>
							</c:if>
							<a class="paging-button"
								href="${contextPath}/community/admininfolist.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage">
							</a>
							<c:if test="${page ==10 }">
								<a class="paging-button"
									href="${contextPath}/community/admininfolist.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp;
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
										href="${contextPath}/community/admininfolist.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:when>
								<c:otherwise>
									<a class="paging-button"
										href="${contextPath}/community/admininfolist.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:if>

		</div>
	</div>

</body>
</html>
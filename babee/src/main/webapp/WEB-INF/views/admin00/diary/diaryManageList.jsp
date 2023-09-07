<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>다이어리 관리창(관리자)</title>
<style>
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

.menu-option>a {
	font-weight: normal;
	text-decoration: none;
	color: #333;
}

.paging-container>a:hover {
	font-weight: bold;
}

.paging-container>a {
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

.menu-container>hr, #foreachhr {
	margin: 1rem 25%;
	color: inherit;
	border: 0;
	border-top: var(- -bs-border-width) solid;
	opacity: .25;
}

.dir_M_list {
	width: 66%;
	margin: 0 auto;
}

a:hover {
	font-weight: bold;
	text-decoration: none;
}

a {
	color: black;
	text-decoration: none;
}

</style>

</head>
<body>
	<div class="dir_M_list" style="margin-left: 165px;">
		<H3 style="display: inline-grid;">다이어리 관리</H3>
		<div style="background: rgb(255, 255, 202);">

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


		<div style="text-align: center;">
			<table style="text-align: center; margin: 0 auto; width: 850px;">
				<tr style="border-bottom: 1px solid #ccc;">
					<td width="30px;"><b>NO</b></td>
					<td width="180px;"><b>다이어리 제목</b></td>
					<td width="90px;"><b>작성자</b></td>
					<td width="110px;"><b>작성일</b></td>
				</tr>


				<c:forEach var="diaryList" items="${diaryManageList}"
					varStatus="free">
					<tr style="height: 50px; border-bottom: 1px solid #ccc;">
						<td><img src="${contextPath}/image/set.png" width="20px" /></td>
						<td><a
							href="${contextPath}/diary/diaryDetail.do?dir_no=${diaryList.dir_no}"
							style="text-decoration-line: none; color: black;"> ${diaryList.dir_title}</td>
						<td>${diaryList.member_id} </a></td>
						<td>${diaryList.dir_writeDate}</td>
					</tr>
				</c:forEach>


			</table>
		</div>



		<!-- 페이징 버튼 -->
		<div class="paging-container">
			<c:if test="${totArticles !=null}">
				<c:choose>
					<c:when test="${totArticles > 100 }">
						<c:forEach var="page" begin="1" end="10" step="1">
							<c:if test="${section >1 && page==1 }">
								<a class="paging-button"
									href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${(section-1)*10 +1  }&page=adminPage">&nbsp;
									pre </a>
							</c:if>
							<a class="paging-button"
								href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage">
							</a>
							<c:if test="${page ==10 }">
								<a class="paging-button"
									href="${contextPath}/admin/order/diaryManageList.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp;
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
										href="${contextPath}/admin/order/diaryManageList.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:when>
								<c:otherwise>
									<a class="paging-button"
										href="${contextPath}/admin/order/diaryManageList.do?section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:if>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>사업자 관리창(관리자)</title>
<style>
.menu-container {
	margin-top: 50px; /* 여기서 100px 만큼 아래로 이동합니다. */ */
}

.menu-options {
	display: flex; /* 옆으로 정렬 */
	gap: 100px; /* 사이 간격 */

}

.menu-option>a {
	font-weight: normal;
	text-decoration: none;
	color: #333;
}

/* 선택 시 스타일 */
.menu-option:hover {
	font-weight: bold;
	text-decoration: none;
	
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

.seller-table {
	width: 80%;
	margin: 18px auto;
	border-collapse: collapse;
}

.seller-table th, .seller-table td {
	padding: 8px;
	text-align: center;
	border: none; /* 기존 테두리 제거 */
	border-bottom: 1px solid #ccc; /* 아래쪽 경계선 추가 */
}
.seller_list {
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
	<div class="seller_list" style="margin-left: 165px;">
	<H3 style="display: inline-grid;">사업자 관리</H3>
	<div style="background:rgb(255, 255, 202);">
		
		<hr style="margin-top: revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td><img src="/image/people.png" width="60px;"
					style="display: inline-block; padding-left: 15px;" />
					<p style="display: inline-block;">${memberInfo.member_name}님 안녕하세요</p></td>
			</tr>
		</table>
		<hr style="margin-bottom: 50px;">
	</div>
		<div class="menu-container" style="width:100%; border-bottom: 1px solid #ccc;height: 32px;">
			<div class="menu-options">
				<div class="menu-option" id="total">
					<a
						href="${contextPath}/admin/member/sellerManageList.do?page=adminPage"
						style="color: black; background-color: #fef7dd; border-radius: 5px 5px 0px 0px; padding: 10px;">사업자 목록</a>
				</div>
				<div class="menu-option" id="wait">
					<a
						href="${contextPath}/admin/member/sellerManageWait.do?page=adminPage"
						style="color: black; margin-right: 380px;">사업자 등록 요청</a>
				</div>
				
			</div>
			<hr>
		</div>

		<div style="width: 100%;">
			<table class="seller-table" style="width: 100%;">
				<tr style="border-bottom: 1px solid gray;">
					<td width="80px;"><b>NO</b></td>
					<td width="200px;"><b>사업자 명</b></td>
					<td width="200px;"><b>상호 명</b></td>
					<td width="150px;"><b>사업체 승인 날짜</b></td>
				</tr>


				<c:forEach var="seller" items="${seller}" varStatus="sellerNO">
					<tr style="height: 50px; border-bottom: 1px solid gray;">
						<td>${sellerNO.count}</td>
						<td>${seller.seller_name}</a></td>
						<td><a
							href="${contextPath}/admin/member/sellerDetail.do?page=adminPage&seller_id=${seller.seller_id}">${seller.seller_company}
						</a></td>
						<td>${seller.seller_confirmDate}</td>
						<input type="hidden" value="${seller.seller_status}">
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
									href="${contextPath}/admin/member/sellerManageList.do?page=adminPage&section=${section-1}&pageNum=${(section-1)*10 +1  }&page=adminPage">&nbsp;
									pre </a>
							</c:if>
							<a class="paging-button"
								href="${contextPath}/admin/member/sellerManageList.do?page=adminPage&section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage">
							</a>
							<c:if test="${page ==10 }">
								<a class="paging-button"
									href="${contextPath}/admin/member/sellerManageList.do?page=adminPage&section=${section-1}&pageNum=${section*10 +1 }&page=adminPage">&nbsp;
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
										href="${contextPath}/admin/member/sellerManageList.do?page=adminPage&section=${section}&pageNum=${page}&page=adminPage">${page }</a>
								</c:when>
								<c:otherwise>
									<a class="paging-button"
										href="${contextPath}/admin/member/sellerManageList.do?page=adminPage&section=${section}&pageNum=${page}&page=adminPage">${page }</a>
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
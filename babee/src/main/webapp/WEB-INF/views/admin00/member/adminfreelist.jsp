<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>자유게시판 목록(관리자)</title>
	<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous">
	</script>
	
<style>
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

a:hover {
	font-weight: bold;
}

a {
	color: black;
	text-decoration: none;
}

.free-table {
	width: 80%;
	margin: 60px auto;
	border-collapse: collapse;
}

.free-table th, .free-table td {
	border: none; /* 기존 테두리 제거 */
	border-bottom: 1px solid #ccc; /* 아래쪽 경계선 추가 */
}

.admin_free_list {
	width: 66%;
	margin: 0 auto;
}
</style>

</head>

<body>

<div class="admin_free_list" style="margin-left: 165px;">
	<H3 style="display:inline-grid;">자유게시판 관리</H3>
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
      <table class="free-table" style="width: 100%;">
        <thead style="border-top: 1px solid #ccc">
          <tr>
            <th style="width: 10%; padding:8px;">NO</th>
            <th style="width: 30%; padding:8px;">제목</th>
            <th style="width: 10%; padding:8px;">작성자</th>
            <th style="width: 15%; padding:8px;">작성일</th>
            <th style="width: 8%; padding:8px;">조회수</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="free" items="${freeboard}">
            <tr>
              <td>
                <img src="${contextPath}/image/set.png" width="20px" />
              </td>
              <td>
                <a
                  href="/community/freeboardDetail.do?articleNO=${free.articleNO} "
                  style="display: flex"
                  ><span style="color: black; text-align: left"
                    >${free.free_title}</span
                  ></a
                >
              </td>
              <td>
                <p style="align-items: center; margin-top:16px;">
                  <span style="color: black">${free.member_id}</span>
                </p>
              </td>
              <td>
                <p style="align-items: center; font-size:14px; margin-top:16px;">
                  <span style="color: black">${free.free_writeDate}</span>
                </p>
              </td>
              <td>
                <p style="align-items: center; margin-top:16px;">
                  <span style="color: black">${free.free_view_count}</span>
                </p>
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
                <a
                  class="paging-button"
                  href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${(section-1)*10 +1 }&page=adminPage"
                  >&nbsp; pre
                </a>
              </c:if>
              <a
                class="paging-button"
                href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${(section-1)*10 +page }&page=adminPage"
              >
              </a>
              <c:if test="${page ==10 }">
                <a
                  class="paging-button"
                  href="${contextPath}/community/adminfreelist.do?section=${section-1}&pageNum=${section*10 +1 }&page=adminPage"
                  >&nbsp; next
                </a>
              </c:if>
            </c:forEach>
          </c:when>

          <c:when test="${totArticles ==100 }">
            <c:forEach var="page" begin="1" end="10" step="1">
              <a class="paging-button" href="#"> ${page }</a>
            </c:forEach>
          </c:when>

          <c:when test="${totArticles <100 }">
            <c:forEach
              var="page"
              begin="1"
              end="${totArticles/10 +1 }"
              step="1"
            >
              <c:choose>
                <c:when test="${page==pageNum }">
                  <a
                    class="paging-button"
                    href="${contextPath}/community/adminfreelist.do?section=${section}&pageNum=${page}&page=adminPage"
                    >${page }</a
                  >
                </c:when>
                <c:otherwise>
                  <a
                    class="paging-button"
                    href="${contextPath}/community/adminfreelist.do?section=${section}&pageNum=${page}&page=adminPage"
                    >${page }</a
                  >
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

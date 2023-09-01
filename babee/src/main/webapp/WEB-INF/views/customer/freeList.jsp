<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%= new java.util.Date()%>" />
<fmt:formatDate value="${now }" pattern="dd" type="date" var="today" />

<!DOCTYPE html>
<html>
  <head>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous"
    ></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="UTF-8" />

    <title>자유게시판 목록</title>
    <style>
      #search {
        background-color: #fef7dd;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
        width: 50%;
      }
      .search-container {
        display: flex;
        align-items: center;
        width: 70%; /* 검색 입력 영역이 늘어나도록 설정 */
      }
      .search-input {
        border: 1px solid #ffa500;
        text-align: center;
        padding: 5px;
        flex: 3; /* Make the text box wider */
        border-radius: 5px;
        margin-left: 20px;
        width: 400px;
        height: 30px;
      }
      .search-button {
        border: none;
        background: none;
        margin-top: -10px;
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

      /* '다이어리 작성' 버튼 스타일 */
      input[type="button"] {
        background-color: #ffcd29; /* 배경색 */
        color: black; /* 텍스트색 */
        padding: 10px 20px; /* 내부 여백 */
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 테두리 반경 */
        cursor: pointer; /* 커서 모양 변경 */
      }

      /* 버튼에 호버 효과 */
      input[type="button"]:hover,
      button[type="button"]:hover {
        background-color: #cca300; /* 호버 시 배경색 변경 */
      }

      #viewCountSapn {
        border: 1px solid rgb(180, 180, 180);
        border-radius: 40%;
        padding: 3px;
        color: palevioletred;
        font-size: 13px;
      }
      #newTag {
        background: url(//t1.daumcdn.net/cafe_image/cf_img4/skin/W01/10_new.svg);
        background-repeat: no-repeat;
        background-size: contain;
      }
      #freeImage {
        background: url(//t1.daumcdn.net/cafe_image/cf_img4/skin/W01/16_add_photo.svg);
        background-repeat: no-repeat;
        background-size: contain;
      }
    </style>
  </head>
  <body>
    <br /><br /><br />

    <div id="search">
      <h2>자유게시판</h2>
      <div class="search-container">
        <input
          id="searchFreeWord"
          class="search-input"
          type="text"
          placeholder="검색어를 입력해주세요."
        />
        <button type="button" onclick="fn:searchList()" class="search-button">
          <img
            src="/image/glass.png"
            alt="검색"
            style="width: 20px; height: 20px"
          />
        </button>
        <script>
          function searchList() {
            var searchWord = $("#searchFreeWord").val();
            $.ajax({
              type: "get",
              url: "${contextPath}/community/freeboardList.do",
              data: { searchWord: searchWord },

              success: function (result) {
                $("#container").html(result);
              },
            });
          }
        </script>
      </div>
    </div>
    <div id="freeboardList" style="padding-top: 30px">
      <table style="margin: auto">
        <tr>
          <td width="50px" style="border-bottom: 1px solid gray">NO</td>
          <td width="500px" style="border-bottom: 1px solid gray">제목</td>
          <td width="100px" style="border-bottom: 1px solid gray">조회수</td>
          <td width="150px" style="border-bottom: 1px solid gray">작성자</td>
          <td width="150px" style="border-bottom: 1px solid gray">작성일</td>
        </tr>

        <c:forEach var="freeboard" items="${freeboard}" varStatus="free">
          <fmt:formatDate
            value="${freeboard.free_writeDate }"
            pattern="dd"
            type="date"
            var="textDate"
          />
          <tr>
            <td
              style="
                padding-bottom: 5px;
                padding-top: 5px;
                height: 45px;
                border-bottom: 1px solid gray;
              "
            >
              <img src="${contextPath}/image/freeboard.png" width="30px" />
            </td>
            <td
              style="
                padding: 5px 0 5px 20px;
                height: 45px;
                border-bottom: 1px solid gray;
                text-align: left;
              "
            >
              <a
                href="${contextPath}/community/freeboardDetail.do?articleNO=${freeboard.articleNO}"
              >
                ${freeboard.free_title }
                <span id="viewCountSapn"> ${freeboard.commentCnt } </span>
              </a>
              <c:if test="${freeboard.free_img !=null}">
                &nbsp; <span id="freeImage">&nbsp;&nbsp;&nbsp;&nbsp;</span>
              </c:if>
              <c:if test="${free.count <9 && pageNum ==1 }">
                &nbsp; <span id="newTag">&nbsp;&nbsp;&nbsp;&nbsp;</span>
              </c:if>
            </td>
            <td
              style="
                padding-bottom: 5px;
                padding-top: 5px;
                height: 45px;
                border-bottom: 1px solid gray;
              "
            >
              ${freeboard.free_view_count}
            </td>
            <td
              style="
                padding-bottom: 5px;
                padding-top: 5px;
                height: 45px;
                border-bottom: 1px solid gray;
              "
            >
              ${freeboard.member_id }
            </td>

            <c:if test="${today == textDate}">
              <td
                style="
                  padding-bottom: 5px;
                  padding-top: 5px;
                  height: 45px;
                  border-bottom: 1px solid gray;
                "
              >
                <fmt:formatDate
                  value="${freeboard.free_writeDate }"
                  pattern="HH:mm"
                  type="date"
                />
              </td>
            </c:if>
            <c:if test="${today != textDate}">
              <td
                style="
                  padding-bottom: 5px;
                  padding-top: 5px;
                  height: 45px;
                  border-bottom: 1px solid gray;
                "
              >
                <fmt:formatDate
                  value="${freeboard.free_writeDate }"
                  pattern="MM-dd"
                  type="date"
                />
              </td>
            </c:if>
          </tr>
        </c:forEach>
      </table>
    </div>
    <br /><br />
    <c:choose>
      <c:when test="${isLogOn == true }">
        <a href="${contextPath}/community/freeForm.do"
          ><input type="button" value="글쓰기" style="margin-left: 700px"
        /></a>
      </c:when>
    </c:choose>

    <div class="paging-container">
      <c:if test="${totArticles !=null}">
        <c:choose>
          <c:when test="${totArticles > 100 }">
            <c:forEach var="page" begin="1" end="10" step="1">
              <c:if test="${section >1 && page==1 }">
                <a
                  class="paging-button"
                  href="${contextPath}/community/freeboardList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }"
                  >&nbsp; pre
                </a>
              </c:if>
              <a
                class="paging-button"
                href="${contextPath}/community/freeboardList.do?section=${section-1}&pageNum=${(section-1)*10 +page }"
              >
              </a>
              <c:if test="${page ==10 }">
                <a
                  class="paging-button"
                  href="${contextPath}/community/freeboardList.do?section=${section-1}&pageNum=${section*10 +1 }"
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
                    href="${contextPath}/community/freeboardList.do?section=${section}&pageNum=${page}"
                    >${page }</a
                  >
                </c:when>
                <c:otherwise>
                  <a
                    class="paging-button"
                    href="${contextPath}/community/freeboardList.do?section=${section}&pageNum=${page}"
                    >${page }</a
                  >
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </c:when>
        </c:choose>
      </c:if>
    </div>

    <br /><br />
  </body>
</html>

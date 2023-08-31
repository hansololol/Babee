<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>관리자 자주하는질문 작성창</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
      /* 전체 스타일은 여기에 기존 스타일 코드를 놔두고, 원하는 영역에 클래스 스타일을 추가합니다 */
      .custom-style {
        display: flex;
        justify-content: center;
        align-items: center;
      }

      /* 추가된 클래스 스타일 */
      .form-container {
        width: 70%;
        margin: 20px auto;
      }

      .form-container table {
        width: 63%;
        border-collapse: collapse;
        height: 700px;
        margin: 0 auto;
        margin-top: 10px;
      }

      .form-container th,
      .form-container td {
        padding: 10px;
        border-top: 1px solid gray;
        border-bottom: 1px solid gray;
      }

      .form-container th {
        width: 20%;
      }

      .form-container td {
        width: 63%;
      }

      .form-container input[type="text"],
      .form-container select,
      .form-container textarea,
      .form-container input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid rgba(128, 128, 128, 0.25);
        border-radius: 5px;
        box-sizing: border-box;
        margin-left: -10px;
      }

      .form-container select {
        margin-left: -3px;
      }

      .form-container textarea {
        width: 100%;
        height: 500px;
        resize: vertical;
      }

      .form-container .file-preview img {
        width: 200px;
        height: auto;
        margin: 10px 0;
      }

      .form-container .btn-container {
        margin-top: 10px;
        text-align: center;
      }

      .form-container button,
      .form-container a {
        background-color: orange;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 10px 30px;
        font-size: 16px;
        cursor: pointer;
        margin: 0 20px;
        transition: background-color 0.3s;
        text-decoration: none;
        display: inline-block;
      }

      .form-container button:hover,
      .form-container a:hover {
        background-color: #ff7e00;
      }
    </style>
  </head>
  <body>
    <div class="custom-style">
      <form
        class="form-container"
        method="post"
        action="${contextPath}/community/addqna.do"
      >
        <h1 style="text-align: center">고객센터</h1>
        <h3 style="text-align: center">문의하기</h3>
        <hr />

        <div>
          <table>
            <tr>
              <th>작성자</th>
              <c:if test="${memberInfo.member_id != null }">
                <td style="text-align: left">&nbsp; ${memberInfo.member_id}</td>
              </c:if>
              <c:if test="${memberInfo.seller_id != null }">
                <td style="text-align: left">&nbsp; ${memberInfo.seller_id}</td>
              </c:if>
            </tr>

            <tr>
              <th>제목</th>
              <td><input type="text" name="qna_title" /></td>
            </tr>

            <tr>
              <th>문의내용</th>
              <td>
                <div style="padding: 10px 0">
                  <textarea name="qna_content"></textarea>
                </div>
              </td>
            </tr>
          </table>
        </div>
        <br />
        <div class="btn-container">
          <button type="submit">작성하기</button>
          <a href="/community/questionList.do">취소하기</a>
        </div>
      </form>
    </div>
  </body>
</html>

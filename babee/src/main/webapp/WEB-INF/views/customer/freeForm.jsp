<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
  <head>
    <meta charset="UTF-8" />

    <title>관리자 자주하는질문 작성창</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#preview").attr("src", e.target.result);
            $("#preview").css("display", "block");
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
    </script>

    <style>
      /* 전체 스타일은 여기에 기존 스타일 코드를 놔두고, 원하는 영역에 클래스 스타일을 추가합니다 */
      .custom-style {
        display: flex;
        justify-content: center;
        align-items: center;
      }

      /* 추가된 클래스 스타일 */
      .form-container {
        width: 50%;
        margin: 20px auto;
      }

      .form-container table {
        width: 90%;
        margin: 0 auto;
        margin-top: 10px;
      }

      .form-container td {
        text-align: center;
        padding: 10px;
        border-top: 1px solid gray;
        border-bottom: 1px solid gray;
      }

      .form-container input[type="text"],
      .form-container textarea,
      .form-container input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid rgba(128, 128, 128, 0.25);
        border-radius: 5px;
        box-sizing: border-box;
        margin-left: -10px;
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

      .form-container button {
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

      .form-container button:hover {
        background-color: #ff7e00;
      }
      #imageFree :hover {
        background-color: gainsboro;
      }
    </style>
    <script>
      $(document).ready(function () {
        $('input[name="imageUpload"]').on("change", function (event) {
          var file = event.target.files[0];
          var reader = new FileReader();
          reader.onload = function (e) {
            $(".file-preview").html(
              '<img src="' + e.target.result + '" alt="Preview">'
            );
          };
          reader.readAsDataURL(file);
        });
      });

      function inputFile() {
        $("#inputFile").click();
      }
    </script>
  </head>
  <body>
    <div class="custom-style">
      <form
        class="form-container"
        method="post"
        action="${contextPath}/community/addFreeboard.do"
        enctype="multipart/form-data"
      >
        <input
          type="file"
          name="free_img1"
          id="inputFile"
          onChange="readURL(this);"
          style="display: none; margin: 0 auto"
        />
        <input type="hidden" name="articleNO" value="${param.articleNO}" />
        <h1 style="text-align: center">자유게시판</h1>
        <h3 style="text-align: center">작성페이지</h3>
        <hr />

        <div>
          <table>
            <tr>
              <td>
                <input
                  type="text"
                  name="free_title"
                  placeholder="제목을 입력해주세요"
                />
              </td>
            </tr>
            <tr>
              <td style="text-align: left">
                <a
                  href="javascript:inputFile()"
                  style="text-decoration: none"
                  id="imageFree"
                >
                  <img
                    src="/image/add.png"
                    width="40px"
                    style="margin-left: 50px"
                  />
                </a>
              </td>
            </tr>
            <tr>
              <td>
                <div style="padding: 10px 0">
                  <img
                    id="preview"
                    src=""
                    width="200"
                    height="200"
                    style="display: none; margin: 0 auto"
                  />
                  <textarea
                    name="free_content"
                    style="border: none; height: 500px"
                    placeholder="내용을 입력해주세요"
                  ></textarea>
                </div>
              </td>
            </tr>
          </table>
        </div>
        <br />
        <div class="btn-container">
          <button type="submit">작성하기</button>
          <button
            type="button"
            onclick="location.href='${contextPath}/main/main.do'"
          >
            메인페이지
          </button>
        </div>
      </form>
    </div>
  </body>
</html>

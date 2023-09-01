<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%> <%
request.setCharacterEncoding("utf-8"); %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>리뷰 작성창</title>

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            $("#preview").attr("src", e.target.result);
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
    </script>
    <style>
      .container {
            max-width: 850px;
            margin: 50px auto;
            /* background: #ededed; */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }
      .star-goods_star {
        display: flex;
        flex-direction: row-reverse;
        font-size: 2.25rem;
        line-height: 2.5rem;
        justify-content: space-around;
        padding: 0 0.2em;
        text-align: center;
        width: 5em;
      }

      .star-goods_star input {
        display: none;
      }

      .star-goods_star label {
        -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
        -webkit-text-stroke-width: 2.3px;
        -webkit-text-stroke-color: #2b2a29;
        cursor: pointer;
      }

      .star-goods_star :checked ~ label {
        -webkit-text-fill-color: gold;
      }

      .star-goods_star label:hover,
      .star-goods_star label:hover ~ label {
        -webkit-text-fill-color: #fff58c;
      }
      /* '작성하기' 버튼 스타일 */
      .diary_write_btn > input[type="submit"] {
        background-color: #ffcd29; /* 배경색 */
        color: black; /* 텍스트색 */
        padding: 10px 20px; /* 내부 여백 */
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 테두리 반경 */
        cursor: pointer; /* 커서 모양 변경 */
      }

      /* '다시입력' 버튼 스타일 */
      .diary_write_btn > input[type="reset"] {
        background-color: #ffff80; /* 배경색 */
        color: black; /* 텍스트색 */
        padding: 10px 20px; /* 내부 여백 */
        border: none; /* 테두리 없음 */
        border-radius: 5px; /* 테두리 반경 */
        cursor: pointer; /* 커서 모양 변경 */
      }

      /* 버튼에 호버 효과 */
      .diary_write_btn > input[type="submit"]:hover,
      input[type="reset"]:hover {
        background-color: #cca300; /* 호버 시 배경색 변경 */
      }

      .form-group {
            margin-bottom: 20px;
      }

      .file-input-label {
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .file-input {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
      }
      .image-preview {
        max-width: 100%;
        max-height: 250px;
       
        margin-top: 10px;
      }
      input[type="text"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            /* border: 1px solid #ccc; */
            border: none;
            border-radius: 5px;
        }
    </style>
  </head>
  <body>
    <div class="container" style="border:1px solid lightgray; padding: 20px 40px 40px">
    <form method="post" action="${contextPath}/mypage/reviewWrite.do" enctype="multipart/form-data">
      <div class="form-group" style="display: flex; align-items: baseline; justify-content: center; margin-bottom: 50px;">
        <img src="/image/reviewIcon.png" width="70" height="70"><h1>리뷰 작성</h1>
      </div>
      <input type="hidden" name="goods_id" value="${param.goods_id}" />
      <input type="hidden" name="goods_image_name1" value="${param.goods_image_name1}" />
      <input type="hidden" name="goods_title" value="${param.goods_title}" />
      <div class="form-group" style="font-weight: bold; font-size: 18px;">
        <img src="${contextPath}/thumbnails.do?goods_id=${param.goods_id}&fileName=${param.goods_image_name1}" style="width: 120px; margin-right: 50px;">
        ${param.goods_title}
      </div>

      <hr>

      <div class="form-group" >
        <input type="text"name="review_title" size="45" style="margin-left: 10px" placeholder="제목"/>
      </div>
      
      <hr>

      <div class="form-group" style="border: 1px solid lightgray; border-radius: 5px; padding: 20px; background-color:#f9f7f0;">
        <div class="file-input-label">
          <table>
            <tr>
              <td width="400px;" height="200px;">
                <label for="imageFile"><img src="${contextPath}/image/add.png" alt="파일 선택" width="30" height="30" style="cursor: pointer;"></label>
                <input type="file" class="file-input" id="imageFile" name="imageFile" onchange="readURL(this);">
                			<p style="font-size: 12px;">다음 파일 형식만 지원됩니다.<br>.jpg(JPEG), .png(Portable Network Graphics), .gif(Graphics Interchange Format)</p>
              </td>
              <td width="400px;">
                <img id="preview" class="image-preview" src="#" alt="" style="margin: auto;">
              </td>
            </tr>
          </table>
        </div>
      </div>

      <hr>

      <div class="form-group">
        <textarea name="review_content" rows="10" maxlength="1000" placeholder="내용"></textarea>
      </div>

      <hr>
      
      <div style="margin-bottom: 50px;">
        <div style="text-align: left; margin-left: 20px; color: gray;">별점</div>
        <div class="star-goods_star space-x-4 mx-auto">
          <input type="radio" id="5-stars" name="goods_star" value="5" v-model="goods_stars"/>
          <label for="5-stars" class="star pr-4">★</label>

          <input type="radio" id="4-stars" name="goods_star" value="4" v-model="goods_stars"/>
          <label for="4-stars" class="star">★</label>

          <input type="radio" id="3-stars" name="goods_star" value="3" v-model="goods_stars"/>
          <label for="3-stars" class="star">★</label>

          <input type="radio" id="2-stars" name="goods_star" value="2" v-model="goods_stars"/>
          <label for="2-stars" class="star">★</label>

          <input type="radio" id="1-star" name="goods_star" value="1" v-model="goods_stars"/>
          <label for="1-star" class="star">★</label>
        </div>
      </div>
       
       
      <div class="diary_write_btn">
        <input type="submit" value="작성하기" />&nbsp;&nbsp;&nbsp;
        <input type="reset" value="다시입력" />
      </div>
    </form>
  </div>
  </body>
</html>

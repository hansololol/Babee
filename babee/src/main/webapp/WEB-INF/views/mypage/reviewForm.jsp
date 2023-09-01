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
      
      .reviewTable {
        border: 1px solid gray;
        border-collapse: collapse;
        margin: 30px auto;
        border-radius: 50px;
      }

      .reviewTable th{
        width: 200px;
        border: none; 
        padding: 30px;
      }

      .reviewTable td{
        border: none;
        padding: 10px;
      }
    </style>
  </head>
  <body>
    
    <form method="post" action="${contextPath}/mypage/reviewWrite.do" enctype="multipart/form-data" style="margin-left: 120px; width: 800px">
      <div style="display: flex; align-items: baseline; justify-content: center;">
        <img src="/image/reviewIcon.png"><h1>리뷰 작성</h1>
      </div>
      <input type="hidden" name="goods_id" value="${param.goods_id}" />
      <table class="reviewTable">
        <tr>
          <th>작성자</th>
          <td colspan="2">
            <!--사용자 일때-->
            <c:if test="${memberInfo.member_id != null }">
              ${memberInfo.member_name}
                <input type="hidden" name="member_id" value="${memberInfo.member_id}"/> 
            </c:if>
            <!--사업자 일때-->
            <c:if test="${memberInfo.seller_id != null }">
              ${memberInfo.seller_name}
                <input type="hidden" name="member_id" value="${memberInfo.seller_id}"/>
            </c:if>
          </td>
        </tr>

        <tr>
          <th>제목</th>
          <td colspan="2">
            <input type="text"name="review_title" size="45" style="margin-left: 10px"/>
          </td>
        </tr>

        <tr>
          <th>상품 이미지</th>
          <td style="border-right-color: white;">
            <input type="file" name="imageFile" onChange="readURL(this);" style="margin-left: 10px"/>
            <p style="font-size: 12px">
              &nbsp;다음 파일 형식만 지원됩니다.<br />
            </p>
            <p style="font-size: 12px">
              &nbsp;.jpg(JPEG), .png(Portable Network Graphics), .gif(Graphics
              Interchange Format)
            </p>
          </td>

          <td>
            <img id="preview" src="#" width="200" height="200" />
          </td>
        </tr>

        <tr>
          <th>내용</th>
          <td colspan="2">
            <textarea name="review_content" rows="10" cols="50" maxlength="3000"></textarea>
          </td>
        </tr>
	
        <tr>
          <th>별점</th>
          <td colspan="2">
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
          </td>
        </tr>
      </table>
       
      <div class="diary_write_btn">
        <input type="submit" value="작성하기" />&nbsp;&nbsp;&nbsp;
        <input type="reset" value="다시입력" />
      </div>
    </form>
  </body>
</html>

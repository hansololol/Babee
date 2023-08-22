<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 위시리스트</title>
    <style>
        .container {
            width: 900px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
            
        }
        .wish_list {
            width: 800px;
            margin: 0 auto;
            margin-top: 50px;
            align-items: center;
        }
        .wish_list tr{
            border-bottom: 2px solid;
        }
        
        /* '삭제' 버튼 스타일 */
        .wish_list td>a {
            background-color: #ffcd29; /* 배경색 */
            color: black; /* 텍스트색 */
            padding: 8px 8px; /* 내부 여백 */
            border: none; /* 테두리 없음 */
            border-radius: 5px; /* 테두리 반경 */
            cursor: pointer; /* 커서 모양 변경 */
            text-decoration: none;
        }

        /* 버튼에 호버 효과 */
        .wish_list td>a:hover {
        background-color: #cca300; /* 호버 시 배경색 변경 */
        }
        .goods_img{
            margin-right: 30px;
        }
        
        
    </style>
    <script>
        function deleteProduct(button) {
            button.parentElement.remove();
        }

        function selectAll() {
            var checkboxes = document.querySelectorAll('.product-checkbox');
            var selectAllCheckbox = document.getElementById('select-all-checkbox');

            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = selectAllCheckbox.checked;
            }
        }
        function delete_wishList(articleNO) {
        var articleNO = Number(articleNO);
        var formObj = document.createElement("form");
        var i_wish = document.createElement("input");
        i_wish.name = "articleNO";
        i_wish.value = articleNO;

        formObj.appendChild(i_wish);
        document.body.appendChild(formObj);
        formObj.method = "post";
        formObj.action = "${contextPath}/mypage/removeWishList.do";
        formObj.submit();
        }
    </script>
</head>
<body>
    <br><br>

    <div class="container">
        <h1>나의 위시리스트</h1>
        <table class="wish_list">
            <tr>
               <td width="100px" height="15px;">
                  <div class="text_center">
                     <input type="checkbox" id="select-all-checkbox" onchange="selectAll()">전체 선택
                  </div>
               </td>
               <td width="400px" style="text-align: center;">상품 정보</td>
               <td width="100px">가격</td>
               <td width="100px"></td>
            </tr>

            <c:forEach var="wishVO" items="${myWishList}">
               <tr>
                  <td class="text_center"><input type="checkbox" class="product-checkbox"></td>
                  <td><img src="${contextPath}/thumbnails.do?goods_id=${wishVO.goods_id}&fileName=${wishVO.goods_image_name1}" width="100px" class="goods_img" />${wishVO.goods_title}</td>
                  <td>${wishVO.goods_price}</td>
                  <td><a href="javascript:delete_wishList(${wishVO.articleNO})" style="font-size: 3px;"><b><span>삭제</span></b></a></td>
               </tr>
            </c:forEach>

         </table>
    </div>
    <br><br> <br><br>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>찜 목록</title>
    <style>
        .container {
            width: 900px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        .product {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .product img {
            width: 100px;
            height: 100px;
            margin-right: 20px;
        }
        .product-info {
            flex: 1;
        }
        .product-price {
            font-weight: bold;
            color: green;
        }
        .heart-button {
            color: red;
            font-size: 20px;
            cursor: pointer;
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
    </script>
</head>
<body>
    <br><br>
    <div class="container">
        <h1>찜 목록</h1>

        <div>
            <input type="checkbox" id="select-all-checkbox" onchange="selectAll()"> 전체 선택
        </div>


 <c:forEach var="i" begin="0" end="5">
        <div class="product">
            <input type="checkbox" class="product-checkbox"> &nbsp;&nbsp;
            <img src="/image/shopping3.jpg" style="border-radius: 3px;">
            <div class="product-info">
                <p>상품명: 상품 2</p>
                <p class="product-price">가격: 10,000원</p>
            </div>
            <span class="heart-button" onclick="deleteProduct(this)">&#x2764;</span>
        </div>
    </c:forEach>
        <!-- 다른 상품들도 위와 같은 형식으로 추가할 수 있습니다. -->
    </div>
    <br><br> <br><br>
</body>
</html>
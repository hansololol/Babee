<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />

<html>
<head>

<style>
    hgroup{
        text-align: left;
        margin-left:25%;
    }
#layer {
    z-index: 2;
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
}

#popup {
    z-index: 3;
    position: fixed;
    text-align: center;
    left: 50%;
    top: 45%;
    width: 300px;
    height: 200px;
    background-color: #ccffff;
    border: 3px solid #87cb42;
}

#close {
    z-index: 4;
    float: right;
}

#order_goods_qty > select {
    display: block;
    width: 280px;
    height: 36px;
    margin: 0 0 3px 16px;
    padding: 0 0 0 18px;
    border: 1px solid #d0d0d0;
    color: #979d9d;
}


.nav {
    
    padding-left: 27%;
}

.file-preview{
    float: left;
    margin-left: 10%;
}
</style>
<script type="text/javascript">
    $(document).ready(function() {
        $('input[name="goods_image_name1"]').on('change', function(event) {
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e) {
                $('.file-preview1').html('<img src="' + e.target.result + '" alt="Preview" style="width: 200px; height: 200px; margin: 10px 0 10px 0;"> <br><input type="file">');
            };
            reader.readAsDataURL(file);
        });
    });
    $(document).ready(function() {
        $('input[name="goods_image_name2"]').on('change', function(event) {
            var file = event.target.files[0];
            var reader = new FileReader();
            reader.onload = function(e) {
                $('.file-preview2').html('<img src="' + e.target.result + '" alt="Preview" style="width: 200px; height: 200px; margin: 10px 0 10px 0;"> <br><input type="file">');
            };
            reader.readAsDataURL(file);
        });
    });
</script>
</head>
<body>
    <br>
    <h1>상품 등록하기</h1>
    <br><br>

    <div id="detail_table" style="margin-left:25%;">
        <form action="${contextPath}/admin/goods.do/addNewGoods.do" method="post" enctype="multipart/form-data">
            <table>
                <tbody>
                    <!-- 상품명 -->
                    <tr>
                        <td class="fixed">상품명</td>
                        <td class="active">
                            <input type="text" name="goods_title">
                        </td>
                    </tr>
                    <!-- 판매가 -->
                    <tr class="dot_line">
                        <td class="fixed">판매가</td>
                        <td class="active">
                            <input type="text" name="goods_price">
                        </td>
                    </tr>
                    <!-- 재고 -->
                    <tr>
                        <td class="fixed">재고</td>
                        <td class="fixed">
                            <input type="text" name="goods_stock">
                         </td>
                    </tr>
                    <!-- 카테고리 -->
                    <tr class="dot_line">
                        <td class="fixed">카테고리</td>
                        <td class="fixed">
                            <select style="text-align: center" name="main_category">
                                <option>대분류</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                            <select style="text-align: center" name="middle_category">
                                <option>중분류</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                            <select style="text-align: center" name="sub_category">
                                <option>소분류</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </td>
                    </tr>
                    <!-- 사용 연령 -->
                    <tr class="dot_line">
                        <td class="fixed">사용 연령</td>
                        <td class="fixed">
                            <select style="text-align: center" name="age_range">
                                <option>사용 연령</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </td>
                    </tr>
                    <!-- 관련 태그 -->
                    <tr>
                        <td class="fixed">관련 태그</td>
                        <td class="fixed">
                            <textarea name="related_tags1" cols="30" rows="10"></textarea>
                        </td>
                    </tr>
                    <!-- 상품 옵션 -->
                    <tr>
                        <td class="fixed">상품 옵션</td>
                        <td class="fixed">
                            <input type="text" name="goods_option1">
                            <input type="text" name="goods_option2">
                            <input type="text" name="goods_option3">
                            <input type="text" name="goods_option4">
                            <input type="text" name="goods_option5">
                        </td>
                    </tr>
                    <!-- ... 기타 폼 요소들 추가 ... -->
                </tbody>
            </table>
            <div class="clear"></div>
            <br><br><br>
            <div>
	            <label for="goods_image_name1">Image 1:</label>
	            <input type="file" name="goods_image_name1">
	            <div class="file-preview1"></div>
	        </div>
	        <div>
	            <label for="goods_image_name2">Image 2:</label>
	            <input type="file" name="goods_image_name2">
	            <div class="file-preview2"></div>
	        </div>
            <input type="submit" value="상품 등록">
            <div class="clear"></div>
            
        </form>
    </div>
</body>
</html>
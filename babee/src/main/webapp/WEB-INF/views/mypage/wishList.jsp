<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>나의 위시리스트</title>
    <style>
        .wish_list {
            width: 100%;
            margin: 0 auto;
            margin-top: 50px;
            align-items: center;
        }
        

        .wish_list tr {
            border-bottom: 1px solid #ccc;
            padding:10px;
        }


        .goods_img {
		    width: 100px;
		    height: 100px;
		    border-radius: 10px; /* 둥근 경계선 추가 */
		    margin-top: 10px; /* 위쪽 마진 추가 */
		    margin-bottom: 10px; /* 아래쪽 마진 추가 */
		    transition: transform 0.2s;
		}
		span {
		    text-align: center;
		}
		a:hover span {
		    font-weight: bold;
		}
        .goods_img:hover {
            transform: scale(1.1);
        }

        /* '삭제' 버튼 스타일 */
        .delete_button {
            background-color: #ffcd29; /* 배경색 */
            color: black; /* 텍스트색 */
            padding: 8px 12px; /* 내부 여백 */
            border: none; /* 테두리 없음 */
            border-radius: 5px; /* 테두리 반경 */
            cursor: pointer; /* 커서 모양 변경 */
            text-decoration: none;
            transition: background-color 0.2s; /* 호버 효과를 위한 전환 효과 */
        }

        .delete_button:hover {
            background-color: #ffa600; /* 호버 시 배경색 변경 */
            color: #fff;
        }
        
        .wish_list_a { 
		width: 66%;
    	margin: 0 auto;
    	}
        
    </style>
    <script>
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

	 <div class="wish_list_a"  style="margin-left:165px;">
		<H3 style="display:inline-grid;">나의 위시리트스</H3>
		<hr>
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td> 
					<img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               		<p  style="display:inline-block;"> ${memberInfo.member_name} 님 안녕하세요 </p>
				</td>
         	</tr>
      	</table>
		<hr>

    <table class="wish_list" >
        <tr>
            <td width="100px" height="15px;" style="font-weight: bold; border-top:1px solid #ccc; padding:10px;">순번</td>
            <td width="400px" colspan="2" style="text-align: center; padding-right: 30px; font-weight: bold; border-top:1px solid #ccc; ">상품 정보</td>
            <td width="100px" style="font-weight: bold; border-top:1px solid #ccc;">가격</td>
            <td width="100px" style="font-weight: bold; border-top:1px solid #ccc;"></td>
        </tr>

        <c:forEach var="wishVO" items="${myWishList}" varStatus="wishNO">
            <tr>
                <td class="text_center">${wishNO.count}</td>
                <td width="120px">
                
                    <a style="text-decoration: none; color: black" href="${contextPath}/goods/goodsDetail.do?goods_id=${wishVO.goods_id}" >
                       <img
                            src="${contextPath}/thumbnails.do?goods_id=${wishVO.goods_id}&fileName=${wishVO.goods_image_name1}"
                            class="goods_img" /> 
                     </a>
                 </td>
                 	<td>
                       <a style="text-decoration: none; color: black" href="${contextPath}/goods/goodsDetail.do?goods_id=${wishVO.goods_id}" >
                     <span>${wishVO.goods_title}</span></a>
                    </td>
                  <td><fmt:formatNumber value="${wishVO.goods_price}" type="number"  />원</td>
                <td>
                    <a
                        class="delete_button"
                        href="javascript:delete_wishList(${wishVO.articleNO})"
                    >
                        <b><span>삭제</span></b>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<br /><br />
<br /><br />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8" />
<title>나의 리뷰 목록</title>

<style>
      .search-container {
        display: flex;
        align-items: center;
        width: 70%;
      }
      .search-input {
        width: 100px;
        border: 1px solid #d9d9d9;
        text-align: center;
        padding: 5px;
        flex: 3;
        border-radius: 5px;
        margin-left: 5px;
      }
      .search-button {
        border: none;
        background: none;
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

      .faq-content {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 10px;
      }
      .faq-answer {
        margin-top: 10px;
        display: none;
      }
      .faq-table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
      }
      .faq-table th,
      .faq-table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ccc;
        border-right:none;
      }
	.review_list { 
		width: 66%;
    	margin: 0 auto;
    	
    	}
    	
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
    </style>
  </head>
  
<body>
   

	<div class="review_list"  style="margin-left:165px;">
		<H3 style="display:inline-grid;">나의 리뷰</H3>
		<hr style="margin-top:revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td> 
					<img src ="/image/people.png" width="60px;" style="display:inline-block; padding-left:15px;"/>
               		<p  style="display:inline-block;"> ${memberInfo.member_name} 님 안녕하세요 </p>
				</td>
         	</tr>
      	</table>
      	<hr>

 
    	<div id="search" style="width:66%; ">
			<script>
				function reviewSearch() {
					var reviewTitle = $(".search-input").val();

					$.ajax({
						type : 'get',
						url : '${contextPath}/mypage/myReviewList.do',
						data : {
							reviewTitle : reviewTitle
						},

						success : function(result) {
							$('#container').html(result);
						}
					});
				}
			</script>

		<div class="search-container">
			<input class="search-input" type="text" placeholder="상품명을 입력해주세요." />
				<button type="button" name="search" onclick="fn:reviewSearch()"class="search-button">
					<img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom: -5px" />
				</button>
		</div>
	
		</div> 

    <div class="table-container">
      <table class="faq-table" style="width:100%;">
        <thead>
          <tr>
            <th style="width: 200px; border-left:none;">상품명</th>
            <th style="width: 450px">리뷰 내용</th>
            <th style="width: 130px">작성일</th>
            <th style="width: 80px">삭제</th>
          </tr>
        </thead>
        <tbody>
          <script>
              function deleteReview(goods_id, image){
                var formObj = document.createElement("form");
               var i_goods = document.createElement("input");
                 i_goods.name = "goods_id";
                 i_goods.value = goods_id;
                 formObj.appendChild(i_goods);
                 var i_goods_img = document.createElement("input");
                 i_goods_img.name = "goods_img";
                 i_goods_img.value = image;
                formObj.appendChild(i_goods_img);
                document.body.appendChild(formObj);
                formObj.method = "post";
                formObj.action = "${contextPath}/mypage/removeGoodsReview.do";
                formObj.submit();
              }
          </script>
          
          <c:forEach var="faq" items="${review}" varStatus="varSta">
            <tr class="faq-content">
				<td style="border-left:none;">${faq.goodsVO.goods_title}</td>
				<td><a href="#" style="color: black; display: flex; align-items: center" onclick="toggleAnswer('${varSta.count}')">
					<b>${faq.review_title}</b>
					</a>
              	</td>
              	<td>${faq.review_writeDate}</td>
              	<td>
                <button  class="delete_button" onclick="deleteReview('${faq.goods_id}', '${faq.review_img}')">삭제</button>
              	</td>
            </tr>
            
            <tr class="faq-answer${varSta.count}" id="faqAnswer${varSta.count}" style="display: none">
            <script>
                function toggleAnswer(numberId) {
                  var answer = document.getElementById("faqAnswer"+numberId);
                  if (answer.style.display === "none") {
                    answer.style.display = "table-row";
                  } else {
                    answer.style.display = "none";
                  }
                }
              </script>
            <td style="border-left:none;">
                <c:forEach var="star" begin="1" end="${faq.goods_star}">
                    ★
                </c:forEach>
            </td>
            <td>
                <p>${faq.review_content}</p>
            </td>
              <td colspan="2">
               
                <img src="${contextPath}/thumbnails.do?goods_id=${faq.member_id}&fileName=${faq.review_img}&fileType=review" width="200px">
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
                    <c:if test="${section >1 && page==1 }" >
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
                    </c:if>
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${(section-1)*10 +page }"> </a>
                    <c:if test="${page ==10 }">
                    <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next </a>
                    </c:if>
                 </c:forEach>
              </c:when>
              
              <c:when test="${totArticles ==100 }">
                 <c:forEach var="page" begin="1" end="10" step="1">
                 <a class="paging-button"  href="#"> ${page }</a>
                 </c:forEach>
              </c:when>
              
              <c:when test="${totArticles <100 }">
                 <c:forEach var="page" begin="1" end="${totArticles/10 +1 }" step="1">
                    <c:choose>
                       <c:when test="${page==pageNum }">
                       <a class="paging-button" href="${contextPath}/mypage/myReviewList.do?section=${section}&pageNum=${page}">${page }</a>
                       </c:when>
                    <c:otherwise>
                       <a class="paging-button"  href="${contextPath}/mypage/myReviewList.do?section=${section}&pageNum=${page}">${page }</a>
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

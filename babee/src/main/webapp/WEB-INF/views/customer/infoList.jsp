<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>공지사항</title>
<style>
   
    #search {
        background-color: #FEF7DD;
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
        width: 70%;/* 검색 입력 영역이 늘어나도록 설정 */
    }
    .search-input {
        border: 1px solid #FFA500;
        text-align: center;
        padding: 5px;
        flex: 3; /* Make the text box wider */
        border-radius: 5px;
        margin-left: 20px;
        width: 400px;
         height: 30px;
         margin-left:100px;
    }
    .search-button {
        border: none;
        background: none;
        margin-top: -10px;
    }
    .menu-container {
            text-align: center; /* 가운데 정렬 */
            margin-top: 50px; /* 여기서 100px 만큼 아래로 이동합니다. */
        }

        .menu-options {
            display: flex; /* 옆으로 정렬 */
            gap: 100px; /* 사이 간격 */
            align-items: flex-end; /* 메뉴와 아래 정렬 요소 정렬 */
            justify-content: center; /* 가운데 정렬 */
        }

        .menu-option {
            font-weight: normal;
            text-decoration: none;
            color: #333;
        }

        /* 선택 시 스타일 */
        .menu-option:hover {
            font-weight: bold;
            text-decoration: underline;
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

        .menu-container >hr, #foreachhr {
          margin:  1rem 25%;
         color: inherit;
        border: 0;
           border-top: var(--bs-border-width) solid;
         opacity: .25;
}
</style>
</head>
<body>
    <br><br><br>
<div id="search">
    <h2 style="margin-top:10px;">공지사항</h2>
    <div class="search-container">
    <form action="검색결과를_처리할_페이지_주소" method="GET"><!-- form 엘리먼트 추가 -->
        <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
        <button type="submit" name="search" class="search-button">
            <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px; margin-bottom:5px;">
        </button>
    </form>
	</div>
</div>


<script>
    function toggleAnswer(numberId) {
      var answer = document.getElementById("faqAnswer"+numberId);
      if (answer.style.display == "none") {
        answer.style.display = "block";
        
      } else {
        answer.style.display = "none";
      }
    }


    function myList(number) {
      var answer1 = document.getElementById("jajuList1");   
      var answer2 = document.getElementById("jajuList2");   
        if(number==1){
                answer1.style.display="block";
                answer2.style.display="none" ;
         }else{
                answer2.style.display="block";
                answer1.style.display="none";
            }

        }
      

        function loginQuestion(){

        var isLogOn = '${isLogOn}';
        if(isLogOn=='true'){
         location.replace("${contextPath}/community/questionForm.do");
          
        }else{
            alert("로그인 이후 이용 가능한 서비스입니다.");
            location.replace("${contextPath}/member/loginForm.do")
        }
        }

  </script>
	<c:forEach var = "infoboard" items="${infoboard}" varStatus="cnt">
    <div style="text-align: center; display: block;" id="jajuList1">
    		<div style="text-align: center;">
     
     <br>

				<div style="display: flex; margin-left: 33%;">
					<p style="margin-left: 25px;">
						<img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;"> <a href="#"
							onclick="toggleAnswer('${cnt.count}')">🛍️ [babee] ${infoboard.info_title } 🛍️</a>
					</p>
				</div>
				<div id="faqAnswer${cnt.count}" width: "700px;"
					style="display: flex; text-align: left; margin-left: 33%; display: none;">
					  <img src="${contextPath}/thumbnails.do?goods_id=${infoboard.member_id}&fileName=${infoboard.info_img}&fileType=info&articleNO=${infoboard.articleNO}" width="400px" id="preview" style="widht:350px; height: 400px;">
					<p style="width: 700px;">${infoboard.info_content}</p>
				</div>


			</div>
    			<hr width="50%" id="foreachhr">
     </div>
     </c:forEach>

    <br>
    
          <div class="paging-container">
   <c:if test="${totArticles !=null}">
      <c:choose>
         <c:when test="${totArticles > 100 }"> 
            <c:forEach var="page" begin="1" end="10" step="1">
               <c:if test="${section >1 && page==1 }" >
                  <a class="paging-button"  href="${contextPath}/community/infoList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
               </c:if>
                  <a class="paging-button"  href="${contextPath}/community/infoList.do?section=${section-1}&pageNum=${(section-1)*10 +page }"> </a>
               <c:if test="${page ==10 }">
               <a class="paging-button"  href="${contextPath}/community/infoList.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next </a>
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
                  <a class="paging-button" href="${contextPath}/community/infoList.do?section=${section}&pageNum=${page}">${page }</a>
                  </c:when>
               <c:otherwise>
                  <a class="paging-button"  href="${contextPath}/community/infoList.do?section=${section}&pageNum=${page}">${page }</a>
               </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:when>
      </c:choose>
   </c:if>
            
</div>
    <br><br>

</body>
</html>
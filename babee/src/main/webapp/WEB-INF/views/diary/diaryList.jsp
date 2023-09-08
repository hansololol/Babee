<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>다어이리 목롱창</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>

<style>
.text_center{ 
   text-align:center;
   }

/* '다이어리 작성' 버튼 스타일 */
input[type="button"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '다이어리 주문' 버튼 스타일 */
button[type="button"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
input[type="button"]:hover, button[type="button"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

/*주문 버튼 수정필요 */
input[type="reset"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}

.diary_list {
	display: inline-block;
    margin: 10px;
    padding: 20px 30px;
    width: 300px;
    border: 1px solid lightgray;
    border-radius: 7px;
    background: #f9f7f0;
}

.diary_list ul {
    list-style: none;
    padding: 0;
}

/* .diary_list li {
    margin-bottom: 5px;
} */

.diary_list li.checkbox{
    text-align: left;
}


.diary_list li img{
    width: 230px;
    height: 200px;
    margin-bottom: 10px;
    border-radius: 7px;
}
.diary_list a{
    color: black;
    text-decoration: none;
}
.ellipsis {
   width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  margin: 10px auto;
}

.ellipsis2 {
   width: 200px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  margin: 10px auto;
}
 
 
 .tooltip-button {
    position: relative;
    background-color: #ffcd29;
    color: black;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.tooltip-button::before {
    content: "10장 이상부터 주문 가능합니다.";
    position: absolute;
    top: -60px;
    left: 50%;
    transform: translateX(-50%);
    background-color: #333;
    color: white;
     width: 250px; /* 가로 크기를 늘림 */
    padding: 5px 10px;
    border-radius: 5px;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s, top 0.3s;
}

.tooltip-button:hover {
    background-color: #cca300;
}

.tooltip-button:hover::before {
    opacity: 1;
    top: -60px;
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
 
</style>
</head>
<body>



   <div style="text-align: center;">
      <h1 class="text_center">다이어리</h1>
      <h4 class="text_center" style="color:#996633;">작은 발자국, 큰 사랑의 다이어리</h4>
      <img src="/image/line.png" style="margin: 0 auto; display: block;" alt="줄 출력">
   </div>

<br>


<form method="post" action="${contextPath}/diary/diaryOrder.do" enctype="multipart/form-data">
   <div style="text-align: center;">
         <a href="${contextPath}/diary/diaryForm.do"><input type="button" value="다이어리 작성"></a>&nbsp;&nbsp;&nbsp;
  		 <button type="button" class="tooltip-button" id ="orderButton" onclick="fn:order()">다이어리 주문</button>
        <br>
         <p style="display:none" id="introdu">다이어리 이미지 클릭 시 선택 가능합니다</p>
	</div>
   
   <script>
     var orderButton= document.getElementById("orderButton");
    function order(){
        if(orderButton.disabled==false){
        orderButton.disabled=true;
        orderButton.style.backgroundColor="#ffcccc";
        $("#introdu").css("display","block");
        }
        }


   </script>
  
   <div style= "padding: 0 15%;" >
		<c:forEach var="diary" items="${diary}" varStatus = "dir">
			<div class="diary_list" id="dirList${diary.dir_no}" onclick="findDir('${diary.dir_no}')">
			<ul>
            <li style="text-align: left;"> </li>
  
            <script>
                var array = new Array();
                function findDir(index){
        
                    if(orderButton.disabled == true){
                $("#dirhref"+index).removeAttr('href');
                $("#dirList"+index).on("click").css("border", "5px solid #ffcccc").css('border-radius', '25px');  
                    }
                $("#selecdir"+index).each(function(i, obj) {
                    array.push(obj.name);
                });

                if(array.length>10){
               
                 $.ajax({
		            type:'post',
	            	url: '${contextPath}/order/orderDir.do',
                    data : {array : array},
                      
                    success: function(result){

                        if(confirm("선택이 완료되었습니다. 주문창으로 이동하시겠습니까?")){
                        location.replace("${contextPath}/goods/orderGoodsForm.do");
                    }else{
                        alert("주문에 실패하였습니다. 다시 선택해주세요.");
                        location.reload;
                    }
                        }
                    });
                        }
                                }

            </script>
            
            <a href="${contextPath}/diary/diaryDetail.do?dir_no=${diary.dir_no}" id="dirhref${diary.dir_no}">
                <li><img src="${contextPath}/thumbnails.do?goods_id=${diary.member_id}&fileName=${diary.dir_main_img}&fileType=diary&dir_no=${diary.dir_no}" width="100px"> </li>
               
               <div class="ellipsis2">
               <li style="font-weight: bold;">${diary.dir_title}</li></div>
                <div class="ellipsis">
                	 
                    <li style=" height: 48px;">${diary.dir_content}</li></div>
                   <input type="hidden" id="selecdir${diary.dir_no}" name="${diary.dir_no}" value="${diary.dir_no}">
                <li style="text-align: right; font-size: 12px;">${diary.dir_writeDate}</li>
            </a>
         </ul>
      </div>
   </c:forEach> 
   </div>
   
   <div class="paging-container">
      <c:if test="${totArticles !=null}">
        <c:choose>
          <c:when test="${totArticles > 100 }">
            <c:forEach var="page" begin="1" end="10" step="1">
              <c:if test="${section >1 && page==1 }">
                <a class="paging-button" href="${contextPath}/diary/diaryList.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre</a>
              </c:if>
              <a class="paging-button" href="${contextPath}/diary/diaryList.do?section=${section-1}&pageNum=${(section-1)*10 +page }"></a>
              <c:if test="${page ==10 }">
                <a class="paging-button" href="${contextPath}/diary/diaryList.do?section=${section-1}&pageNum=${section*10 +1 }">&nbsp; next</a>
              </c:if>
            </c:forEach>
          </c:when>

          <c:when test="${totArticles ==100 }">
            <c:forEach var="page" begin="1" end="10" step="1">
              <a class="paging-button" href="#"> ${page }</a>
            </c:forEach>
          </c:when>

          <c:when test="${totArticles <100 }">
            <c:forEach var="page" begin="1" end="${totArticles/10 +1 }" step="1">
              <c:choose>
                <c:when test="${page==pageNum }">
                  <a class="paging-button" href="${contextPath}/diary/diaryList.do?section=${section}&pageNum=${page}">${page }</a>
                </c:when>
                <c:otherwise>
                  <a class="paging-button" href="${contextPath}/diary/diaryList.do?section=${section}&pageNum=${page}">${page }</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </c:when>
        </c:choose>
      </c:if>
    </div>       
</form>

<br><br><br>

</body>
</html>
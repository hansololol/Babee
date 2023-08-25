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
    <h2 style=>공지사항</h2>
    <div class="search-container">
    <form action="검색결과를_처리할_페이지_주소" method="GET"><!-- form 엘리먼트 추가 -->
        <input name="searchWord" class="search-input" type="text" placeholder="검색어를 입력해주세요.">
        <button type="submit" name="search" class="search-button">
            <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px;">
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
	
    <div style="text-align: center; display: block;" id="jajuList1">
    <div style="text-align: center;">
     
     <br>
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(1)">🛍️ [babee] 공지사항 - 환영합니다!!! 🛍️</a>
            </p>
        </div>
        <div id="faqAnswer1"
        style="display: flex;text-align: left; margin-left: 33%;  display: none;">
        
        <p >안녕하세요 babee입니다!  <br>
        소중한 고객 여러분 babbe에 오신 것을 환영합니다.  <br>
        저희 babee에서는 다양한 상품과 혜택을 제공하고 있습니다.  <br>
        회원가입 후 babee의 여러 서비스를 이용해 보시길 바랍니다.  <br> <br>
        
        항상 발전하는 babee가 되겠습니다.  <br>
        감사합니다.
        </p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(2)">🛍️ [babee] 공지사항 - 2023년 8월 업데이트 🛍️</a>
            </p>
        </div>
        <div id="faqAnswer2"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p>안녕하세요, babbe입니다!  <br>소중한 고객 여러분을 위해 새로운 소식과 업데이트를 안내해 드립니다. <br>
        <br> <strong>신상품 입고 소식</strong>
        <br> 이번 주에는 다양한 신상품이 입고되었습니다. 여름을 더욱 특별하게 <br>만들어줄 새로운 의류와 액세서리를 만나보세요.
         편안한 착용감과  <br>세련된 디자인으로 여름 스타일을 완성해보세요!</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">
    
    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(3)">🛍️ [babee] 공지사항 - 2023년 7월 업데이트 🛍️</a>
            </p>
        </div>
        <div id="faqAnswer3"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p>안녕하세요, babbe입니다!  <br>소중한 고객 여러분을 위해 새로운 소식과 업데이트를 안내해 드립니다. <br>
        <br> <strong>신상품 입고 소식</strong>
        <br> 이번 주에는 다양한 신상품이 입고되었습니다. 여름을 더욱 특별하게 <br>만들어줄 새로운 의류와 액세서리를 만나보세요.
         편안한 착용감과  <br>세련된 디자인으로 여름 스타일을 완성해보세요!</p>
     </div>
    </div>

    <br><br><br>
    
</div>
</body>
</html>
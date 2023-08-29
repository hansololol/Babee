<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
<title>고객센터</title>
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
    <h2 style=>고객센터</h2>
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

<div class="menu-container">
        <div class="menu-options">
            <div class="menu-option" id="faq">
                <a href="#" style="color: black;" onclick="myList(1)">자주묻는질문</a>
            </div>
            <div class="menu-option" id="contact">
                <a href="javascript:loginQuestion()" style="color: black;" id="question">문의하기</a>
            </div>
            <div class="menu-option" id="history">
                <a href="#" style="color: black;" onclick="myList(2)">문의내역</a>
            </div>
        </div>
        <hr width="50%">
    </div>

    <div style="text-align: center; display: block;" id="jajuList1">
    <div style="text-align: center;">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(1)">[배송질문][🚚 상품 배송일 알고싶어요]</a>
            </p>
        </div>
        <div id="faqAnswer1"
        style="display: flex;text-align: left; margin-left: 33%;  display: none;">
        
        <p >주문 완료 이후 영엽일 기준 1일 이내 출고됩니다. 배송 업체에 따라 배송일은 2~3일정도 소요될 수 있습니다.</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(2)">[주문질문][👕 주문을  취소하고 싶어요]</a>
            </p>
        </div>
        <div id="faqAnswer2"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p>주문취소는 마이페이지 - 주문내역 상세창에서 가능합니다. <br> 배송 준비중일 경우 취소 가능하며, 배송이 시작된 이후 취소가 불가능합니다.</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    
    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(3)">[주문질문][💰︎ 취소 완료 후 환불은 언제 되나요?]</a>
            </p>
        </div>
        <div id="faqAnswer3"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p style="margin-right: 40%;"><b>결제수단에 따라 상이합니다.</b> <br>무통장입금 : 스마일캐시 환불 선택 시 취소 완료 즉시 재 적립 / 내 계좌로 환불 시 취소 완료일 +1일(영업일 기준) 소요, 신용/체크카드 : 3~5일(영업일 기준) <br> 체크카드는 승인 취소 후 해당 계좌로 입금 됩니다. <br>확인 후에도 해결에 어려움이 있으시다면 고객센터(1566-5701)로 문의하시면 도와드리겠습니다.</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(6)">[주문질문][💰︎ 반품 시 배송비 부담은 어떻게 되나요?]</a>
            </p>
        </div>
        <div id="faqAnswer6"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p style="margin-right: 40%;"><b>반품 신청 과정에서 3가지 방법 중 1개를 선택하여 결제할 수 있습니다. (원인 제공자가 왕복 배송비 부담)</b> <br>

               <b> ※ 반품 배송비 결제 방법 (3가지)</b><br>
                        
            지금 결제함 : 환불금액에서 차감 또는 스마일캐시 중 택 1, 빠른 환불 처리를 위해 권장하는 방법<br>
            상품에 동봉함 : 상품 포장 시 현금을 동봉하는 방법, 분실 위험이 있어 권장하지 않음<br>
            판매자에게 직접 결제 : 판매자에게 반품 배송비 직접 송금, 반품 요청 전 판매자와 협의 필요<br>
            <b>※ 반품 배송비 구매자 부담 안내</b><br>
            구매자의 책임 있는 사유로 인하여 반품/교환이 진행되는 모든 경우(단순 변심 / 연락처 오기재, 주소지 오류, 부재, 연락두절 등 수취인의 사정으로 반송된 경우)<br>
            <b> ※ 반품 배송비 판매자 부담 안내</b><br>
            판매자의 책임 있는 사유로 반품/교환이 진행되는 모든 경우 (상품 제목 및 상세페이지 내 표시·광고된 내용과 다른 상품이 배송된 경우, 상품이 파손되어 배송된 경우)<br>
                        </p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(4)">[홈페이지][🗝︎ 로그인에 문제가 있어요.]</a>
            </p>
        </div>
        <div id="faqAnswer4"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p style="margin-right: 40%;"><b>로그인이 되지 않는 경우는 다음 사항을 확인하시기 바랍니다.</b><br> 아이디 비밀번호 확인 로그인이 안 될 경우에는 “로그인” 페이지에 있는 아이디 찾기 또는 비밀번호 찾기에서 아이디와 비밀번호를 확인하여 주십시오.<br> 아이디, 비밀번호가 일치하지만 로그인이 되지 않을 경우에는 PC에서 웹브라우저의 확인사항을 체크해 주십시오.</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">

    <div style="text-align: center; ">
        <div style="display: flex; margin-left: 33%;">
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer(5)">[홈페이지][🗑︎ 리뷰를 삭제하고 싶어요.]</a>
            </p>
        </div>
        <div id="faqAnswer5"
        style="display: flex; text-align: left; margin-left: 33%; display: none;">
        
        <p style="margin-right: 40%;">마이페이지 - 리뷰 관리 창에서 리뷰에 대한 정보를 확인하고, 삭제 가능합니다.</p>
     </div>
    </div>
    <hr width="50%" id="foreachhr">
</div>


<div style="text-align: center; display: none;" id="jajuList2">
   
    <c:forEach var="myfnq" items="${qnaList}" varStatus="cnt">
   	 
    <div style="text-align: center;">
        <div style="display: flex; margin-left: 33%;">
         <c:choose>
            		<c:when test="${myfnq.qna_answer != null}">
                	
                   	완료
                    
                    </c:when>
                    <c:when test="${myfnq.qna_answer == null}">
                	
                   	대기
                    
                    </c:when>
                    </c:choose>
                    
            <p style="margin-left: 25px;" >
                <img src="/image/glass.png" alt="FAQ" style="width: 20px; height: 20px;">
                <a href="#"  onclick="toggleAnswer('${7 + cnt.count}')">${myfnq.qna_title}</a>
            </p>
        </div>
        <div id="faqAnswer${7 + cnt.count}" style="display: flex;text-align: left; margin-left: 33%;  display: none;">
        <p>	${myfnq.qna_content} </p>
        <p>	답변 : ${myfnq.qna_answer} </p>
   		</div>
    </div>
    <hr width="50%" id="foreachhr">
</c:forEach>


    
    <br><br><br><br><br>
</body>
</html>
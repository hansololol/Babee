<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"   isELIgnored="false"
   %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
   <style>
      #search input.main_input::placeholder {
         font-size: 8px;
      }
   
      .my_img_container {
         position: relative;
         display: inline-block;
         margin: 0 5px;
         margin-left: 35px;
         z-index:2;
      }
   
      .my_img {
         border-radius: 20%;
         width: 287px;
    height: 342px;
         transition: filter 0.3s;
      }
      .my_img2{
         transition: filter 0.3s;
         border-radius: 9%;
      }
   
      .my_img_container:hover .my_img {
         filter: brightness(0.4);
      }
      .my_img2_container:hover .my_img2{
         filter: brightness(0.4);
      }
   
      .img_text {
         position: absolute;
         top: 0; /* 위치를 이미지 위로 조정 */
         left: 0;
         width: 100%;
         
         color: #fff;
         padding: 5px 10px;
         font-size: 14px;
         font-weight: bold;
         opacity: 0;
         transform: translateY(-100%); /* 위로 이동하도록 변경 */
         transition: transform 0.3s, opacity 0.3s;
      }
   
      .my_img_container:hover .img_text {
         opacity: 1;
         transform: translateY(0);
      }
      .gray_bg {
         background-color: #f0f0f0; /* 회색 배경색을 설정하세요 */
        padding: 24px 125px;
             margin: 0px 18%;
         border-radius: 2%;
		height:850px;
      }
      .w-100{
         padding:30px 180px 0 180px;
      background-color:#FEF7DD;
      }
      
   </style>
   </head>
<div id="carouselExampleIndicators" class="carousel slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/image/main_banner01.png" class="d-block w-100" height="500px" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/image/banner2.png" class="d-block w-100" height="500px">
    </div>
    <div class="carousel-item">
      <img src="/image/main_banner01.png" class="d-block w-100" height="500px">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<br>
<div id="search" align="center">
    <form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
        <div style="display: flex; align-items: center; justify-content: center;">
            <input name="searchWord" class="main_input" type="text" onKeyUp="keywordSearch()" style="border: none; border-bottom: 1px solid #000; outline: none;  text-align: center; width:350px; margin-top:20px; font-size: 20px;" placeholder="검색어를 입력해주세요.">
            <button type="submit" name="search" class="btn1" style="border: none; background: none;">
                <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px;">
            </button>
        </div>
    </form>
</div>
<br>
<div id="popular-products" style="display: flex; flex-direction: column; align-items: left;">
    <hr style="border: none; border-top: 2px solid #000; width: 70px; margin: 10px 0; margin-left: 20%;">
    <div style="display: flex; flex-direction: row; align-items: flex-start; margin: auto;">
        <span style="font-size: 14px; font-weight: 300; margin: -5px 5px;">
    실시간 <br>인기상품
   </span>


        <div class="my_img_container">
            <a href="${contextPath}/goods/goodsDetail.do?goods_id=1">
                <img src="/image/shopping1.jpg" class="my_img">
                <div class="img_text">우리 아이 안심 물병</div>
            </a>
        </div>
        <div class="my_img_container">
            <a href="#2">
                <img src="/image/shopping2.jpg" class="my_img" >
                <div class="img_text">여름 쿨 아동 의류 2</div>
            </a>
        </div>
        <div class="my_img_container">
            <a href="#3">
                <img src="/image/shopping3.jpg" class="my_img">
                <div class="img_text">귀여운 동물 양말</div>
            </a>
        </div>
        <div class="my_img_container">
          <a href="${contextPath}/goods/goodsList.do"><img src="/image/rightButton.png" width="30px" height="50px" style="margin-top: 500%; cursor: pointer;"></a>
        </div>
    </div>
    
     <br>  <br>  
     <div >
	<img src="/image/lineBanner.jpg" style="height: 268px;">
	</div>
	  <br>
	    <br>  <br>  
<div class="gray_bg">
 <br>  
        <h1 align=center>시즌오프 세일 ~70%</h1>
        <h2 align=center>보다 저렴하게 구매가능한 시즌오프 세일 모음</h2>
        <br><br> 
      <div class="my_img2_container" style="border-radius: 50%; float: left;">
            <a href="#">
                <img src="/image/sale3.jpg" alt="sale4" class="my_img2" width="300px" height="500px">
                <div class="img_text">sale4</div>
            </a>
        </div>
      <div  style="border-radius: 50%; float: left;">
      <div class="my_img2_container" style="border-radius: 50%; ">
            <a href="#">
                <img src="/image/sale1.jpg" alt="sale1" class="my_img2" width="250px" height="250px">
                <div class="img_text">sale1</div>
            </a>
        </div>
        <div class="my_img2_container" style="border-radius: 50%; display: inline; margin-left: 20px; ">
            <a href="#">
                <img src="/image/sale2.jpg" alt="sale2" class="my_img2" width="250px" height="250px">
                <div class="img_text">sale2</div>
            </a>
        </div>
   </div>
        <div class="my_img2_container" style="border-radius: 50%; margin-left: 20px; float: left;">
            <a href="#">
                <img src="/image/sale5.png" alt="sale5" class="my_img2" width="300px" height="500px">
                <div class="img_text">sale5</div>
            </a>
        </div>
        <br><br>
</div>
</div>
  <br>  <br>  <br>
</body>
</html>
   
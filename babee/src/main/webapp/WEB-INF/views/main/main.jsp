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
  <script>
  
  var alertMember = '${alertMember}';
   
   
   console.log(alertMember + "탈퇴 여부 확인")
   if(alertMember=='success'){
    alert("탈퇴성공");
   }else if(alertMember=='fail'){
    alert("탈퇴실패")
   }

  </script>
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
         display: flex;
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
<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
	  <a href="${contextPath}/goods/goodsDetail.do?goods_id=28&fileName=화면 캡처 2023-08-23 143147.png"  width="30px" height="50px" style="margin-top: 500%; cursor: pointer;">
      <img src="/image/main_banner01.png" class="d-block w-100" height="500px" alt="...">
    </a>
    </div>
    <div class="carousel-item">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=29&fileName=화면 캡처 2023-08-23 154819.png"  width="30px" height="50px" style="margin-top: 500%; cursor: pointer;">
      <img src="/image/main_banner02.png" class="d-block w-100" height="500px">
      </a>
    </div>
    <div class="carousel-item">
      <a href="${contextPath}/goods/goodsDetail.do?goods_id=30&fileName=화면 캡처 2023-08-23 154819.png"  width="30px" height="50px" style="margin-top: 500%; cursor: pointer;">
      <img src="/image/main_banner03.png" class="d-block w-100" height="500px">
      </a>
    </div>
  </div>
 
 
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<br>
<div id="search" align="center">
    <form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
        <div style="display: flex; align-items: center; justify-content: center;">
            <input name="searchWord" class="main_input" type="text" onKeyUp="keywordSearch()" style="border: none; border-bottom: 1px solid #000; outline: none;  text-align: center; width:350px; margin-top:20px; font-size: 20px;" placeholder="검색어를 입력해주세요.">
            <button type="submit" class="btn1" style="border: none; background: none;">
                <img src="/image/glass.png" alt="검색" style="width: 20px; height: 20px;">
            </button>
        </div>
    </form>
</div>
<br>
<div id="popular-products" style="display: flex; flex-direction: column; align-items: left;">
   
    <div style="display: flex; flex-direction: row; align-items: flex-start; margin: auto;">
        <span style="font-size: 14px; font-weight: 300; margin: -5px 5px; ">
    실시간 <br>인기상품
   </span>


		<c:forEach var="goods" items="${hotGoodsList}">
			<div class="my_img_container">
				<ul>
					<li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"  width="30px" height="50px" style="margin-top: 500%; cursor: pointer;">
						<img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}"  class="my_img"> 
						</a>
					</li>
					<div class="img_text">${goods.goods_title}</div>
				</ul>
			</div>
		</c:forEach>
		
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
<div class="gray_bg"  style="padding:0px; width:1100px; height:1200px; margin:auto;">
 <br>  
        <h1 align=center>시즌오프 세일 ~70%</h1>
        <h2 align=center>보다 저렴하게 구매가능한 시즌오프 세일 모음</h2>
        <br><br>
		
		
<c:forEach var="goods" items="${seosonList}" varStatus="loopStatus">
    <div class="my_img_container" style="border-radius: 50%; float: left;">
        <a href="${contextPath}/goods/goodsDetail.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}">
            <img src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_image_name1}" style="margin-right:30px; margin-bottom:10px;" class="my_img"
                <c:if test="${loopStatus.index == 0}">
                    width="300px" height="500px"
                </c:if>
                <c:if test="${loopStatus.index != 0}">
                    width="250px" height="250px"
                </c:if>
            />
        </a>
        <div class="img_text">${goods.goods_title}</div>
    </div>
</c:forEach>
       
        <br><br>
</div>
</div>
  <br>  <br>  <br>
</body>
</html>
   
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/detail.css" />
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

.btn-primary {
    --bs-btn-color: #000;
    --bs-btn-bg: #ffffff;
    --bs-btn-border-color: #ffffff;
    --bs-btn-hover-color: #fff;
    --bs-btn-hover-bg: #ededed;
    --bs-btn-hover-border-color: #ffffff;
    --bs-btn-focus-shadow-rgb: 49,132,253;
    --bs-btn-active-color: #fff;
    --bs-btn-active-bg: #c9c9c9;
    --bs-btn-active-border-color: #ffffff;
    --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
    --bs-btn-disabled-color: #fff;
    width: 800px;
    text-align: left;
}

.card {
    --bs-card-spacer-y: 1rem;
    --bs-card-spacer-x: 1rem;
    --bs-card-title-spacer-y: 0.5rem;
    --bs-card-title-color: ;
    --bs-card-subtitle-color: ;
    --bs-card-border-width: var(--bs-border-width);
    
    --bs-card-border-radius: var(--bs-border-radius);
    --bs-card-box-shadow: ;
    --bs-card-inner-border-radius: calc(var(--bs-border-radius) - (var(--bs-border-width)));
    --bs-card-cap-padding-y: 0.5rem;
    --bs-card-cap-padding-x: 1rem;
    --bs-card-cap-bg: rgba(var(--bs-body-color-rgb), 0.03);
    --bs-card-cap-color: ;
    --bs-card-height: ;
    --bs-card-color: ;
    --bs-card-bg: var(--bs-body-bg);
    --bs-card-img-overlay-padding: 1rem;
    --bs-card-group-margin: 0.75rem;
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    height: var(--bs-card-height);
    color: var(--bs-body-color);
    word-wrap: break-word;
    background-color: var(--bs-card-bg);
    background-clip: border-box;
    border-radius: var(--bs-card-border-radius);
    margin: 0 27%;
    text-align: left;
}

.btn_add_wish, .btn_add_wish:hover {
    width: 62px;
	
    border: 1px solid #eaeaea;
    font-size: 0;
	cursor: pointer;
}

.btn_add_wish {
    height: 62px;
    line-height: 60px;
    margin: 0;
	border-radius: 5px;
}
.btn_add_wish span {
	background: url("/image/btn_add_wish.png") no-repeat center;
    
	display: block;
    width: 100%;
    height: 100%;
	
}

.board_comment + .board_comment {
    margin-top: 58px;
}
.board_comment {
    clear: both;
    position: relative;
    padding-top: 15px;
    width: 860px;
  
}

.board_comment .tb_comment_common td {
    height: 95px;
    padding-top: 0;
    padding-bottom: 0;
}
.board_comment .tb_comment td {
    padding-top: 22px;
    padding-bottom: 22px;
    vertical-align: middle;
    border-bottom: 1px solid #ececec;
}
.board_comment .comment-grade {
    text-align: center;
    font-size: 0;
}
.board_comment .tb_comment .comment-content {
    padding-left: 4px;
    padding-right: 40px;
    font-size: 14px;
    line-height: 18px;
    color: #000;
}

.board_comment .tb_comment_common td {
    height: 95px;
    padding-top: 0;
    padding-bottom: 0;
}
.board_comment .tb_comment td {
    padding-top: 22px;
    padding-bottom: 22px;
    vertical-align: middle;
    border-bottom: 1px solid #ececec;
}
</style>

	
</head>
<body>
	<br><br>
	<hgroup>
		<h1>${goodsVO.goods_title}</h1>
		<h6>${goodsVO.main_category} &gt; ${goodsVO.middle_category} &gt; ${goodsVO.sub_category}</h6>
	
	</hgroup>

	<br><br>
	<div id="goods_image">
		<figure>
			<img src="${contextPath}/thumbnails.do?goods_id=${goodsVO.goods_id}&fileName=${goodsVO.goods_image_name1}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span >
					  
				         ${goodsVO.goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goodsVO.goods_price*0.9}" type="number" var="discounted_price" />
				         원(10%할인)</span></td>
				</tr>
				
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">
			      <select style="width: 400px; text-align: center;" id="order_goods_qty">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
			     </select>
					 </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">옵션</td>
					<td class="fixed">
						<select style="width: 400px;  text-align: center" id="order_goods_qty">

							<option>${goodsVO.goods_option1}</option>
							<option>${goodsVO.goods_option2}</option>
							<option>${goodsVO.goods_option3}</option>
							<option>${goodsVO.goods_option4}</option>
							<option>${goodsVO.goods_option5}</option>
		
					   </select>
						   </td>
				</tr>
				
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>${goodsVO.goods_delivery_price}</strong></td>
				</tr>
				
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				
			</tbody>
		</table>
		<ul>
			<li><a class="buy" href="${contextPath}/goods/orderGoodsForm.do">구매하기 </a></li>
			<li><a class="cart" href="javascript:add_cart('${goods.goods_id }')">장바구니</a></li>
			
			<li><button type="button" id="wishBtn" class="btn_add_wish"><span>찜하기</span></button></li>
		</ul>
	</div>

	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<br><br><br>
	
	
		<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">상품상세</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">상품리뷰</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">상품문의</button>
  </li>
	</ul>
	
	<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0"><br><br><img src="/image/detail01.jpg"></div>
	 
	  <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0" style="margin-left: 27%;">
		
			<table class="tb_comment tb_comment_common">
	
	<caption>상품평 등급, 상품평내용 , 작성자, 등록일, 조회수에 관한 테이블</caption>
				
				
	<colgroup>
		<col style="width:300px">
		<col>
		<col style="width:400px">
			
	</colgroup>
	<c:forEach var="i" begin="1" end="5">
	<tbody>
					
			<tr>
				<td class="comment-grade">
				<span class="rec rec_a"><img alt="" src="/image/baby.jpg" width="100px"></span>
				</td>
				<td class="comment-content">
				<p class="pd-tit">E4 다크베이지;10.100L[1개]</p>
				<p class="con">배송이 빨라요 디자인이 이뻐요</p>
				</td>

				<td class="info">
				<dl class="writer-info">
				<dt>작성자 :</dt>
				<dd>k#0*******</dd>
				<dt>등록일 :</dt>
				<dd>2023.08.10</dd>
				</dl>
				</td>		
				</tr>
					<tr><td style="colspan:3"><hr></td></tr>
					
	</tbody>
	</c:forEach>
</table>
	</div>

  <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0" style="margin-left: 27%;">
	  <table class="tb_comment tb_comment_common">
	
	<caption>상품 문의 테이블</caption>
				
				
	<colgroup>
		<col style="width:300px">
		<col>
		<col style="width:400px">
			
			
	</colgroup>
	<c:forEach var="i" begin="1" end="5">
	<tbody>
					
			<tr>
				<td class="comment-grade">
				<span class="rec rec_a"><img alt="" src="/image/baby.jpg" width="100px"></span>
				</td>
				<td class="comment-content">
				<p class="pd-tit">E4 다크베이지;10.100L[1개]</p>
				<p class="con">배송이 안와요</p>
				</td>

				<td class="info">
				<dl class="writer-info">
				<dt>작성자 :</dt>
				<dd>k#0*******</dd>
				<dt>등록일 :</dt>
				<dd>2023.08.10</dd>
				</dl>
				</td>		
				</tr>
					<tr><td style="colspan:3"><hr></td></tr>
					
	</tbody>
	</c:forEach>
</table>
	  
	</div>
	</div>

	
	</body>


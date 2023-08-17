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
<script type="text/javascript">
	function add_cart(goods_id) {
		   var cart_goods_qty=document.getElementById("order_goods_qty").value;	
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_id:goods_id,
				cart_goods_qty:cart_goods_qty
			},
			success : function(data, textStatus) {
				//alert(data);
			//	$('#message').append(data);
				if(data.trim()=='add_success'){
					imagePopup('open', '.layer01');	
				}else if(data.trim()=='already_existed'){
					alert("이미 카트에 등록된 상품입니다.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("로그인 후 이용 가능합니다.");
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	
function fn_order_each_goods(goods_id,goods_title,goods_price,fileName){
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
	
		var total_price,final_total_price;
		var order_goods_qty=document.getElementById("order_goods_qty");
		
		var formObj=document.createElement("form");
		var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_image_name1";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=order_goods_qty.value;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}	


</script>
</head>
<body>
	<br><br>
	<hgroup>
		<h1>우리아이 안심물병</h1>
		<h6>대분류 &gt; 중분류 &gt; 소분류</h6>
		<h3>${goods.goods_title}</h3>
	</hgroup>

	<br><br>
	<div id="goods_image">
		<figure>
			<img src="${contextPath}/thumbnails.do?goods_id=1&fileName=1.png">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goods.goods_price}" type="number" var="goods_price" />
				         ${goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goods.goods_price*0.9}" type="number" var="discounted_price" />
				         ${discounted_price}원(10%할인)</span></td>
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
							<option>1</option>
								  <option>2</option>
								  <option>3</option>
								  <option>4</option>
								  <option>5</option>
					   </select>
						   </td>
				</tr>
				
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>배송비 적기</strong></td>
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


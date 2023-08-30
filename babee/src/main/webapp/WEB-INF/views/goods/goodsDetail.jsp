<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />


<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/detail.css" />


<script type="text/javascript">

function add_cart(goods_id){
   
   var cart_goods_qty = document.getElementById("order_goods_qty").value;   // 상품 갯수
   var goods_option = document.getElementById("goods_option").value;      // 상품 옵션
   let data = {
         goods_id : goods_id,
         cart_goods_qty : cart_goods_qty,
         goods_option : goods_option
         };
   
   let memberId = $('#isLogOnMember').val();								// 로그인 된 ID
	let sellerId = $('#isLogOnSeller').val();	                      // 로그인 된 ID
   if(memberId != null && memberId != ''){            // 로그인 된 ID가 member 일 경우 
      data.member_id =  memberId;
	}else if(sellerId != null && sellerId != ''){		// 로그인 된 ID가 seller 일 경우
		data.member_id =  sellerId;
	}
   
   if((memberId === null || memberId === '') && (sellerId === null || sellerId === '')){	// 로그인 ID가 없을 경우
		alert('로그인 후 이용 가능합니다.');
		location.href = "${contextPath}/member/loginForm.do";
		   
   }else{                                                   // 로그인 ID가 있을 경우
      $.ajax({
         type : "POST",
         async : false,
         url : "${contextPath}/cart/addGoodsInCart",
         data : JSON.stringify(data),
           contentType: "application/json",
         success : function(res){
            if(res === "add_success"){
               alert("장바구니에 상품이 추가되었습니다.");
               if(confirm("장바구니 페이지로 이동하시겠습니까?")){
                  location.href = '/cart/myCartList.do';         
               }
            }else{
               alert("이미 카트에 등록된 상품입니다.");
            }
         },
         error : function(e){
            console.log('error : ', e);
         }
      });
   }
   
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
   
   function fn_order_each_goods() {
       var _isLogOn = document.getElementById("isLogOn");
       var isLogOn = _isLogOn.value;
       
       if (isLogOn !== "false" && isLogOn !== '') {
          var orderForm=document.orderForm;
         orderForm.submit();
       } else {
           alert("로그인 후 주문이 가능합니다.");
           location.href = "${contextPath}/member/loginForm.do"; // 로그인 페이지 경로로 변경해야 합니다.
       }
   }
   
function add_wish(goods_id){
   let data = {
         goods_id : goods_id,
         };
   
   
   let memberId = $('#isLogOnMember').val();								// 로그인 된 ID
	let sellerId = $('#isLogOnSeller').val();	                      // 로그인 된 ID
   if(memberId != null && memberId != ''){            // 로그인 된 ID가 member 일 경우 
      data.member_id =  memberId;
	}else if(sellerId != null && sellerId != ''){		// 로그인 된 ID가 seller 일 경우
		data.member_id =  sellerId;
	}
   
   if((memberId === null || memberId === '') && (sellerId === null || sellerId === '')){	// 로그인 ID가 없을 경우
		alert('로그인 후 이용 가능합니다.');
		location.href = "${contextPath}/member/loginForm.do";
		   
      
   }else{                                                   // 로그인 ID가 있을 경우
      $.ajax({
         type : "POST",
         async : false,
         url : "${contextPath}/mypage/addWishList",
         data : JSON.stringify(data),
           contentType: "application/json",
         success : function(res){
            if(res === "add_success"){
               alert("위시리스트에 상품이 추가되었습니다.");
               if(confirm("위시리스트 페이지로 이동하시겠습니까?")){
                  location.href = '/mypage/wishList.do';         
               }
            }else{
               alert("이미 찜한 상품입니다.");
            }
         },
         error : function(e){
            console.log('error : ', e);
         }
      });
   }

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
	
	function fn_order_each_goods() {
	    var isLogOn = '${isLogOn}';
	    if (isLogOn != "false" && isLogOn != '') {
	    	var orderForm=document.orderForm;
			orderForm.submit();
	    } else {
	        alert("로그인 후 주문이 가능합니다.");
	        location.href = "${contextPath}/member/loginForm.do"; // 로그인 페이지 경로로 변경해야 합니다.
	    }
	}
	
</script>


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

.faq-content {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 10px;
      }
      .faq-answer {
        margin-top: 10px;
        display: none;
      }
      .answer-textarea {
       
        height: 100px;
        resize: none;
        margin-top: 10px;
        border: 1px solid #ccc;
        padding: 5px;
      }
      .answer-button {
        padding: 5px 10px;
        border: none;
        border-radius: 5px;
        background-color: #f0f0f0;
        color: #333;
        cursor: pointer;
      }
      .answer-button:hover {
        background-color: #ccc;
      }
      .faq-table {
       
        margin: 20px auto;
        border-collapse: collapse;
      }
      .faq-table th,
      .faq-table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ccc;
      }
	  .table-container >button {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}
</style>

	
</head>
<body>
		<input type="hidden" id="isLogOnMember" value="${memberInfo.member_id }" />
		<input type="hidden" id="isLogOnSeller" value="${memberInfo.seller_id }" />

	<input type="hidden" id="contextPath" data-context="${contextPath}" />


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
<form action="${contextPath}/order/orderEachGoods.do" method="post" name="orderForm">
	<div id="detail_table">
			<input type="hidden" name="goods_title" value="${goodsVO.goods_title}">
			<input type="hidden" name="goods_id" value="${goodsVO.goods_id}">

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
				         ${discounted_price}원(10%할인)</span></td>
				</tr>
				
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">

			      <input type="number" value="1" style="width: 400px; text-align: center;" id="order_goods_qty" name="order_goods_qty">

				
					 </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">옵션</td>
					<td class="fixed">

						<select style="width: 400px;  text-align: center" id="goods_option" name="goods_option" >

							<option value="${goodsVO.goods_option1}">${goodsVO.goods_option1}</option>
							<option value="${goodsVO.goods_option2}">${goodsVO.goods_option2}</option>
							<option value="${goodsVO.goods_option3}">${goodsVO.goods_option3}</option>
							<option value="${goodsVO.goods_option4}">${goodsVO.goods_option4}</option>
							<option value="${goodsVO.goods_option5}">${goodsVO.goods_option5}</option>
		

					   </select>
						   </td>
				</tr>
				
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong name="total_goods_price" value="${goodsVO.goods_delivery_price}">3000원</strong></td>
				</tr>
				
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				
			</tbody>
		</table>
	
		<ul>
			<li><a class="buy" href="javascript:fn_order_each_goods()">구매하기 </a></li>
			<li><a class="cart" href="javascript:add_cart('${goodsVO.goods_id}')">장바구니</a></li>
			<li><a class="btn_add_wish" href="javascript:add_wish('${goodsVO.goods_id}')"><span></span></a></li>
		</ul>
	</div>
</form>
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
  <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0"><br><br><img src="${contextPath}/thumbnails.do?goods_id=${goodsVO.goods_id}&fileName=${goodsVO.goods_image_name2}"></div>
	 
	  <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0" style="margin-left: 27%;">
		
			<table class="tb_comment tb_comment_common">
	
	<caption>상품평 등급, 상품평내용 , 작성자, 등록일, 조회수에 관한 테이블</caption>
	<c:if test="${review== null}">
			<p>등록된 상품 리뷰가 없습니다.</p>
		</c:if>			
				
	<colgroup>
		<col style="width:400px">
		<col>
		<col style="width:500px">
			
	</colgroup>
	<c:forEach items="${review}" var="review">
	<tbody>
					
			<tr>
				<td class="comment-grade">
				<span class="rec rec_a"><img alt="" src="${contextPath}/thumbnails.do?goods_id=${review.member_id}&fileName=${review.review_img}&fileType=review" width="100px"></span>
				</td>
				<td class="comment-content">
				<p class="pd-tit">${review.review_title}</p>
				<p class="con">${review.review_content}</p>
				</td>

				<td class="info">
				<dl class="writer-info">
				<dt>작성자 : </dt>
				<dd>${review.member_id}</dd>
				<dt>등록일 :</dt>
				<dd>${review.review_writeDate}</dd>
				</dl>
				</td>		
				</tr>
					<tr><td ><hr></td></tr>
					
	</tbody>
	</c:forEach>
</table>

<br><br>
	</div>

  <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0" >
	  <table class="tb_comment tb_comment_common">	
				
	<colgroup>
		<col style="width:300px">
		<col>
		<col style="width:400px">
			
			
	</colgroup>
	<div class="table-container">
		<br>
		<button style="margin-left: 40%;" onclick="javascript:qnaGoods()">문의글 작성하기</button>
		<script>

			function qnaGoods() {
				if('${sessionScope.isLogOn}'=='true'){
				var qnaGodosList= document.getElementById("qnaGoods");
				var qnaWrite= document.getElementById("qnaWrite");
				qnaGodosList.style.display="none";
				qnaWrite.style.display="table"
				}else{
					
					alert("로그인 이후 이용 가능합니다!")
					location.replace("${contextPath}/member/loginForm.do")
				}
			}
		  </script>
		<table class="faq-table" id="qnaGoods">
			</tr>
		  <thead>
			<tr>
			  <th style="width: 18%">문의자</th>
			  <th style="width: 55%">문의 내역</th>
			  <th style="width: 20%">문의일자</th>
			  <th style="width: 8%">삭제</th>
			</tr>
		  </thead>
		  <tbody>
			<c:forEach var="qna" items="${qna}" varStatus="varSta">
			
			  <tr class="faq-content">
				<td>${qna.member_id}</td>
				<td>
				  <a
					href="javascript:void(0)"
					style="color: black; display: flex; align-items: center; text-decoration: none;"
					onclick="toggleAnswer('${varSta.count}')"
				  >
					<b>${qna.goods_qna_title}</b><br>
				  </a>
				</td>
				<td>${qna.goods_qna_writeDate}</td>
				<td>
					<c:if test="${memberInfo.member_id == qna.member_id}">
				  <button onclick="location.href='${contextPath}/goods/goodsDetail.do?goods_id=${param.goods_id}&num=${varSta.index}'">삭제</button>
					</c:if>
				</td>
			  </tr>
			  <tr
				class="faq-answer${varSta.count}"
				id="faqAnswer${varSta.count}"
				style="display: none"
			  >
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
				<td></td>
			  <td colspan="3" style="text-align: left;">
				  <p>${qna.goods_qna_content}</p>
				  <p>[답변] ${qna.goods_qna_answer}</p>
			  </td>
			  
			  </tr>
			</c:forEach>
		  </tbody>
		</table>
	  </div>
</table>
	  
	<table class="faq-table" id="qnaWrite" style="display: none; width: 60%;">
	</tr>
	<thead>
	<tr>
  <th style="width: 15%">구분</th>
  <th style="width: 45%">문의 내역</th>
  <th style="width: 8%">등록</th>
	</tr>
	</thead>
	<form action="${contextPath}/goods/goodsQna.do" method="post" enctype="UTF-8">
	<tbody>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name= "goods_qna_title" style="width: 100%">
			</td>
			<td rowspan="3"><input type="submit" value="등록하기"></td>

		</tr>
		<tr>
			<td>구분</td>
			<td>
				<select name="goods_qna_middle_title" style="width: 100%;">
					<option value="배송문제">배송문제</option>
					<option value="상품문제">상품문제</option>
					<option value="교환/환불문제">교환/환불</option>
					<option value="기타">기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
			내용
			</td>
			<input type="hidden" name="goods_id" value="${param.goods_id}">
 			<td>
			<textarea style="width: 100%;" name = "goods_qna_content"></textarea>
			</td>
		
		</tr>
	
	</tbody>
	</form>
	</table>
	</div>
	</div>

	
	</body>


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
	<link rel="stylesheet" href="/css/detail.css" />
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>


<script type="text/javascript">

function add_cart(goods_id){
	var goods_stock='${goodsVO.goods_stock}';
		if(goods_stock != 0){
   var cart_goods_qty = document.getElementById("order_goods_qty").value;  
		 }else{
			var cart_goods_qty = 0;  
		 }
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


   

function add_wish(goods_id){
   let data = {
         goods_id : goods_id,
         };
   var deleteWish = $("#deleteWish").val();
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
		   
      
   }else{    

      $.ajax({
         type : "POST",
         async : false,
         url : "${contextPath}/mypage/addWishList",
         data : JSON.stringify(data),
           contentType: "application/json",
         success : function(res){
            if(res == "add_success"){
				$(".btn_add_wish").css({
				"background":"url('/image/btn_add_wish.png')", 
				"background-repeat" : "no-repeat", 
				"background-position":"center center"
			});

               alert("위시리스트에 상품이 추가되었습니다.");
               if(confirm("위시리스트 페이지로 이동하시겠습니까?")){
                  location.href = '/mypage/wishList.do';         
               }
            }else{
               removeWish(deleteWish);
            }
         },
         error : function(e){
            console.log('error : ', e);
         }
      });
   }

}

	function removeWish(deleteWish){

		var articleNO = deleteWish;
		articleNO*=1;
		$.ajax({
         type : "POST",
         async : false,
         url : "${contextPath}/mypage/removeWishList.do",
         data :  {articleNO : articleNO},
         success : function(result){
            $(".btn_add_wish").css({
				"background":"url('/image/btn_del_wish.png')", 
				"background-repeat" : "no-repeat", 
				"background-position":"center center"
			});
		
			if(result!=null){
				$('.btn_add_wish').prop("href", 'javascript:add_wish("${goodsVO.goods_id}")');			    
               } else{
               alert("위시리스트 삭제에 실패했습니다.")
            }
         },
         error : function(e){
         }
      });
	}
	
	
	function fn_order_each_goods() {
	    var isLogOn = '${isLogOn}';
		var goods_stock='${goodsVO.goods_stock}';
		if(goods_stock != 0){
			if (isLogOn != "false" && isLogOn != '') {
				var orderForm=document.orderForm;
				orderForm.submit();
			} else {
				alert("로그인 후 주문이 가능합니다.");
				location.href = "${contextPath}/member/loginForm.do"; // 로그인 페이지 경로로 변경해야 합니다.
			}
		}else{
			alert("상품의 재고가 없습니다.")
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
.btn_add_wish > span {
	background: url("/image/btn_del_wish.png") no-repeat center;
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
						<fmt:formatNumber value="${goodsVO.goods_price}"  pattern="##,###,### 원"/>
				     
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
							<c:if test="${goodsVO.goods_stock ==0}">
							<p style="color: red; font-size: 17px;">품절</p> 
							</c:if>
							<c:if test="${goodsVO.goods_stock !=0}">
			      		<input type="number" value="1" style="width: 400px; text-align: center;" id="order_goods_qty" name="order_goods_qty" min="1" max="${goodsVO.goods_stock}">
							</c:if>
					</td>
				
				
					 
				</tr>
				<tr class="dot_line">
					<td class="fixed">옵션</td>
					<td class="fixed">

						<select style="width: 400px;  height: 25px; text-align: center" id="goods_option" name="goods_option" >

							<option value="${goodsVO.goods_option1}"style="font-size: 18px;" >${goodsVO.goods_option1}</option>
							<option value="${goodsVO.goods_option2}"style="font-size: 18px;" >${goodsVO.goods_option2}</option>
							<option value="${goodsVO.goods_option3}"style="font-size: 18px;" >${goodsVO.goods_option3}</option>
							<option value="${goodsVO.goods_option4}"style="font-size: 18px;" >${goodsVO.goods_option4}</option>
							<option value="${goodsVO.goods_option5}"style="font-size: 18px;" >${goodsVO.goods_option5}</option>
					   </select>
						   </td>
				</tr>
				
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong name="total_goods_price" value="${goodsVO.goods_delivery_price}" style="font-size: 16px;" >3,000원</strong></td>
				</tr>
				
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed" style="font-size: 16px;" >지금 주문 시 내일 도착 예정</td>
				</tr>
				
			</tbody>
		</table>
		
		<c:forEach var="goodsWish" items="${wishList}">
			<c:if test="${goodsWish.goods_id == goodsVO.goods_id}">
				<c:set var ="deleteWish" value="${goodsWish.articleNO}"/>
				<c:set var ="equalWish" value="Y"/>
			</c:if>
		</c:forEach>
	<script>
		    $(window).ready(function () {
		if('${equalWish}' == 'Y'){
		$(".btn_add_wish").css({"background":"url('/image/btn_add_wish.png')", 
								 "background-repeat" : "no-repeat", 
   								 "background-position":"center center"});
		$('.btn_add_wish').prop("href", 'javascript:removeWish("${deleteWish}")');						 
		}
	});

	</script>
	<input type="hidden" value="${deleteWish }" id="deleteWish"> 
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

		<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0"><br><br>
			<img src="${contextPath}/thumbnails.do?goods_id=${goodsVO.goods_id}&fileName=${goodsVO.goods_image_name2}">
		</div>

		<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0" style="margin:0px;">

		<br><br>
			<table class="tb_comment tb_comment_common" style="margin: auto;">
				
			<colgroup>
			<col style="width:400px">
			<col>
			<col style="width:500px">
			</colgroup>

			<c:choose>
			<c:when test="${review == null or fn:length(review) == 0}">
            <tr>
                <td colspan="3" style="border:1px solid gray; padding:20px;">
                    <p align="center">
                        <b><span style="font-size:100pt"></span></b>
                    </p>
                    등록된 상품 리뷰가 없습니다.
                </td>
            </tr>
        </c:when>
			
			<c:when test="${review != null }">		
			<c:forEach items="${review}" var="review">
			<tr>
				<td class="comment-grade" style="border-bottom:1px solid gray;">
					<span class="rec rec_a"><img alt="" src="${contextPath}/thumbnails.do?goods_id=${review.member_id}&fileName=${review.review_img}&fileType=review" width="100px"></span>
				</td>
				<td class="comment-content" style="border-bottom:1px solid gray;">
					<p class="pd-tit">${review.review_title}</p>
					<p class="con">${review.review_content}</p>
				</td>

				<td class="info" style="border-bottom:1px solid gray;">
					<dl class="writer-info">
						<dt>작성자  </dt>
							<dd><span style="font-size:12pt">${review.member_id}</span></dd>
							<dt>등록일 </dt>
							<dd><span style="font-size:11pt">${review.review_writeDate}</span></dd>
					</dl>
				</td>		
			</tr>
			</c:forEach>
			</c:when>
			</c:choose>
					
	
	
	
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


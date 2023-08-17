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

.file-preview{
	float: left;
	margin-left: 10%;
}



</style>
<script type="text/javascript">

   $(document).ready(function() {
      $('input[name="imageUpload"]').on('change', function(event) {
         var file = event.target.files[0];
         var reader = new FileReader();
         reader.onload = function(e) {
            $('.file-preview').html('<img src="' + e.target.result + '" alt="Preview" style="width: 200px; height: 200px; margin: 10px 0 10px 0;"> <br><input type="file">');
         };
         reader.readAsDataURL(file);
      });
   });


</script>
</head>
<body>
	<br>

		<h1>상품 등록하기</h1>


	<br><br>
	<div class="file-preview">
		
			<img src="${contextPath}/thumbnails.do?goods_id=1&fileName=1.png" >
			<br>
			<input type="file" name="imageUpload">
		
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">상품명</td>
					<td class="active"><span >
						<input type="text">
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><span >
						<input type="text">
				        </span></td>
				</tr>
				
				<tr>
					<td class="fixed">재고</td>
					<td class="fixed">
						<input type="text">
					 </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">카테고리</td>
					<td class="fixed">
						<select style="text-align: center" id="order_goods_qty">
							<option>대분류</option>
								  <option>2</option>
								  <option>3</option>
								  <option>4</option>
								  <option>5</option>
					   </select>
						   
						   
							<select style="text-align: center" id="order_goods_qty">
								<option>중분류</option>
									  <option>2</option>
									  <option>3</option>
									  <option>4</option>
									  <option>5</option>
						   </select>
							 
							 
								<select style="text-align: center" id="order_goods_qty">
									<option>소분류</option>
										  <option>2</option>
										  <option>3</option>
										  <option>4</option>
										  <option>5</option>
							   </select>
								 
				</tr>
				
				<tr class="dot_line">
					<td class="fixed">사용 연령</td>
					<td class="fixed">
						<select style=" text-align: center" id="order_goods_qty">
							<option>사용 연령</option>
								  <option>2</option>
								  <option>3</option>
								  <option>4</option>
								  <option>5</option>
					   </select>
						   </td>
				</tr>

				<tr>
					<td class="fixed">관련 태그</td>
					<td class="fixed">
						<textarea name="" id="" cols="30" rows="10"></textarea>
					</td>
				</tr>
				<tr>
					<td class="fixed">상품 옵션</td>
					<td class="fixed">
						<input type="text"><button>+</button>
					 </td>
				</tr>
				
			</tbody>
		</table>
	</div>

	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<br><br><br>
	
	
		<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">상품상세</button>
  </li>
	</ul>
	
	<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
	<br><br><input type="file" value="사진 첨부"></div>
	 
	
		

</div>
	
	</body>


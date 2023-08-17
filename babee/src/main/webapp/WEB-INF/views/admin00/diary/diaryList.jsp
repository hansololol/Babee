<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"	 />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>�떎�뼱�씠由� 紐⑸”李�</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function backToList(obj){
		obj.action = "${contextPath}/board/listArticles.do";
		obj.submit();
	}
	
	var cnt=1;
	function fn_addFile(){
		$("#d_file").append("<br>"+"<input type='file' name='file"+cnt+"' />");
		cnt++;
	}
</script>

<style>
.text_center{ 
	text-align:center;
	}

/* '�떎�씠�뼱由� �옉�꽦' 踰꾪듉 �뒪���씪 */
input[type="submit"] {
    background-color: #ffcd29; /* 諛곌꼍�깋 */
    color: black; /* �뀓�뒪�듃�깋 */
    padding: 10px 20px; /* �궡遺� �뿬諛� */
    border: none; /* �뀒�몢由� �뾾�쓬 */
    border-radius: 5px; /* �뀒�몢由� 諛섍꼍 */
    cursor: pointer; /* 而ㅼ꽌 紐⑥뼇 蹂�寃� */
}

/* '�떎�씠�뼱由� 二쇰Ц' 踰꾪듉 �뒪���씪 */
button[type="button"] {
    background-color: #ffff80; /* 諛곌꼍�깋 */
    color: black; /* �뀓�뒪�듃�깋 */
    padding: 10px 20px; /* �궡遺� �뿬諛� */
    border: none; /* �뀒�몢由� �뾾�쓬 */
    border-radius: 5px; /* �뀒�몢由� 諛섍꼍 */
    cursor: pointer; /* 而ㅼ꽌 紐⑥뼇 蹂�寃� */
}

/* 踰꾪듉�뿉 �샇踰� �슚怨� */
input[type="submit"]:hover, button[type="button"]:hover {
    background-color: #cca300; /* �샇踰� �떆 諛곌꼍�깋 蹂�寃� */
}

/*二쇰Ц 踰꾪듉 �닔�젙�븘�슂 */
input[type="reset"]:hover {
    background-color: #cca300; /* �샇踰� �떆 諛곌꼍�깋 蹂�寃� */
}
 
 

.diary_list {
    display: inline-block;
    margin: 10px;
    padding: 10px;
    width:300px;
    
}

.diary_list ul {
    list-style: none;
    padding: 0;
}

.diary_list li {
    margin-bottom: 5px;
}

.diary_list li.checkbox{
    text-align: left;
}


.diary_list li img{
    width: 200px;
    height: 180px;
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
    content: "10�옣 �씠�긽遺��꽣 二쇰Ц 媛��뒫�빀�땲�떎.";
    position: absolute;
    top: -60px;
    left: 50%;
    transform: translateX(-50%);
    background-color: #333;
    color: white;
     width: 250px; /* 媛�濡� �겕湲곕�� �뒛由� */
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
 
</style>
</head>
<body>



	<div style="text-align: center;">
		<h1 class="text_center">�떎�씠�뼱由�</h1>
		<h4 class="text_center" style="color:#996633;">�옉�� 諛쒖옄援�, �겙 �궗�옉�쓽 �떎�씠�뼱由�</h4>
		<img src="/image/line.png" style="margin: 0 auto; display: block;" alt="以� 異쒕젰">
	</div>

<br>
<form method="post" action="${contextPath}/student/addStudent.do" enctype="multipart/form-data">


	<div style="text-align: center;">
  		 <input type="submit" value="�떎�씠�뼱由� �옉�꽦">&nbsp;&nbsp;&nbsp;
   		 <button type="button" class="tooltip-button">�떎�씠�뼱由� 二쇰Ц</button>
   		 	
	</div>
	
	<div style="text-align: center;">
		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>

		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>
	
		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>
		<br>
		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>

		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>
		
		<div class="diary_list">
			<ul>
				<li style="text-align: left;"> <input type="checkbox"> </li>
				<li> <img src="/image/doog.jpg"/> </li>
				<li style="text-align: left;"> �븯猷⑥쓽 湲곕줉 </li>
				<li> �삤�뒛 �븯猷⑥쓽 湲곕줉�쓣 Babee�뿉�꽌 �룄���뱶由쎈땲�떎. </li>
				<li style="text-align: right;"> �옉�꽦�씪 </li>
			</ul>
		</div>

</form>

</body>
</html>

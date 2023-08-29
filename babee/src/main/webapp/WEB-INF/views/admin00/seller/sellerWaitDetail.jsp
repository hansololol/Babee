<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>사업자 상세창(관리자)</title>

<style>

.store_basic {
    left: 30px;
    top: 30px;
    border-radius: 40px;
    border-collapse: collapse;
    width: 600px;
   
} 

.store_basic > td{
	border: 1px solid gray;
}	

#store_basic_1 {
	display: none;

}
</style>
<script>
function fn_refuse() {
	document.getElementById("store_basic_1").style.display = "inline-block";	
}

</script>
</head>
<body>



<div style="width:66%; height:150px; background-color: #FEF7DD; margin:0 auto; ">
<br> 
<h1> &nbsp; &nbsp; &nbsp; &nbsp; 사업자 관리</h1>
</div>


<form>
<div style="width:66%; margin:0 auto;">

	<h3 style="display:inline-block; margin-bottom: 8px; margin-top: 10px;"> {별나라 베이비샵} &nbsp; <h6 style="display:inline-block; margin-bottom: 8px;"> YYYY-MM-DD</h6> </h3> 

	<hr style="padding-top:0px">
</div>

<div style="margin:0 auto;">

	<table class="store_basic"  style="margin:0 auto;">
	 <tr>
         <td width="200"><h4 align="center"> <span style="color: #cc9900;">●</span>기본정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
 	 </table>

<table class="store_basic" border="1px solid gray;" style="margin:0 auto;">
     

	<tr>
		<td width="200px" height="40px" align="center"> 아이디 </td>
		<td width="200px"> { 아이디 } </td>
		<td width="200px" align="center"> 비밀번호 </td>
		<td width="200px"> { 비밀번호 } </td>
	</tr>
	
	<tr>
		<td width="200px" height="40px" align="center"> 담당자 이름 </td>
		<td width="200px"> { 담당자 이름 } </td>
		<td width="200px" align="center"> 이메일 </td>
		<td width="200px"> { 이메일 } </td>
	</tr>
	
	<tr>
		<td width="200px" height="40px" align="center"> 일반전화</td>
		<td width="200px"> { 일반전화 } </td>
		<td width="200px" align="center"> 휴대전화 </td>
		<td width="200px"> { 휴대전화 } </td>
	</tr>
	
	<tr>
        <td width="200px" height="40px" align="center">사업체 주소</td>
        <td colspan="3">{사업체 주소}</td>
    </tr>

	<tr>
		<td width="200px" height="40px" align="center"> 계좌번호 </td>
		<td width="200px"> { 계좌번호 } </td>
		<td width="200px" align="center"> 은행 </td>
		<td width="200px"> { 은행 } </td>
	</tr>
	
	<tr>
		<td width="200px" height="40px" align="center"> 예금주명 </td>
		<td width="200px" colspan="3"> { 예금주명 } </td>
	</tr>
	
</table>




	<table class="store_basic"  style="margin:0 auto;">
	 <tr>
         <td width="200" style=""><h4 align="center" style="margin-top: 10px;"><span style="color: #cc9900;">●</span> 사업체 정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
 	 </table>
	
<table class="store_basic" border="1px solid gray;" style="margin:0 auto;">
		<tr>
			<td width="150px" height="40px" align="center"> 사업체 이름 </td>
			<td  colspan="3"> { 사업체 이름 } </td>
		</tr>
		<tr>
			<td width="150px" height="40px" align="center"> 사업체 소개 </td>
			<td  colspan="3"> { 사업체 소개 } </td>
		</tr>
</table>
	
	
	
	<table class="store_basic"  style="margin:0 auto;">
	 <tr>
         <td width="200"><h4 align="center" style="margin-top: 10px;"><span style="color: #cc9900;">●</span> 서류 정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
 	 </table>

	<div style="margin: 0 auto;">
	<ul class="nav nav-tabs" id="myTab" role="tablist" style="width:600px; margin: 0 auto;">
		<li class="nav-item" role="presentation">
		  <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">사업자 등록증</button>
		</li>
		<li class="nav-item" role="presentation">
		  <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">통신판매신고증</button>
		</li>
		<li class="nav-item" role="presentation">
		  <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">통장사본</button>
		</li>
	</ul>

	<div class="tab-content" id="myTabContent">
	  <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0"><br><br><img src="/image/ex01.jpg" width="600px;"></div>
	  <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0"><br><br>
		<br><br><img src="/image/ex01.jpg" width="600px;">
		</div>  
	</div>

	<div>
		<input type="submit" id="access" value="승인">
		<input type="button" id="refuse" value="반려" onClick="fn_refuse()">
	</div>

	<div id="store_basic_1">
 		<table >
			<tr>
        		<td width="200">사유</td>
        		<td><textarea style="width: 350px;height: 100px; margin:5px;"></textarea></td>
				<td><input type="submit" value="입력"></td>
      		</tr>
 	 	</table>
	</div>
	 
	



</form>


</body>
</html>
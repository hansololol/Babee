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
<script>
function fn_refuse() {
	document.getElementById("store_basic_1").style.display = "inline-block";
	document.getElementById("access").disabled = "true";	
}
function fn_seller_Register(seller_id, seller_status){
	var formObj = document.createElement("form");
    var s_seller = document.createElement("input");
			s_seller.name = "seller_id";
            s_seller.value = seller_id;
            formObj.appendChild(s_seller);
      var s_status = document.createElement("input");
	  		s_status.name = "seller_status";
	  		s_status.value = seller_status;
            formObj.appendChild(s_status);
      document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/admin/member/sellerRegister.do";
            formObj.submit();
   }

function fn_seller_Refuse(seller_id, seller_status, seller_refuse){
	var formObj = document.createElement("form");
    var s_seller = document.createElement("input");
			s_seller.name = "seller_id";
            s_seller.value = seller_id;
            formObj.appendChild(s_seller);
    var s_status = document.createElement("input");
	  		s_status.name = "seller_status";
	  		s_status.value = seller_status;
            formObj.appendChild(s_status);
	var s_refuse = document.createElement("input");
			s_refuse.name = "seller_refuse"
			s_refuse.value = document.getElementById("seller_refuse").value;
            formObj.appendChild(s_refuse);	
      document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/admin/member/sellerRefuse.do";
            formObj.submit();
}


</script>
<style>

	.store_basic {
		left: 30px;
		top: 30px;
		border-radius: 50px;
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
</head>
<body>



<div style="width:66%; height:150px; background-color: #FEF7DD; margin:0 auto; line-height: 50px;">
<br> 
<h1> 사업자 관리</h1>
</div>


<form name="frmSellerWaitDetail" action="${contextPath}/admin/member/sellerRegister.do" method="post" enctype="multipart/form-data">
<div style="width:66%; margin:0 auto;">

	<h3 style="display:inline-block; margin-bottom: 8px; margin-top: 10px;">${seller.seller_company} &nbsp; <h6 style="display:inline-block; margin-bottom: 8px;">${seller.seller_joinDate}</h6> </h3> 

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
		<td width="200px">${seller.seller_id}</td>
		<td width="200px" align="center"> 비밀번호 </td>
		<td width="200px">${seller.seller_pw}</td>
	</tr>
	
	<tr>
		<td width="200px" height="40px" align="center"> 사업주 이름</td>
		<td width="200px">${seller.seller_name}</td>
		<td width="200px" align="center"> 이메일 </td>
		<td width="200px">${seller.seller_email}</td>
	</tr>
	
	<tr>
		<td width="200px" height="40px" align="center"> 일반전화</td>
		<td width="200px">${seller.seller_tel1} - ${seller.seller_tel2} - ${seller.seller_tel3}</td>
		<td width="200px" align="center"> 휴대전화 </td>
		<td width="200px">${seller.seller_hp1} - ${seller.seller_hp2} - ${seller.seller_hp3}</td>
	</tr>
	
	<tr>
        <td width="200px" height="40px" align="center">사업체 주소</td>
        <td colspan="3">${seller.seller_roadAddr} ${seller.seller_namujiAddr}</td>
    </tr>
	<tr>
		<td width="200px" height="40px" align="center"> 예금주명 </td>
		<td width="200px">${seller.seller_name} </td>
		<td width="200px" align="center"> 은행 명</td>
		<td width="200px">${seller.seller_bank_com}</td>
	</tr>
	<tr>
		<td width="200px" height="40px" align="center"> 계좌번호 </td>
		<td width="200px" colspan="3">${seller.seller_bank_num}</td>
	</tr>
	
	
	
</table>




	<table class="store_basic"  style="margin:0 auto;">
	 <tr>
         <td width="200"><h4 align="center" style="margin-top: 10px;"><span style="color: #cc9900;">●</span> 사업체 정보 </h4></td>
         <td> &nbsp;</td>
      </tr>
 	 </table>
	
<table class="store_basic" border="1px solid gray;" style="margin:0 auto;">
		<tr>
			<td width="150px" height="40px" align="center"> 사업체 이름 </td>
			<td  colspan="3">${seller.seller_company}</td>
		</tr>
		<tr>
			<td width="150px" height="40px" align="center"> 사업체 소개 </td>
			<td  colspan="3">${seller.seller_company_info}</td>
		</tr>
</table>
	
	
	
	<table class="store_basic"  style="margin:0 auto;">
	 <tr>
         <td width="200"><h4 text-align="center" style="margin-top: 10px;"><span style="color: #cc9900;">●</span> 서류 정보 </h4></td>
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

	<div class="tab-content" id="myTabContent" style="margin: 30px auto;">
	  <div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0"><img src="${contextPath}/thumbnails.do?goods_id=${seller.seller_id}&fileName=${seller.seller_img1}" width="400px;"></div>
	  <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0"><img src="/image/ex01.jpg" width="600px;"></div>  
	  <div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0"><br><br><img src="/image/통장사본.jpg" width="400px;"></div>
	</div>

	<div style="margin: 30px auto;">
		<input type="hidden" name="seller_status" value="승인">
		<input type="button" id="access" value="승인" onClick="fn_seller_Register('${seller.seller_id}', '승인')">
		

		<input type="button" id="refuse" value="반려" onClick="fn_refuse()">
	</div>

	<div id="store_basic_1">
 		<table >
			<tr>
        		<td width="200">사유</td>
        		<td><textarea style="width: 350px;height: 100px; margin:5px;" id="seller_refuse" name="seller_refuse" value="${seller.seller_refuse}"></textarea></td>
				<td><input type="button" value="입력" onClick="fn_seller_Refuse('${seller.seller_id}', '반려', '${seller.seller_refuse}')"></td>
      		</tr>
 	 	</table>
	</div>
	 
	



</form>


</body>
</html>
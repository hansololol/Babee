<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>


<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 작성창</title>

<style>

.star-rating {
  display: flex;
  flex-direction: row-reverse;
  font-size: 2.25rem;
  line-height: 2.5rem;
  justify-content: space-around;
  padding: 0 0.2em;
  text-align: center;
  width: 5em;
}
 
.star-rating input {
  display: none;
}
 
.star-rating label {
  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
  -webkit-text-stroke-width: 2.3px;
  -webkit-text-stroke-color: #2b2a29;
  cursor: pointer;
}
 
.star-rating :checked ~ label {
  -webkit-text-fill-color: gold;
}
 
.star-rating label:hover,
.star-rating label:hover ~ label {
  -webkit-text-fill-color: #fff58c;
}
/* '작성하기' 버튼 스타일 */
.diary_write_btn > input[type="submit"] {
    background-color: #ffcd29; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* '다시입력' 버튼 스타일 */
.diary_write_btn > input[type="reset"] {
    background-color: #ffff80; /* 배경색 */
    color: black; /* 텍스트색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 테두리 반경 */
    cursor: pointer; /* 커서 모양 변경 */
}

/* 버튼에 호버 효과 */
.diary_write_btn > input[type="submit"]:hover, input[type="reset"]:hover {
    background-color: #cca300; /* 호버 시 배경색 변경 */
}
</style>



</head>
<body>


<div style="width:66%;">


<h3> 리뷰 작성 </h3>


</div>

<form method="post" action="${contextPath}/member/적어야해요.do" enctype="multipart/form-data" style="margin-left: 110px; width:800px;">


<table style="border-collapse: collapse; margin:0 auto; ">
      
      <tr>
         <td width="200" style="border:1px solid gray; background:#ffffcc; padding:10px;"> <p align="center"> 작성자</p></td>
         <td width="250" colspan="2" style="border:1px solid gray; padding:10px;" > 
            
            ${memberInfo.member_name}
         <input type="hidden" name="member_id" value=${memberInfo.member_id }> </td>
      </tr>
      
      <tr>
         <td width="200" style="border:1px solid gray; background:#ffffcc; padding:10px;"> <p align="center" > 제목 </td>
         <td width="250" colspan="2" style="border:1px solid gray; padding:10px;"> <input type="text" name="review_title" size="65" style="margin-left:10px;"> </td>
      </tr>
   
      <tr>
         <td align="center" style="border:1px solid gray; background:#ffffcc; padding:10px;" > 상품 이미지 </td>
         <td width="200" ><input type="file" name="review_img" onChange="readURL(this);" style="margin-left:10px;"/> 
            <p style="font-size:12px">&nbsp;다음 파일 형식만 지원됩니다.<br>
            <p style="font-size:12px">&nbsp;.jpg(JPEG), .png(Portable Network Graphics), .gif(Graphics Interchange Format)
         </td>
         <td width="250" height="200" style="border-right:1px solid gray; padding:10px;"><img id="preview" src="#" width=200 height=200 /></td>
      </tr>

      <tr>
         <td width="200" style="border:1px solid gray; background:#ffffcc; padding:10px;"> <p align="center" > 내용 </td>
         <td colspan = "2" style="border:1px solid gray; padding:10px;"><textarea name="content" rows = "10" cols="70" maxlength="3000" ></textarea> </td>
      </tr>
      
      <tr>
        <td width="200" style="border:1px solid gray; background:#ffffcc; padding:10px;"> <p align="center" > 별점 </td>
         <td colspan = "2" style="border:1px solid gray; padding:10px;">
        <div class="star-rating space-x-4 mx-auto">
	<input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
	<label for="5-stars" class="star pr-4">★</label>
	<input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
	<label for="4-stars" class="star">★</label>
	<input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
	<label for="3-stars" class="star">★</label>
	<input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
	<label for="2-stars" class="star">★</label>
	<input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
	<label for="1-star" class="star">★</label>
	
</div>

        
      </tr>
      

   </table>
   
   <br>
   <br>
   <br>
   
   <div class="diary_write_btn">
   <input type="submit" value="작성하기">&nbsp;&nbsp;&nbsp;
   <input type="reset" value="다시입력">
   </div>
   
   
   
   </form>




</body>
</html>
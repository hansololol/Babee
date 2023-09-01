<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"    />

<html>
<head>
<meta charset="UTF-8">
<title>다어이리 작성창</title>
 <link rel="stylesheet" href="http://code.jquery.com/jquery-latest.min.js">
  
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
   
   
</script>

<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 850px;
            margin: 50px auto;
            /* background: #ededed; */
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }

        .text-center {
            text-align: center;
            margin-bottom: 10px;
        }

        img#line {
            display: block;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            /* border: 1px solid #ccc; */
            border: none;
            border-radius: 5px;
        }

        input[type="file"] {
            padding: 0;
        }

        textarea {
            resize: vertical;
        }

        .image-preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
        }

        .btn-container {
            text-align: center;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #ffcd29;
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #cca300;
        }
        
        .file-label {
        display: inline-block;
        background-color: #ffcd29;
        color: black;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-bottom: 15px;
        transition: background-color 0.3s;
        position: relative;
        overflow: hidden;
    }

    .file-label span {
        display: inline-block;
        vertical-align: middle;
        margin-right: 10px;
    }

    .file-label:hover {
        background-color: #cca300;
    }

    .file-info {
        font-size: 12px;
        color: #666;
        margin-top: 5px;
    }

    .image-preview {
        max-width: 100%;
        max-height: 250px;
       
        margin-top: 10px;
    }

    .file-input {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
    }

    .file-input-label {
        display: flex;
        align-items: center;
        justify-content: center;
        
    }
    </style>
</head>
<body>
    <div class="container" style="border:1px solid lightgray;  padding:40px;">
        <h1 class="text-center">다이어리</h1>
        <h4 class="text-center" style="color: #996633;">작은 발자국, 큰 사랑의 다이어리</h4>
        <img id="line" src="/image/line.png" alt="줄 출력">
        
        <br><br>
        
        <form method="post" action="${contextPath}/diary/addDiary.do" enctype="multipart/form-data">
            <input type="hidden" name="member_id" value="${memberInfo.member_id}">
            <div class="form-group">
                <!-- <label for="dir_title">제목</label> -->
                <input type="text" id="dir_title" name="dir_title" placeholder="제목">
            </div>
           <hr>

 			<div class="form-group" style="border: 1px solid lightgray; border-radius: 5px; padding: 20px; background: azure;">
				<div class="file-input-label">
                   <table> 
                    <tr>
                    	<td width="400px;" height="200px;">
                    		<label for="dir_main_img1">
                    		<h6 style="color:gray;">표지</h6>
                    		<img src="${contextPath}/image/add.png" alt="파일 선택" width="30" height="30" style="cursor: pointer;"></label>
                   			<input type="file" class="file-input" id="dir_main_img1" name="dir_main_img1" onchange="readURL(this);">
                			<p style="font-size: 12px;">다음 파일 형식만 지원됩니다.<br>.jpg(JPEG), .png(Portable Network Graphics), .gif(Graphics Interchange Format)</p>
                		</td>
                
                		<td width="400px;">
                			<img id="preview" class="image-preview" src="#" alt="" style="margin: auto;">
                		</td>
                	</tr>
                	</table>
                </div>
            </div>
            
            <hr>
            
            <div class="form-group">
                <textarea id="baby_condition" name="baby_condition" rows="4" maxlength="4000" placeholder="아이의 상태"></textarea>
            </div>
            <hr>
            <div class="form-group">
                <textarea id="dir_content" name="dir_content" rows="10" maxlength="4000" placeholder="기록"></textarea>
            </div>
            
            <div class="btn-container">
                <input type="submit" value="작성하기">
                <input type="reset" value="다시입력">
            </div>
            
        </form>
    </div>

<script>
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#preview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
</script>
</body>
</html>
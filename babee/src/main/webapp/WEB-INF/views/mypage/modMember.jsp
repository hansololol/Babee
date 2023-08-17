<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입(일반) 목롱창</title>

    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

    <style>
        .text_center {
            text-align: center;
        }

        .tb {
            left: 30px;
            top: 30px;
            background: #ededed;
            border-radius: 40px;
            border-collapse: collapse;
            width: 66%;
            box-shadow: 20px 20px 39px rgba(0, 104, 255, 0.25);
        }

        .tb tr {
            height: 40px;
            border-bottom: 1px solid rgba(128, 128, 128, 0.25);
        }

        .tb tr:last-child {
            border-bottom: none; /* 마지막 줄의 테두리 제거 */
        }

        .Personal_Data {
            margin: 0 auto;
            border-radius: 20px;
            border: 1px solid rgba(128, 128, 128, 0.25);
            width: 600px;
        }
    </style>
    <script>
        function validateForm() {
            var inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
            var emptyFields = [];
            
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value.trim() === '') {
                    emptyFields.push(inputs[i]);
                }
            }
            
            if (emptyFields.length > 0) {
                alert('값을 전부 입력해주세요.');
                emptyFields[0].focus();
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <br><br>
    <div>
        <form method="post" action="${contextPath}/student/updateStudent.do" enctype="multipart/form-data" onsubmit="return validateForm();">
            <br>
            <table class="tb" align="center">
                <tr>
                    <td width="200"><h4 align="center"> 기본정보 </h4></td>
                    <td> &nbsp;</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">아이디</p></td>
                    <td width="300"><input type="text" value="아이디값" disabled> <!-- 아이디 값을 가져와서 표시 -->
                </tr>
                <tr>
                    <td width="200"><p align="center">비밀번호</td>
                    <td><input type="password">*</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">이름</td>
                    <td><input type="text">*</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">이메일</td>
                    <td><input type="text"></td>
                </tr>
                <tr>
                    <td width="200"><p align="center">일반전화</td>
                    <td><input type="text" size="5">-<input type="text" size="5">-<input type="text" size="5"></td>
                </tr>
                <tr>
                    <td width="200"><p align="center">휴대전화</td>
                    <td><input type="text" size="5">-<input type="text" size="5">-<input type="text" size="5"></td>
                </tr>
                <tr>
                    <td width="200"><p align="center">주소</td>
                    <td><input type="text" size="7" style=" margin-bottom: 5px;">
                        <button type="button">우편검색</button> <br>
                        <input type="text" placeholder="기본 주소" style="margin-bottom: 5px;"><br>
                        <input type="text" placeholder="상세 주소" style="margin-bottom: 5px;"><br>
                        <input type="text" placeholder="나머지 주소" style="margin-bottom: 15px;"></td>
                </tr>
            </table>
        </div>
        <br><br><br>
        <div>
            <table class="tb" align="center" style="height: 350px;">
                <tr>
                    <td width="200"><h4 align="center"> 추가정보 </h4></td>
                    <td> &nbsp;</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">성별</td>
                    <td width="300"><input type="checkbox"> 남자 
                        <input type="checkbox"> 여자</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">생년월일</td>
                    <td><input type="text" size="5" placeholder="YYYY">년 <input type="text" size="3" placeholder="MM">월 <input type="text" size="3" placeholder="DD">일</td>
                </tr>
                <tr>
                    <td width="200"><p align="center">자녀 성별</td>
                    <td width="300"><input type="checkbox"> 남자 
                        <input type="checkbox"> 여자</td>
                </tr>
                <tr>
                    <td width="200" height="100"><p align="center">자녀 나이 <span style="font-size: 8px; display: inline;">(개월수)</span></p></td>
                    <td width="300"><input type="checkbox"> 0 ~ 12개월 
                        <input type="checkbox"> 12 ~ 24개월 <br>
                        <input type="checkbox"> 24 ~ 36개월
                        <input type="checkbox"> 36개월 이상
                    </td>
                </tr>
            </table>
        </div>
        <br>
        <div style="text-align: center;">
            <p>
                <button type="submit" style="background-color: #ffa500; color: black; padding: 12px 24px; border: none; border-radius: 10px; cursor: pointer; font-size: 18px; margin-right: 10px; transition: background-color 0.3s;">수정하기</button>
                <button type="button" onclick="history.back()" style="background-color: #ffa500; color: black; padding: 12px 24px; border: none; border-radius: 10px; cursor: pointer; font-size: 18px; transition: background-color 0.3s;">뒤로가기</button>
            </p>
        </div>
    </form>
    <br><br>
</body>
</html>
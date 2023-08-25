<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>회색 박스</title>
<style>
    
    .gray-box {
        background-color: #ccc;
        padding: 20px;
        width: 70%;
        margin: 0 auto;
        text-align: center; /* 가운데 정렬을 위한 추가 스타일 */
    }
    .square-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        margin: 50px auto;
        max-width: 400px;
    }
    .square {
        width: calc(25% - 2px); /* 4개씩 정렬하므로 25%로 설정, 여백 제거 */
        height: 100px;
        text-align: center;
        font-size: 14px; /* 작은 폰트 크기 */
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
        margin: 0;
        border: none; /* 테두리 제거 */
        display: flex;
        flex-direction: column;
        justify-content: center; /* 수직 중앙 정렬 */
        align-items: center; /* 수평 중앙 정렬 */
    }
    .square span {
        margin-top: 5px; /* 텍스트와 사각형 간의 간격 조정 */
    }
    .square:hover {
        background-color: #ccc; /* 백그라운드 컬러 변경 */
        
        font-weight: bold; /* 폰트 굵게 변경 */
    }
    /* 배경색 없애기 */
    .square:nth-child(2),
    .square:nth-child(4),
    .square:nth-child(5),
    .square:nth-child(7),
    .square:nth-child(10),
    .square:nth-child(12) {
        background-color: transparent;
    }
    
    .square:nth-child(1) {
        background-color: #FFFFB7;
        cursor: pointer;
    }
    .square:nth-child(3) {
        background-color: #DFDFDF;
        cursor: pointer;
    }
    .square:nth-child(6) {
        background-color: #E0B8AC;
        cursor: pointer;
    }
    .square:nth-child(8) {
        background-color: #F9B7D8;
        cursor: pointer;
    }
    .square:nth-child(9) {
        background-color: #D3B6F0;
        cursor: pointer;
    }
    .square:nth-child(11) {
        background-color: #CAE5F2;
        cursor: pointer;
    }
    
    .button-container {
    margin-top: 10px;
    text-align: center;
}
    .custom-button {
    background-color: orange;
    color: white;
    border: none;
    border-radius: 20px;
    padding: 10px 30px;
    font-size: 16px;
    cursor: pointer;
    margin: 0 20px;
    transition: background-color 0.3s;
}

.custom-button:hover {
    background-color: #d47911;
}
</style>
</head>
<body>
    <br><br>
<div class="gray-box">
    <img src="/image/Babee_Logo.png" alt="Babee Logo">
</div>
<h2 style="margin-top: 10px; text-align:center; color: #ccc;">육아정보</h2>
<div class="square-container">
    <div class="square" onclick="openPopup('../hosmap.jsp')">
        <img src="/image/hoss.png" alt="hospiter" width="50px" height="50px">
        <span>병원위치</span>
    </div>
    <div class="square">
        <span></span>
    </div>
    <div class="square" onclick="openPopup('../labor.jsp')">
        <img src="/image/baby.png" alt="hospiter" width="50px" height="50px">
        <span>출산징후</span>
    </div>
    <div class="square">
        <span></span>
    </div>
    <div class="square">
        <span></span>
    </div>
    <div class="square" onclick="openPopup('../proadvice.jsp')">
        <img src="/image/consult.png" alt="hospiter" width="50px" height="50px">
        <span>전문가 상담</span>
    </div>
    <div class="square">
        <span></span>
    </div>
    <div class="square" onclick="openPopup('../babymap.jsp')">
        <img src="/image/school.png" alt="hospiter" width="50px" height="50px">
        <span>어린이집 <br>유치원</span>
    </div>
    <div class="square" onclick="openPopup('../injection.jsp')">
        <img src="/image/inoculation.png" alt="hospiter" width="50px" height="50px">
        <span>접종정보</span>
    </div>
    <div class="square">
        <span></span>
    </div>
    <div class="square" onclick="openPopup('../kidmap.jsp')">
        <img src="/image/play.png" alt="hospiter" width="50px" height="50px">
        <span>키즈카페</span>
    </div>
    <div class="square">
        <span></span>
    </div>
</div>
<div class="button-container">
  <button class="custom-button" type="button" onclick="location.href='your_contact_page_url_here';">메인페이지</button>
</div>
<!-- JavaScript 코드 추가 -->
<script>
    function openPopup(url) {
        window.open(url, '_blank', 'width=900,height=600');
    }
</script>
<br><br><br><br>
</body>
</html>
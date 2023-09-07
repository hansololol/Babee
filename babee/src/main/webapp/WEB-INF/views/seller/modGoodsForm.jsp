<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" isELIgnored="false"%> <%@ taglib
uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
  <head>
    
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="/css/detail.css" />
    <style>
      hgroup {
        text-align: left;
        margin-left: 25%;
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

      .file-preview {
        float: left;
        margin-left: 10%;
      }
      
      /* 기본 버튼 스타일 */
  input[type="submit"] {
    background-color: #ffcc00; /* 기본 배경색 (노란색) */
    color: #333; /* 기본 글자색 */
    padding: 10px 20px; /* 패딩 값은 필요에 따라 조정하세요 */
    border: none; /* 테두리 스타일 */
    border-radius: 5px; /* 버튼 모서리 둥글게 만듭니다 */
    cursor: pointer; /* 커서 모양을 포인터로 변경합니다 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과에 사용될 속성과 지속 시간 설정 */
  }

  /* 호버 효과 스타일 */
  input[type="submit"]:hover {
    background-color: #ddaa00; /* 호버 시 배경색을 어두운 노란색으로 변경합니다 */
    color: #fff; /* 호버 시 글자색을 흰색으로 변경합니다 */
  }
  /* 뒤로가기 버튼 스타일 */
input[type="button"] {
    background-color: #ffcc00; /* 뒤로가기 버튼의 배경색 */
    color: #333; /* 뒤로가기 버튼의 글자색 */
    padding: 10px 20px; /* 패딩 값은 필요에 따라 조정하세요 */
    border: none; /* 테두리 스타일 */
    border-radius: 5px; /* 버튼 모서리 둥글게 만듭니다 */
    cursor: pointer; /* 커서 모양을 포인터로 변경합니다 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과에 사용될 속성과 지속 시간 설정 */
}

/* 뒤로가기 버튼 호버 효과 스타일 */
input[type="button"]:hover {
    background-color: #555; /* 호버 시 배경색을 어두운 회색으로 변경합니다 */
    color: #fff; /* 호버 시 글자색을 흰색으로 변경합니다 */
}
        /* 스타일 설정 */
        .bordered-container {
            border: 1px solid #ccc;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            margin: 10px;
            padding: 10px;
            background-color: #fff;
            width: 1000px;
            margin-top: 0px;
            margin-left: 150px;
            height: auto;
        }
  
  
    </style>
    <script type="text/javascript">
      $(document).ready(function () {
        $('input[name="goods_image_name1"]').on("change", function (event) {
          var file = event.target.files[0];
          var reader = new FileReader();
          reader.onload = function (e) {
            $(".file-preview1").html(
              '<img src="' +
                e.target.result +
                '" alt="Preview" style="width: 300px; height: 300px; margin: 10px; border-radius: 20%;"> <br>'
            );
          };
          reader.readAsDataURL(file);
        });
      });
      $(document).ready(function () {
        $('input[name="goods_image_name2"]').on("change", function (event) {
          var file = event.target.files[0];
          var reader = new FileReader();
          reader.onload = function (e) {
            $(".file-preview2").html(
              '<img src="' +
                e.target.result +
                '" alt="Preview" style="width: 500px; height: auto; margin: 10px 0 10px 0;"> <br>'
            );
          };
          reader.readAsDataURL(file);
        });
      });

      function itemChange() {
        var Preparation = ["임산부복대", "스킨케어", "임부복", "산후용품"];
        var HouseholdItems = [
          "구강용품",
          "목욕용품",
          "위생용품",
          "세탁용품",
          "유아스킨케어",
        ];
        var BabyFood = ["분유", "이유식", "유아음료", "유아간식"];
        var OutdoorGear = ["유모차", "아기띠", "보호대", "마스크", "우산"];
        var Fashion = ["상의", "하의", "내의", "아우터", "신발", "잡화"];
        var Toys = ["신생아완구", "교육완구", "인형", "캐릭터완구"];
        var SafetyProducts = ["보호대", "안전문", "잠금장치"];
        var ChildrenFurniture = ["침대", "놀이가구", "소품", "책상", "의자"];

        var selectItem = $("#select1").val();
        var changeItem;

        if (selectItem == "출산준비") {
          changeItem = Preparation;
        } else if (selectItem == "생활용품") {
          changeItem = HouseholdItems;
        } else if (selectItem == "유아식품") {
          changeItem = BabyFood;
        } else if (selectItem == "외출용품") {
          changeItem = OutdoorGear;
        } else if (selectItem == "아동패션") {
          changeItem = Fashion;
        } else if (selectItem == "완구/교구") {
          changeItem = Toys;
        } else if (selectItem == "안전용품") {
          changeItem = SafetyProducts;
        } else if (selectItem == "아동가구") {
          changeItem = ChildrenFurniture;
        }

        $("#select2").empty();

        for (var count = 0; count < changeItem.length; count++) {
          var option = $("<option>" + changeItem[count] + "</option>");
          $("#select2").append(option);
        }
      }

      function itemChange2() {
        // Baby Care Items
        var bellyBand= ["산전 복대", "산후 복대"];
        var skinCare = ["스트레치마크크림", "바디오일", "클렌징오일"];
        var maternityClothes = ["원피스", "드레스", "바지"];
        var postpartumSupplies = ["보호대", "거실용품"];
        var oralCareProducts = ["칫솔", "치약", "구강청정제"];
        var bathProducts = ["욕조", "목욕의자", "비누/샴푸", "타월", "목욕장난감"];
        var hygieneProducts = ["화장지", "물티슈", "귀저기", "손소독제"];
        var laundryProducts = ["세탁세제", "세탁볼", "옷걸이", "섬유유연제"];
        var babySkinCare = ["로션", "선크림", "오일", "베이비 파우더"];
        var formulaMilk = ["종합영양분유", "고칼슘분유", "성장기분유"];
        var babyFood = ["유기농이유식", "떠먹는이유식", "갈아먹는이유식"];
        var babyDrinks = ["과일주스", "우유", "영양보충음료"];
        var babySnacks = ["과일스낵", "곡물스낵", "건강간식"];

        // Strollers and Gear
        var stroller = ["여름용유모차", "겨울용유모차", "카시트"];
        var babyCarrier = ["면아기띠", "슬링아기띠"];
        var guard = ["머리보호대", "엉덩이보호대"];
        var mask = ["일반마스크", "아동용마스크"];
        var umbrella = ["일반우산", "자동개폐우산", "유아용우산"];

        // Children's Clothing and Accessories
        var top = ["티셔츠", "긴팔", "셔츠", "후드티", "니트티"];
        var bottom = ["바지", "반바지", "치마"];
        var underwear = ["팬티", "드로워즈", "속바지", "민소매", "내복"];
        var outerwear = ["점퍼", "자켓", "패딩", "후드집업"];
        var shoes = ["운동화", "샌들", "장화", "스니커즈"];
        var accessories = ["모자", "스카프", "장갑", "양말"];

        // Toys and Educational Items
        var newbornToys = ["모빌", "시각자극완구", "소리자극완구"];
        var educationalToys = [
          "플레이매트",
          "블록및조립",
          "숫자및알파벳",
          "퍼즐",
          "실험완구",
        ];
        var dolls = ["캐릭터인형", "동물인형"];
        var characterToys = ["만화완구", "디즈니완구"];

        // Safety Products
        var safetyGate = ["머리보호대", "엉덩이보호대", "무픞보호대"];
        var lock = ["문형안전문", "난간형안전문", "울타리형안전문"];
        var safetyItems = [
          "콘센트잠금장치",
          "서랍잠금장치",
          "가전제품용잠금장치",
        ];

        // Children's Furniture
        var bed = ["싱글침대", "접이식침대", "캐노피침대", "난간형침대"];
        var playFurniture = ["놀이테이블", "놀이책상의자", "놀이주방"];
        var accessory = ["의자쿠션", "보호커버", "정리함", "컵홀더"];
        var desk = ["고정형책상", "접이식책상", "높이조절책상"];
        var chair = [
          "나비의자",
          "접이식의자",
          "나무의자",
          "플라스틱의자",
          "책상의자세트",
        ];

        var selectItem1 = $("#select2").val();
        var changeItem1;

        if (selectItem1 == "임산부복대") {
          changeItem1 = bellyBand;
        } else if (selectItem1 == "스킨케어") {
          changeItem1 = skinCare;
        } else if (selectItem1 == "임부복") {
          changeItem1 = maternityClothes;
        } else if (selectItem1 == "산후용품") {
          changeItem1 = postpartumSupplies;
        } else if (selectItem1 == "구강용품") {
          changeItem1 = oralCareProducts;
        } else if (selectItem1 == "목욕용품") {
          changeItem1 = bathProducts;
        } else if (selectItem1 == "위생용품") {
          changeItem1 = hygieneProducts;
        } else if (selectItem1 == "세탁용품") {
          changeItem1 = laundryProducts;
        } else if (selectItem1 == "유아스킨케어") {
          changeItem1 = babySkinCare;
        } else if (selectItem1 == "분유") {
          changeItem1 = formulaMilk;
        } else if (selectItem1 == "이유식") {
          changeItem1 = babyFood;
        } else if (selectItem1 == "유아음료") {
          changeItem1 = babyDrinks;
        } else if (selectItem1 == "유아간식") {
          changeItem1 = babySnacks;
        } else if (selectItem1 == "유모차") {
          changeItem1 = stroller;
        } else if (selectItem1 == "아기띠") {
          changeItem1 = babyCarrier;
        } else if (selectItem1 == "보호대") {
          changeItem1 = guard;
        } else if (selectItem1 == "마스크") {
          changeItem1 = mask;
        } else if (selectItem1 == "우산") {
          changeItem1 = umbrella;
        } else if (selectItem1 == "상의") {
          changeItem1 = top;
        } else if (selectItem1 == "하의") {
          changeItem1 = bottom;
        } else if (selectItem1 == "내의") {
          changeItem1 = underwear;
        } else if (selectItem1 == "아우터") {
          changeItem1 = outerwear;
        } else if (selectItem1 == "신발") {
          changeItem1 = shoes;
        } else if (selectItem1 == "잡화") {
          changeItem1 = accessories;
        } else if (selectItem1 == "신생아완구") {
          changeItem1 = newbornToys;
        } else if (selectItem1 == "교육완구") {
          changeItem1 = educationalToys;
        } else if (selectItem1 == "인형") {
          changeItem1 = dolls;
        } else if (selectItem1 == "캐릭터완구") {
          changeItem1 = characterToys;
        } else if (selectItem1 == "보호대") {
          changeItem1 = safetyGate;
        } else if (selectItem1 == "안전문") {
          changeItem1 = lock;
        } else if (selectItem1 == "잠금장치") {
          changeItem1 = safetyItems;
        } else if (selectItem1 == "침대") {
          changeItem1 = bed;
        } else if (selectItem1 == "놀이가구") {
          changeItem1 = playFurniture;
        } else if (selectItem1 == "소품") {
          changeItem1 = accessory;
        } else if (selectItem1 == "책상") {
          changeItem1 = desk;
        } else if (selectItem1 == "의자") {
          changeItem1 = chair;
        }

        $("#select3").empty();

        for (var count1 = 0; count1 < changeItem1.length; count1++) {
          var option1 = $("<option>" + changeItem1[count1] + "</option>");
          $("#select3").append(option1);
        }
      }
      
      $(document).ready(function () {
  	    $('form').submit(function (e) {
  	        e.preventDefault(); // 기본 폼 제출 동작을 막습니다.

  	        // 사용자에게 먼저 확인을 받기 위한 대화상자 표시
  	        var userConfirmation = confirm('상품을 수정하시겠습니까?');

  	        if (userConfirmation) {
  	            // 파일 업로드와 다른 필드를 서버로 전송합니다.
  	            $.ajax({
  	                url: $(this).attr('action'),
  	                type: $(this).attr('method'),
  	                data: new FormData(this),
  	                processData: false,
  	                contentType: false,
  	                success: function (response) {
  	                    if (response === 'failure') { // 서버 응답이 'failure'인 경우
  	                        alert('상품 입력란을 다시 확인해주세요.');
  	                        // 실패 시 현재 페이지에 머무릅니다.
  	                    } else {
  	                        alert('상품이 성공적으로 수정되었습니다.');
  	                        window.location.href = "${contextPath}/seller/listSellerGoods.do?page=sellerPage";
  	                        // 성공 시 다른 페이지로 이동합니다.
  	                    }
  	                },
  	                error: function () {
  	                    alert('상품 입력란을 다시 확인해주세요.');
  	                    // 오류 시 현재 페이지에 머무릅니다.
  	                },
  	            });
  	        } else {
  	            // 사용자가 취소한 경우 아무 작업도 수행하지 않음
  	        }
  	    });
  	});
    </script>
  </head>
  <body>
  
        <form
            action="${contextPath}/seller/modgoods.do"
            method="post"
            enctype="multipart/form-data"
        >
        <div class="bordered-container">
    <br />
    <h1 style="text-align:center;">상품 수정하기</h1>
    <br /><br />

    <div id="detail_table" style="margin-left: 37%">
      
        <table>
        <input type="hidden" name="goods_id" value="${goodsInfo.goods_id}"/>
          <tbody>
            <!-- 상품명 -->
            <tr>
              <td class="fixed">상품명</td>
		        <td class="active">
		            <input type="text" name="goods_title" value="${goodsInfo.goods_title}" />
		        </td>
            </tr>
            <!-- 판매가 -->
            <tr class="dot_line">
			    <td class="fixed">판매가</td>
			    <td class="active">
			        <input type="text" name="goods_price" value="${goodsInfo.goods_price}" />
			    </td>
			</tr>
            <!-- 재고 -->
            <tr>
			    <td class="fixed">재고</td>
			    <td class="fixed">
			        <input type="text" name="goods_stock" value="${goodsInfo.goods_stock}" />
			    </td>
			</tr>
            <!-- 카테고리 -->
            <tr class="dot_line">
              <td class="fixed">카테고리</td>
              <td class="fixed">
                <select
                  style="text-align: center"
                  name="main_category"
                  id="select1"
                  onchange="itemChange()"
                >
                  	<option value="">카테고리 선택</option>
				    <option value="출산준비" ${goodsInfo.main_category == '출산준비' ? 'selected' : ''}>출산준비</option>
				    <option value="생활용품" ${goodsInfo.main_category == '생활용품' ? 'selected' : ''}>생활용품</option>
				    <option value="유아식품" ${goodsInfo.main_category == '유아식품' ? 'selected' : ''}>유아식품</option>
				    <option value="외출용품" ${goodsInfo.main_category == '외출용품' ? 'selected' : ''}>외출용품</option>
				    <option value="아동패션" ${goodsInfo.main_category == '아동패션' ? 'selected' : ''}>아동패션</option>
				    <option value="완구/교구" ${goodsInfo.main_category == '완구/교구' ? 'selected' : ''}>완구/교구</option>
				    <option value="안전용품" ${goodsInfo.main_category == '안전용품' ? 'selected' : ''}>안전용품</option>
				    <option value="아동가구" ${goodsInfo.main_category == '아동가구' ? 'selected' : ''}>아동가구</option>
                  
                </select>
                <select
                  style="text-align: center"
                  name="middle_category"
                  id="select2"
                  onchange="itemChange2()"
                >
                <option>${goodsInfo.middle_category}</option>
                </select>

                <select
                  style="text-align: center"
                  name="sub_category"
                  id="select3"
                >
                <option>${goodsInfo.sub_category}</option>
                </select>
              </td>
            </tr>
            <!-- 사용 연령 -->
            <tr class="dot_line">
              <td class="fixed">사용 연령</td>
              <td class="fixed">
                <select style="text-align: center" name="age_range">
                <option>${goodsInfo.age_range}</option>
                  	<option value="사용 연령" ${goodsInfo.age_range == '사용 연령' ? 'selected' : ''}>사용 연령</option>
				    <option value="0~12개월" ${goodsInfo.age_range == '0~12개월' ? 'selected' : ''}>0~12개월</option>
				    <option value="12~24개월" ${goodsInfo.age_range == '12~24개월' ? 'selected' : ''}>12~24개월</option>
				    <option value="24~36개월" ${goodsInfo.age_range == '24~36개월' ? 'selected' : ''}>24~36개월</option>
				    <option value="36개월 이상" ${goodsInfo.age_range == '36개월 이상' ? 'selected' : ''}>36개월 이상</option>
                </select>
              </td>
            </tr>
            <!-- 상품 옵션 -->
            <tr>
              <td class="fixed">상품 옵션</td>
              <td>
                <input type="text" name="goods_option1" value="${goodsInfo.goods_option1}" />
		        <input type="text" name="goods_option2" value="${goodsInfo.goods_option2}" />
		        <input type="text" name="goods_option3" value="${goodsInfo.goods_option3}" />
		        <input type="text" name="goods_option4" value="${goodsInfo.goods_option4}" />
		        <input type="text" name="goods_option5" value="${goodsInfo.goods_option5}" />
              </td>
            </tr>
            <!-- ... 기타 폼 요소들 추가 ... -->
          </tbody>
        </table>
        </div>
        <div class="clear"></div>
        <br /><br /><br />
        <div style="text-align-last: left;
    margin: -465px 0px -400px 20px; " >
    <label for="goods_image_name1"style="display: block; margin-left: 120px; margin-bottom: 10px;"><b>메인 이미지</b></label>
    <input type="file" name="goods_image_name1" style="position: absolute;margin: 340px 0px 00px 620px;left: 55px;top: 10px;"/>
    <div style="width: 320px; height: 320px; margin-left: 10px; margin-top: 50px; position: relative;">
    <div style="border: 1px dashed #000 ; width: 320px; height: 320px; position: absolute; top: 0; left: -10px;">
    <div class="file-preview1" style="width: 310px; height: 310px; overflow: hidden;">
    
        <img src="${contextPath}/thumbnails.do?goods_id=${goodsInfo.goods_id}&fileName=${goodsInfo.goods_image_name1}" style="width: 300px;height: 300px;margin: 10px; border-radius: 20%;"> </a></td>
    </div>
    </div>
	</div>
	</div>
	<div style="text-align-last: center;">
	    <label for="goods_image_name2"style="display: block;margin-bottom: 10px; margin-top:410px;"><b>상세 이미지</b></label>
	    <input type="file" name="goods_image_name2"style="margin-bottom: 20px;" />
	    <div class="file-preview2">
	        <img src="${contextPath}/thumbnails.do?goods_id=${goodsInfo.goods_id}&fileName=${goodsInfo.goods_image_name2}" style="width: 500px; height: auto; margin-bottom: 50px;"> </a></td>
	    </div>
	</div>
        <input style="margin-bottom: 20px;" type="submit" value="수정하기" />
        <input type="button" value="뒤로가기" onclick="history.back();" />
        <div class="clear"></div>
      </form>
      
    </div>
  </body>
</html>

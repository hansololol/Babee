<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous"
    ></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <title>회색 박스</title>
    <style>
      .square-container1,
      .square-container2,
      .square-container3,
      .square-container4 {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        margin: 0 300px 0px 200px;
        max-width: 1600px;
      }
      .square {
        width: calc(7% + 60px); /* 4개씩 정렬하므로 25%로 설정, 여백 제거 */
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

      #back_baby {
        background-color: rgb(255, 250, 245);
        background-image: url("/image/m_visual_01.jpg");
        height: 300px;
        background-repeat: no-repeat;
        background-size: contain;
        background-position: 330px center;
        position: relative;
        transition: 1s;
      }
      .info_grow {
        position: absolute;
        top: 160px;
        left: 350px;
        font-size: 40px;
      }
      .info_detail {
        position: absolute;
        top: 220px;
        left: 350px;
        text-align: left;
      }
      #buttonClass1 {
        float: right;
        background-color: rgba(255, 162, 162, 0.5);
        margin-right: 480px;
        width: 150px;
        height: 150px;
        align-items: center;
        padding: 2%;
        cursor: pointer;
      }
      #buttonClass2 {
        float: right;
        background-color: rgba(255, 175, 101, 0.5);
        width: 150px;
        height: 150px;
        align-items: center;
        padding: 2%;
        cursor: pointer;
      }
      #buttonClass3 {
        float: right;
        background-color: rgba(61, 138, 112, 0.5);
        margin-right: 480px;
        width: 150px;
        height: 150px;
        align-items: center;
        padding: 1%;
        cursor: pointer;
      }
      #buttonClass4 {
        float: right;
        background-color: rgba(152, 248, 88, 0.5);
        width: 150px;
        height: 150px;
        align-items: center;
        padding: 2%;
        cursor: pointer;
      }
      #babyInfoAll {
        border-top: 1px solid gainsboro;
        border-bottom: 1px solid gainsboro;
      }

      .main_Snsbox {
        overflow: hidden;
        width: 1100px;
        margin: 33px 0px 34px 316px;
      }

      .main_Snsbox ul {
        margin: -20px 0 0 -20px;
      }

      .main_Snsbox li {
        position: relative;
        float: left;
        width: calc(25% - 20px);
        margin: 20px 0 0 20px;
        height: 65px;
        border: 1px solid #d6d6d6;
      }

      .main_Snsbox li:before {
        content: "";
        display: block;
        position: absolute;
        right: 20px;
        top: 50%;
        margin-top: -7px;
        width: 7px;
        height: 14px;
        background: url(/img/main/icon_arr_s.png) no-repeat center;
      }

      .main_Snsbox li a {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        padding-left: 22px;
        text-decoration: none;
      }
      .main_Snsbox li strong {
        color: #393940;
        font-weight: 600;
        font-size: 16px;
        letter-spacing: -0.03em;
      }
      .txt_b {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 25px;
      }
      #hospital-scroller {
        position: relative;
      }
      .margin-all-0-auto {
        margin: 0 auto;
      }
      .height-78 {
        height: 70px;
      }
      .width-100p {
        width: 100%;
      }
      .board-bg-f5f5f5 {
        background-color: #f5f5f5;
      }
      #hospital-scroller .inner-hospital-scroll-area {
        overflow: hidden;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
      }
      #hospital-scroller ul {
        padding: 0;
        margin: 0;
        position: relative;
      }
      #hospital-scroller li {
        padding: 0;
        margin: 0px 10px;
        list-style-type: none;
        position: absolute;
      }
    </style>
    <script>
      function fade(obj) {
        if (obj == "buttonClass2") {
          $(".square-container1").css("display", "flex");

          $(".square-container2").css("display", "none");
          $(".square-container3").css("display", "none");
          $(".square-container4").css("display", "none");
          $(".info_grow").text("임신");
          $(".info_detail").html(
            "아이가 있어 행복한 사회<br>Babee가 함께 만들어가겠습니다."
          );

          $("#back_baby").css({
            background: "url(/image/m_visual_01.jpg)",
            "background-repeat": "no-repeat",
            "background-position": "330px center",
          });
        }
        if (obj == "buttonClass1") {
          $(".square-container2").css("display", "flex");
          $(".square-container1").css("display", "none");
          $(".square-container3").css("display", "none");
          $(".square-container4").css("display", "none");
          $(".info_grow").text("출산");
          $(".info_detail").html(
            "사랑하는 아이를 기르는 일, <br>Babee가 함께하겠습니다."
          );

          $("#back_baby").css({
            background: "url(/image/m_visual_02.jpg)",
            "background-repeat": "no-repeat",
            "background-position": "330px center",
          });
        }
        if (obj == "buttonClass4") {
          $(".square-container3").css("display", "flex");
          $(".square-container1").css("display", "none");
          $(".square-container2").css("display", "none");
          $(".square-container4").css("display", "none");
          $(".info_grow").text("육아");
          $(".info_detail").html("아이의 미래<br>Babee가 함께 키워갑니다.");

          $("#back_baby").css({
            background: "url(/image/m_visual_03.jpg)",
            "background-repeat": "no-repeat",
            "background-position": "330px center",
          });
        }
        if (obj == "buttonClass3") {
          $(".square-container4").css("display", "flex");
          $(".square-container2").css("display", "none");
          $(".square-container1").css("display", "none");
          $(".square-container3").css("display", "none");
          $(".info_grow").text("어린이집/유치원");
          $(".info_detail").html(
            "사랑하는 아이를 기르는 일, <br>Babee가 함께하겠습니다"
          );
          $("#back_baby").css({
            background: "url(/image/m_visual_04.jpg)",
            "background-repeat": "no-repeat",
            "background-position": "330px center",
          });
        }
      }
    </script>
  </head>
  <body>
    <br /><br />
    <div id="back_baby">
      <p class="info_grow">임신</p>
      <p class="info_detail">
        아이가 있어 행복한 사회<br />Babee가 함께 만들어가겠습니다.
      </p>
      <div id="buttonClass1" onclick="fn:fade(this.id)">
        <img
          src="/image/free-icon-baby-3686089.png"
          alt="hospiter"
          width="60px"
          height="60px"
        /><br />
        <p>출산</p>
      </div>
      <div id="buttonClass2" onclick="fn:fade(this.id)">
        <img
          src="/image/baby.png"
          alt="hospiter"
          width="60px"
          height="60px"
        /><br />
        <p>임신</p>
      </div>
      <div style="clear: both"></div>
      <div id="buttonClass3" onclick="fn:fade(this.id)">
        <img
          src="/image/school.png"
          alt="hospiter"
          width="60px"
          height="60px"
        /><br />
        <p>어린이집<br />유치원</p>
      </div>
      <div id="buttonClass4" onclick="fn:fade(this.id)">
        <img
          src="/image/free-icon-sprout-5077851.png"
          alt="hospiter"
          width="60px"
          height="60px"
        /><br />
        <p>육아</p>
      </div>
    </div>

    <!--정보 전체 묶기-->
    <div id="babyInfoAll">
      <div class="square-container1">
        <p style="text-align: left; float: left; display: flex;
        align-items: center;">
          임신관련<br />
          주요 서비스
        </p>

        <div class="square" onclick="openPopup('../babymap.jsp')">
          <img
            src="/image/free-icon-notebook-3425983.png"
            width="50px"
            height="50px"
          />
          <span>임신계획</span>
        </div>
        <div class="square" onclick="openPopup('../labor.jsp')">
          <img
            src="/image/baby.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>출산징후</span>
        </div>
        <div class="square" onclick="openPopup('../hosmap.jsp')">
          <img
            src="/image/hoss.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>근처산부인과</span>
        </div>

        <div class="square" onclick="openPopup('../proadvice.jsp')">
          <img
            src="/image/consult.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>전문가 상담</span>
        </div>
        <div class="square" onclick="openPopup('../injection.jsp')">
          <img
            src="/image/inoculation.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>난임</span>
        </div>

        <div class="square" onclick="openPopup('../kidmap.jsp')">
          <img
            src="/image/free-icon-heart-check-5565396.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>유산</span>
        </div>
      </div>

      <!--출산정보-->

      <div class="square-container2" style="display: none">
        <p style="text-align: left; float: left; display: flex;
        align-items: center;">
          출산관련<br />
          주요 서비스
        </p>
        <div class="square" onclick="openPopup('../hosmap.jsp')">
          <img
            src="/image/free-icon-baby-feeder-4745134.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>출산준비</span>
        </div>

        <div class="square" onclick="openPopup('../labor.jsp')">
          <img
            src="/image/baby.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>출산징후</span>
        </div>

        <div class="square" onclick="openPopup('../proadvice.jsp')">
          <img
            src="/image/consult.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>전문가 상담</span>
        </div>

        <div class="square" onclick="openPopup('../babymap.jsp')">
          <img
            src="/image/hoss.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>분만</span>
        </div>
        <div class="square" onclick="openPopup('../injection.jsp')">
          <img
            src="/image/inoculation.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>산후관리</span>
        </div>

        <div class="square" onclick="openPopup('../kidmap.jsp')">
          <img
            src="/image/free-icon-notebook-3425983.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>출산예정일</span>
        </div>
      </div>

      <!--육아정보-->

      <div class="square-container3" style="display: none">
        <p style="text-align: left; float: left; display: flex;
        align-items: center;">
          육아정보<br />
          주요 서비스
        </p>
        <div class="square" onclick="openPopup('../hosmap.jsp')">
          <img
            src="/image/free-icon-family-1590644.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>함께하는양육</span>
        </div>

        <div class="square" onclick="openPopup('../labor.jsp')">
          <img
            src="/image/free-icon-puzzle-piece-5542437.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>양육갈등해결하기</span>
        </div>

        <div class="square" onclick="openPopup('../proadvice.jsp')">
          <img
            src="/image/consult.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>전문가 상담</span>
        </div>

        <div class="square" onclick="openPopup('../babymap.jsp')">
          <img
            src="/image/hoss.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>병의원찾기</span>
        </div>
        <div class="square" onclick="openPopup('../injection.jsp')">
          <img
            src="/image/inoculation.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>접종정보</span>
        </div>

        <div class="square" onclick="openPopup('../kidmap.jsp')">
          <img
            src="/image/play.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>키즈카페</span>
        </div>
      </div>

      <!--어린이집, 유치원정보-->

      <div class="square-container4" style="display: none">
        <p style="text-align: left; float: left; display: flex;
        align-items: center;">
          유치원<br />
          주요 서비스
        </p>
        <div class="square" onclick="openPopup('../hosmap.jsp')">
          <img
            src="/image/free-icon-night-3248244.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>연장반 어린이집</span>
        </div>

        <div class="square" onclick="openPopup('../labor.jsp')">
          <img
            src="/image/free-icon-balance-1456031.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>어린이집 비교</span>
        </div>

        <div class="square" onclick="openPopup('../proadvice.jsp')">
          <img
            src="/image/consult.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>전문가 상담</span>
        </div>

        <div class="square" onclick="openPopup('../babymap.jsp')">
          <img
            src="/image/school.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>어린이집</span>
        </div>
        <div class="square" onclick="openPopup('../injection.jsp')">
          <img
            src="/image/school.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>유치원</span>
        </div>

        <div class="square" onclick="openPopup('../kidmap.jsp')">
          <img
            src="/image/play.png"
            alt="hospiter"
            width="50px"
            height="50px"
          />
          <span>키즈카페</span>
        </div>
      </div>
    </div>

    <!--도움 사이트 모음-->
    <section class="main_Snsbox">
      <ul>
        <li>
          <a href="https://www.facebook.com/population79/" target="_blank"
            ><strong
              ><span><img src="/image/다운로드 (1).png" width="40px" /></span>
              식품안전나라</strong
            ></a
          >
        </li>
        <li>
          <a href="http://www.childcare.go.kr/" target="_blank"
            ><strong
              ><span
                ><img src="/image/아이사랑+로고+가로형.jpg" width="50px"
              /></span>
              아이사랑사이트</strong
            ></a
          >
        </li>
        <li>
          <a href="https://cafe.naver.com/skybluezw4rh"
            ><strong
              ><span><img src="/image/다운로드.jpg" width="40px" /></span>
              맘이베베</strong
            ></a
          >
        </li>
        <li>
          <a href="https://sooyusil.com/?menuno=402" target="_blank"
            ><strong
              ><span
                ><img src="/image/화면 캡처 2023-09-07 152950.png" width="40px"
              /></span>
              수유정보 알리미</strong
            ></a
          >
        </li>
        <li>
          <a href="https://central.childcare.go.kr/" target="_blank"
            ><strong
              ><span><img src="/image/images.png" width="60px" /></span>
              육아종합지원센터</strong
            ></a
          >
        </li>
        <li>
          <a href="http://www.loveplan.kr/main/index.html" target="_blank"
            ><strong
              ><span><img src="/image/다운로드 (1).jpg" width="40px" /></span>
              러브플랜</strong
            ></a
          >
        </li>
        <li>
          <a href="https://idolbom.go.kr/front/" rel="modal:open"
            ><strong
              ><span
                ><img src="/image/화면 캡처 2023-09-07 153556.png" width="40px"
              /></span>
              아이돌봄서비스</strong
            ></a
          >
        </li>
        <li>
          <a href="https://sanhujori.kohi.or.kr" target="_blank"
            ><strong
              ><span><img src="/image/다운로드.png" width="40px" /></span>
              산후조리교육</strong
            ></a
          >
        </li>
      </ul>
    </section>

    <div class="txt_b">Babee는 아래 병원과 함께합니다.</div>

    <div
      id="hospital-scroller"
      class="board-bg-f5f5f5 width-100p height-78 margin-all-0-auto"
    >
      <div class="inner-hospital-scroll-area" id="hospital-scroller_area">
        <ul>
          <li style="left: 0px">
            <img
              src="/image/img_hospital70393.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.dumc.or.kr/index00.jsp")'
            />
          </li>

          <li style="left: 175px">
            <img
              src="/image/img_hospital70318.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.rmh.co.kr/")'
            />
          </li>

          <li style="left: 350px">
            <img
              src="/image/img_hospital70379.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.heryoojae.com/")'
            />
          </li>

          <li style="left: 525px">
            <img
              src="/image/img_hospital70472.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.danalady.com")'
            />
          </li>

          <li style="left: 700px">
            <img
              src="/image/img_hospital70455.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.sarangmoa.co.kr")'
            />
          </li>

          <!--반복-->
          <li style="left: 875px">
            <img
              src="/image/img_hospital70393.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.yulobgyn.kr")'
            />
          </li>

          <li style="left: 1050px">
            <img
              src="/image/img_hospital70318.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.misoclinic.kr/")'
            />
          </li>

          <li style="left: 1225px">
            <img
              src="/image/img_hospital70379.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.smwomen.co.kr")'
            />
          </li>

          <li style="left: 1400px">
            <img
              src="/image/img_hospital70472.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://yeinwoman.co.kr/")'
            />
          </li>

          <li style="left: 1575px">
            <img
              src="/image/img_hospital70455.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
            />
          </li>
          <!--반복-->
          <li style="left: 1750px">
            <img
              src="/image/img_hospital70393.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.dumc.or.kr/index00.jsp")'
            />
          </li>

          <li style="left: 1925px">
            <img
              src="/image/img_hospital70318.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.misoclinic.kr/")'
            />
          </li>

          <li style="left: 2100px">
            <img
              src="/image/img_hospital70379.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://www.smwomen.co.kr")'
            />
          </li>

          <li style="left: 2275px">
            <img
              src="/image/img_hospital70472.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
              onclick='window.open("http://yeinwoman.co.kr/")'
            />
          </li>

          <li style="left: 2450px">
            <img
              src="/image/img_hospital70455.jpg"
              class="img-w155-h68 border-ebebeb"
              style="cursor: pointer"
              onerror="removeImg(this)"
            />
          </li>
          <!--반복-->
        </ul>
      </div>
    </div>
    <!-- JavaScript 코드 추가 -->
    <script>
      function openPopup(url) {
        window.open(url, "_blank", "width=900,height=600");
      }

      const container = document.getElementById("hospital-scroller_area");
      const containerScrollWidth = container.scrollWidth;

      window.addEventListener("load", () => {
        self.setInterval(() => {
          if (container.scrollLeft != containerScrollWidth) {
            container.scrollTo(container.scrollLeft + 2, 0);
          }
        }, 15);
      });
    </script>
    <br /><br /><br /><br />
  </body>
</html>

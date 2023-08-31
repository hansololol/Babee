<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" isELIgnored="false" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script
      type="text/javascript"
      src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.7/jquery.validate.min.js"
    ></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

    <script>
      function execDaumPostcode() {
        new daum.Postcode({
          oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ""; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
              extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== "" && data.apartment === "Y") {
              extraRoadAddr +=
                extraRoadAddr !== ""
                  ? ", " + data.buildingName
                  : data.buildingName;
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== "") {
              extraRoadAddr = " (" + extraRoadAddr + ")";
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if (fullRoadAddr !== "") {
              fullRoadAddr += extraRoadAddr;
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("member_zipcode").value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById("member_roadAddr").value = fullRoadAddr;
            document.getElementById("member_jibunAddr").value =
              data.jibunAddress;
          },
        }).open();
      }
      function checkMyId(val) {
        console.log(val);
        $.ajax({
          type: "POST",
          async: false,
          url: "${contextPath}/member/overlapped.do",
          data: { id: val },
          dataType: "text",
          success: function (data, textStatus) {
            if (data == "false") {
              $("#id_check").html(
                "<p style='color: green; text-align: left; margin-bottom: 0px;'>사용 가능한 아이디입니다</p>"
              );
            } else {
              $("#id_check").html(
                "<p style='color: red; text-align: left; margin-bottom: 0px;'>사용할 수 없는 아이디입니다</p><input type='hidden' value='notuse' id='notuse'>"
              );
            }
          },
          error: function (e) {
            console.log("error : ", e);
          },
        });
      }

      function toggleAllCheckboxes() {
        var allCheckbox = document.getElementById("allCheckbox");
        var checkboxes = document.querySelectorAll(".agreeCheckbox");

        for (var i = 0; i < checkboxes.length; i++) {
          checkboxes[i].checked = allCheckbox.checked;
        }
      }

      function onKeyPressLengthCheck(_this, maxLen) {
        var val = $("#" + _this.id).val();
        console.log(val.length);
        var keyCode = event.keyCode;
        if (keyCode == 8 || keyCode == 46) {
          return;
        }
        if (val.length < maxLen) {
          $("#id_check").html(
            "<p style='color: red; text-align: left; margin-bottom: 0px;'> 8자리 이상 아이디를 입력해주세요</p>"
          );
        }
        if (val.length > maxLen) {
          $("#id_check").html("");
          checkMyId(val);
        }
      }

      function submitButton(obj) {
        if ($('input[name="member_id"]').val().length < 8) {
          $('input[name="member_id"]').focus();
          return false;
        }
        if ($("#notuse").val() == "notuse") {
          $('input[name="member_id"]').focus();
          return false;
        }
        if ($('input[name="member_pw"]').val().length == 0) {
          $('input[name="member_pw"]').focus();
          return false;
        }
        if ($('input[name="member_email"]').val().length == 0) {
          $('input[name="member_email"]').focus();
          return false;
        }

        /* 이름 유효성 검사 */
        if ($('input[name="member_name"]').val().length == 0) {
          $('input[name="member_name"]').focus();
          return false;
        }
        if ($('input[type="checkbox"]').is(":checked") == false) {
          alert("정보 수집에 동의해야 가입가능합니다.");
          return false;
        }

        if (
          isNaN($('input[name="member_hp1"]').val()) ||
          isNaN($('input[name="member_hp2"]').val()) ||
          isNaN($('input[name="member_hp3"]').val())
        ) {
          alert("전화번호는 숫자만 입력 가능합니다.");
          $('input[name="member_hp1"]').focus();
          return false;
        }

        if (
          $('input[name="member_hp1"]').val().length == 0 ||
          $('input[name="member_hp2"]').val().length == 0 ||
          $('input[name="member_hp3"]').val().length == 0
        ) {
          $('input[name="member_hp1"]').focus();
          return false;
        }

        obj.submit();
      }
    </script>

    <style>
      .member_cont {
        padding: 20px 100px;
        border: 1px solid #dbdbdb;
        width: 690px;
        margin: 0 auto;
      }
      .join_input_sec > div {
        float: left;
      }
      .join_input_sec input {
        display: block;
        width: 280px;
        height: 36px;
        margin: 0 0 3px 16px;
        padding: 0 0 0 18px;
        border: 1px solid #d0d0d0;
        color: #979d9d;
      }

      .Personal_Data {
        margin: 0 auto;
        border-radius: 20px;
        border: 1px solid rgba(128, 128, 128, 0.25);
        width: 500px;
      }
    </style>
  </head>
  <body>
    <br /><br /><br /><br />
    <div class="content_box">
      <div class="member_wrap">
        <div class="member_tit">
          <h2>회원가입</h2>
        </div>

        <div class="member_cont">
          <form
            id="formjoin"
            method="post"
            action="${contextPath}/member/addMember.do"
            novalidate="novalidate"
          >
            <div class="member_join_box">
              <img src="/image/Babee_Logo.png" /><br /><br />
              <div class="join_input_sec">
                <table>
                  <tr>
                    <td width="150"><h4 align="center">기본정보</h4></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="150">
                      <p align="right">아이디 *</p>
                    </td>
                    <td width="300">
                      <input
                        type="text"
                        name="member_id"
                        id="member_id"
                        oninput="onKeyPressLengthCheck(this, 8)"
                      />
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td style="font-size: 13px">
                      <p
                        id="id_check"
                        style="
                          color: red;
                          text-align: left;
                          margin-left: 24px;
                          margin-bottom: 0px;
                        "
                      >
                        8자리 이상 아이디를 입력해주세요
                      </p>
                    </td>
                  </tr>
                  <tr>
                    <td width="150"><p align="right">비밀번호 *</p></td>
                    <td>
                      <input type="password" name="member_pw" required />
                    </td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">이름 *</p></td>
                    <td><input type="text" name="member_name" required /></td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">이메일 *</p></td>
                    <td><input type="email" name="member_email" required /></td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">일반전화</p></td>
                    <td>
                      <input
                        type="text"
                        name="member_tel1"
                        style="width: 75px; display: inline-block"
                      />
                      <input
                        type="text"
                        name="member_tel2"
                        style="width: 80px; display: inline-block"
                      />
                      <input
                        type="text"
                        name="member_tel3"
                        style="width: 80px; display: inline-block"
                      />
                    </td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">휴대전화 *</p></td>
                    <td>
                      <input
                        type="text"
                        name="member_hp1"
                        value="010"
                        style="width: 75px; display: inline-block"
                      />
                      <input
                        type="text"
                        name="member_hp2"
                        style="width: 80px; display: inline-block"
                      />
                      <input
                        type="text"
                        name="member_hp3"
                        style="width: 80px; display: inline-block"
                      />
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="150"><p align="right">주소</p></td>
                    <td>
                      <a
                        href="javascript:execDaumPostcode()"
                        style="
                          text-decoration: none;
                          color: black;
                          float: right;
                        "
                        >우편번호검색</a
                      >
                      <input
                        type="text"
                        placeholder="우편 번호"
                        width="120px"
                        style="margin-bottom: 5px"
                        name="member_zipcode"
                        id="member_zipcode"
                      />

                      <input
                        type="text"
                        placeholder="도로명 주소"
                        name="member_roadAddr"
                        id="member_roadAddr"
                        style="margin-bottom: 5px"
                      />
                      <input
                        type="text"
                        placeholder="지번 주소"
                        name="member_jibunAddr"
                        id="member_jibunAddr"
                        style="margin-bottom: 5px"
                      />
                      <input
                        type="text"
                        placeholder="나머지 주소"
                        name="member_namujiAddr"
                        id="member_namujiAddr"
                        style="margin-bottom: 15px"
                      />
                    </td>
                  </tr>
                </table>
                <br />
                <table>
                  <tr>
                    <td width="150"><h4 align="right">추가정보</h4></td>
                    <td>&nbsp;</td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">성별</p></td>
                    <td
                      width="300"
                      style="display: flex; flex-direction: column"
                    >
                      <label
                        style="
                          display: inline-flex;
                          align-items: center;
                          margin-bottom: 5px;
                        "
                      >
                        <input
                          type="radio"
                          name="member_gender"
                          value="남자"
                          style="width: 20px; margin-right: 5px"
                        />남자
                        <input
                          type="radio"
                          name="member_gender"
                          value="여자"
                          style="width: 20px; margin-right: 5px"
                        />여자
                      </label>
                    </td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">생년월일</p></td>
                    <td>
                      <input
                        type="date"
                        name="member_birth"
                        value="2000-01-01"
                      />
                    </td>
                  </tr>

                  <tr>
                    <td width="150"><p align="right">자녀 성별</p></td>
                    <td
                      width="300"
                      style="display: flex; flex-direction: column"
                    >
                      <label
                        style="
                          display: inline-flex;
                          align-items: center;
                          margin-bottom: 5px;
                        "
                      >
                        <input
                          type="radio"
                          name="baby_gender"
                          value="남자"
                          style="width: 20px; margin-right: 5px"
                        />남자
                        <input
                          type="radio"
                          name="baby_gender"
                          value="여자"
                          style="width: 20px; margin-right: 5px"
                        />여자
                      </label>
                    </td>
                  </tr>

                  <tr>
                    <td width="150" height="100">
                      <p align="right">
                        자녀 나이
                        <span style="font-size: 8px; display: inline"
                          >(개월수)</span
                        >
                      </p>
                    </td>
                    <td
                      width="300"
                      style="display: flex; flex-direction: column"
                    >
                      <label
                        style="
                          display: inline-flex;
                          align-items: center;
                          margin-bottom: 5px;
                        "
                      >
                        <input
                          type="radio"
                          name="baby_age"
                          value="0~12"
                          style="width: 20px; margin-right: 5px"
                        />
                        0~12개월
                        <input
                          type="radio"
                          name="baby_age"
                          value="12~24"
                          style="width: 20px; margin-right: 5px"
                        />
                        12~24개월
                      </label>
                      <label
                        style="
                          display: inline-flex;
                          align-items: center;
                          margin-bottom: 5px;
                        "
                      >
                        <input
                          type="radio"
                          name="baby_age"
                          value="24~36"
                          style="width: 20px; margin-right: 5px"
                        />
                        24~36개월
                        <input
                          type="radio"
                          name="baby_age"
                          value="36~"
                          style="width: 20px; margin-right: 5px"
                        />
                        36개월 이상
                      </label>
                    </td>
                  </tr>
                </table>
              </div>
              <hr />
              <div>
                <label>
                  <h3>개인정보 수집·이용 안내</h3>
                  <table class="Personal_Data">
                    <tr>
                      <td width="50%" height="50">수집·이용목적</td>
                      <td>이용항목</td>
                    </tr>

                    <tr>
                      <td height="50">
                        온라인 서비스 회원가입, 본인식별, 정보수정, 불만처리,
                        서비스 관련 의사소통
                      </td>
                      <td>아이디, 비밀번호, 이름, 휴대전화번호, 이메일</td>
                    </tr>
                  </table>
                  <br />
                  <input
                    type="checkbox"
                    id="allCheckbox"
                    onchange="toggleAllCheckboxes()"
                    style="vertical-align: middle"
                  />
                  <h4
                    style="
                      display: inline-block;
                      margin: 0;
                      vertical-align: middle;
                    "
                  >
                    전체 동의
                  </h4>
                </label>
                <p>이용약관 및 개인정보 수집 및 이용에 모두 동의합니다.</p>
                <p>
                  &nbsp; <input type="checkbox" class="agreeCheckbox" /> 동의함
                  이용약관 동의 (필수)
                </p>
                <p>
                  &nbsp; <input type="checkbox" class="agreeCheckbox" /> 동의함
                  개인정보 수집 및 이용 동의 (필수)
                </p>
              </div>
              <br />
              <input
                type="button"
                class="member_join_order_btn"
                style="
                  width: 300px;
                  height: 50px;
                  background-color: #fef7dd;
                  color: black;
                  font-size: 16px;
                  font-weight: bold;
                  border: none;
                  border-radius: 8px;
                "
                value="회원가입"
                onclick="submitButton(this.form)"
              />
            </div>
          </form>
        </div>
      </div>
    </div>
    <br /><br /><br /><br /><br /><br /><br />
  </body>
</html>

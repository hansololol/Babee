<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%
request.setCharacterEncoding("utf-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>사업자 가입창</title>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

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
      .join_input_sec input,
      .join_input_sec select {
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
            document.getElementById("seller_zipcode").value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById("seller_roadAddr").value = fullRoadAddr;
            document.getElementById("seller_jibunAddr").value =
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

      function sellersubmitButton(obj) {
        if ($('input[name="seller_id"]').val().length < 8) {
          $('input[name="seller_id"]').focus();
          return false;
        }
        if ($("#notuse").val() == "notuse") {
          $('input[name="seller_id"]').focus();
          return false;
        }
        if ($('input[name="seller_pw"]').val().length == 0) {
          $('input[name="seller_pw"]').focus();
          return false;
        }
        if ($('input[name="seller_email"]').val().length == 0) {
          $('input[name="seller_email"]').focus();
          return false;
        }

        /* 이름 유효성 검사 */
        if ($('input[name="seller_name"]').val().length == 0) {
          $('input[name="seller_name"]').focus();
          return false;
        }
        //사업자 계좌 번호
        if ($('input[name="seller_bank_num"]').val().length == 0) {
          $('input[name="seller_bank_num"]').focus();
          return false;
        }
        //사업자 계좌주 명
        if ($('input[name="seller_bank_name"]').val().length == 0) {
          $('input[name="seller_bank_name"]').focus();
          return false;
        }
        //사업자 회사 명
        if ($('input[name="seller_company"]').val().length == 0) {
          $('input[name="seller_company"]').focus();
          return false;
        }
        //사업자 회사 명
        if ($('input[name="seller_img1"]').val().length == 0) {
          alert("사업자 등록증을 첨부해주세요");
          return false;
        }

        if (
          isNaN($('input[name="seller_hp1"]').val()) ||
          isNaN($('input[name="seller_hp2"]').val()) ||
          isNaN($('input[name="seller_hp3"]').val())
        ) {
          alert("전화번호는 숫자만 입력 가능합니다.");
          $('input[name="seller_hp1"]').focus();
          return false;
        }

        if (
          $('input[name="seller_hp1"]').val().length == 0 ||
          $('input[name="seller_hp2"]').val().length == 0 ||
          $('input[name="seller_hp3"]').val().length == 0
        ) {
          $('input[name="seller_hp1"]').focus();
          return false;
        }

        obj.submit();
      }
    </script>
  </head>
  <body>
    <br /><br /><br /><br />
    <div class="content_box">
      <div class="member_tit">
        <h2>사업자 가입</h2>
      </div>

      <div class="member_cont">
        <div class="member_join_box">
          <form
            id="formjoin"
            method="post"
            action="${contextPath}/seller/addSeller.do"
            novalidate="novalidate"
            enctype="multipart/form-data"
          >
            <img src="/image/Babee_Logo.png" /><br /><br />

            <div class="join_input_sec">
              <table>
                <tr>
                  <td width="150"><h4 align="center">기본정보</h4></td>
                  <td></td>
                </tr>
                <tr></tr>
                <tr>
                  <td width="200">
                    <p align="right">사업자 아이디 *</p>
                  </td>
                  <td width="300">
                    <input
                      type="text"
                      name="seller_id"
                      id="id"
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
                  <td width="200"><p align="right">비밀번호 *</p></td>
                  <td><input type="password" name="seller_pw" /></td>
                </tr>

                <tr>
                  <td width="200"><p align="right">이름 *</p></td>
                  <td><input type="text" name="seller_name" /></td>
                </tr>

                <tr>
                  <td width="200"><p align="right">이메일 *</p></td>
                  <td><input type="email" name="seller_email" /></td>
                </tr>

                <tr>
                  <td width="200"><p align="right">일반전화</p></td>
                  <td>
                    <input
                      type="text"
                      size="5"
                      name="seller_tel1"
                      style="width: 75px; display: inline-block"
                    />-<input
                      type="text"
                      size="5"
                      name="seller_tel2"
                      style="width: 75px; display: inline-block"
                    />-<input
                      type="text"
                      size="5"
                      name="seller_tel3"
                      style="width: 75px; display: inline-block"
                    />
                  </td>
                </tr>

                <tr>
                  <td width="200"><p align="right">휴대전화 *</p></td>
                  <td>
                    <input
                      type="text"
                      size="5"
                      name="seller_hp1"
                      style="width: 75px; display: inline-block"
                    />-<input
                      type="text"
                      size="5"
                      name="seller_hp2"
                      style="width: 75px; display: inline-block"
                    />-<input
                      type="text"
                      size="5"
                      name="seller_hp3"
                      style="width: 75px; display: inline-block"
                    />
                  </td>
                </tr>

                <tr>
                  <td width="200"><p align="right">주소</p></td>
                  <td>
                    <a
                      href="javascript:execDaumPostcode()"
                      style="text-decoration: none; color: black; float: right"
                      >우편번호검색</a
                    >
                    <input
                      type="text"
                      size="7"
                      placeholder="우편번호"
                      name="seller_zipcode"
                      id="seller_zipcode"
                    />

                    <input
                      type="text"
                      placeholder="도로명 주소"
                      name="seller_roadAddr"
                      id="seller_roadAddr"
                    />
                    <input
                      type="text"
                      placeholder="지번 주소"
                      name="seller_jibunAddr"
                      id="seller_jibunAddr"
                    />
                    <input
                      type="text"
                      placeholder="나머지 주소"
                      name="seller_namujiAddr"
                      id="seller_namujiAddr"
                      style="margin-bottom: 15px"
                    />
                  </td>
                </tr>
              </table>
            </div>
            <div style="margin-top: -20px">
              <table class="join_input_sec">
                <tr>
                  <td width="150"><h4 text-align="right">사업자 정보</h4></td>
                </tr>

                <tr>
                  <td><p align="right">은행정보</p></td>
                  <br />
                  <td>
                    <select name="seller_bank_com" style="font-size: 17px">
                      <option value="국민은행">국민은행</option>
                      <option value="국민은행">농협은행</option>
                      <option value="신한은행">신한은행</option>
                      <option value="카카오뱅크">카카오뱅크</option>
                      <option value="하나은행">하나은행</option>
                      <option value="우리은행">우리은행</option>
                      <option value="제일은행">제일은행</option></select
                    ><br />

                    통장번호<input type="text" name="seller_bank_num" /><br />

                    예금주명<input type="text" name="seller_bank_name" />
                  </td>
                </tr>

                <tr>
                  <td width="200">
                    <p align="right">
                      회사 정보<br />
                      <td>
                        회사 명<input type="text" name="seller_company" /><br />
                        회사 소개<textarea
                          style="width: 280px"
                          name="seller_company_info"
                        ></textarea>
                      </td>
                    </p>
                  </td>
                </tr>

                <tr>
                  <td>
                    <p align="right">필요 서류<br /></p>
                  </td>
                  <td>
                    사업자 등록증<input type="file" name="seller_img1" /><br />
                  </td>
                </tr>
              </table>
            </div>

            <br />
            <input
              type="button"
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
              value="사업자가입"
              onclick="sellersubmitButton(this.form)"
            />
          </form>
        </div>
      </div>
    </div>
    <br /><br /><br />
  </body>
</html>

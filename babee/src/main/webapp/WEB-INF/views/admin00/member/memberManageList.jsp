<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"    />
<!DOCTYPE html>
<html>
<head>
  
    <meta charset="UTF-8">
<title>회원 관리창(관리자)</title>
<style>
   
    #search {
        background-color: #FEF7DD;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 auto;
        width: 66%;
    }
    .search-container {
        display: flex;
        align-items: center;
        width: 70%;/* 검색 입력 영역이 늘어나도록 설정 */
    }
    .search-input {
        border: 1px solid #FFA500;
        text-align: center;
        padding: 5px;
        flex: 3; /* Make the text box wider */
        border-radius: 5px;
        margin-left: 20px;
        width: 400px;
         height: 30px;
    }
    .search-button {
        border: none;
        background: none;
        margin-top: -10px;
    }
    .menu-container {
            text-align: center; /* 가운데 정렬 */
            margin-top: 50px; /* 여기서 100px 만큼 아래로 이동합니다. */
           
        }

        .menu-options {
            display: flex; /* 옆으로 정렬 */
            gap: 100px; /* 사이 간격 */
            align-items: flex-end; /* 메뉴와 아래 정렬 요소 정렬 */
            justify-content: center; /* 가운데 정렬 */
        }

        .menu-option > a {
            font-weight: normal;
            text-decoration: none;
            color: #333;
        }

        /* 선택 시 스타일 */
        .menu-option:hover {
            font-weight: bold;
            text-decoration: underline;
        }
        .paging-container > a:hover {
            font-weight: bold;
        }
        
       .paging-container > a {
            color: black;
            text-decoration: none;
        }
        
        .paging-container {
            text-align: center;
            margin-top: 20px;
        }
        .paging-button {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f0f0f0;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }
        .paging-button:hover {
            background-color: #ccc;
        }

        .menu-container >hr, #foreachhr {
          margin:  1rem 25%;
         color: inherit;
        border: 0;
           border-top: var(--bs-border-width) solid;
         opacity: .25;
}

.member_list {
	width: 66%;
	margin: 0 auto;
}

a:hover {
	font-weight: bold;
	text-decoration: none;
}

a {
	color: black;
	text-decoration: none;
}

</style>

</head>
<body>
<div class="member_list" style="margin-left: 165px;">
		<H3 style="display: inline-grid;">Babee 회원 관리</H3>
		<div style="background:rgb(255, 255, 202);">
		
		<hr style="margin-top: revert">
		<table align="center" style="margin-left: 0px;">
			<tr>
				<td><img src="/image/people.png" width="60px;"
					style="display: inline-block; padding-left: 15px;" />
					<p style="display: inline-block;">${memberInfo.member_name}님
						안녕하세요</p></td>
			</tr>
		</table>
		<hr style="margin-bottom: 50px;">
		</div>
	<div>
        
    <div style="width: 100%;">
			<table class="seller-table" style="width: 100%;">
			<tr style="border-bottom:1px solid #ccc; ">
			<td width="80px;"><b>NO</b></td>
			<td width="150px;"><b>ID</b></td>
			<td width="150px;"><b>회원명</b></td>
            <td width="100px;"><b>활동상태</b></td>
			<td width="150px;"><b>가입일</b></td>
		</tr>
		
			
    <c:forEach var="member" items="${member}" varStatus="memberNO">
		<tr style="height: 50px; border-bottom:1px solid #ccc;">
			<td>${memberNO.count}</td>
			<td><a href="${contextPath}/admin/member/memberManageDetail.do?page=adminPage&member_id=${member.member_id}">${member.member_id}</a></td>
			<td>${member.member_name}</td>
            <td>${member.member_status}</td>
			<td>${member.member_joinDate}</td>
		</tr>
    </c:forEach>
    </table>


    <!-- 페이징 버튼 -->
    
    
    

    <div class="paging-container">
        <c:if test="${section>1}">
            <a class="paging-button" href="${contextPath}/admin/member/memberManageList.do?page=adminPage&section=${section-1}&pageNum=1">이전</a>
        
        </c:if>
        <c:forEach var="i" begin="1" end="5">
            <a class="paging-button" href="${contextPath}/admin/member/memberManageList.do?page=adminPage&section=${section}&pageNum=${i}">${((section-1)*5) + i}</a>
        
        </c:forEach>
        <a class="paging-button" href="${contextPath}/admin/member/memberManageList.do?page=adminPage&section=${section+1}&pageNum=1">다음</a>
    </div>


    </div>
    </div>
    </div>
    <br><br><br><br><br>
</body>
</html>
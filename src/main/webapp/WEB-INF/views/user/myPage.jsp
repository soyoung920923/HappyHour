<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <jsp:include page="../commons/head.jsp" />
<body>
<header>
		<jsp:include page="../commons/header.jsp" />
</header>
<main>

<br>
<br>
<!-- 내정보 -->
<div class="container">
	<div class="m-5 p-3 text-center"
		style="border: 1px solid gray; border-radius: 15px" id="font2">
		<h1 class="text-bold" id="font1">MyPage</h1>
		<br>
		  <input type="hidden" name="id" value="${loginUser.id}">

		<table class="table table-hover" id="mypageT">
			<tr>
				<th>이름</th>
				<td>${user.name}</td>
				<th>아이디</th>
				<td>${user.id}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${user.tel}</td>
				<th>이메일</th>
				<td>${user.email}</td>
			</tr>
			<tr>
				<th colspan="2">내 주소</th>
				<td colspan="2">(${user.postcode})&nbsp;${user.address}&nbsp;|&nbsp;${user.address_dt}</td>
			</tr>
		</table>
		<div style="text-align:right;">
		<label><a href="${pageContext.request.contextPath}/myboard?id=${user.id}" id="myBoard"><h4>My Q&A</h4></a></label>
		</div>
		<div class="container text-right">
				<button class="btn" id="edit"
					onclick="location.href='edit?origin_num=${user.origin_num}'">수정하기</button>
				<button class="btn" id="leave"
					onclick="leave(${user.origin_num})">탈퇴하기</button>
		</div>
		
		<!-- 버튼정렬div -->
	</div>
	<!-- 내정보 div -->
</div>

<!-- 삭제  form---------------- -->
<form name="pf" id="pf" method="post">
	<input type="hidden" name="origin_num" id="origin_num">
</form>
<!-- -------------------------------- -->

</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
</body>


<script type="text/javascript">
	function leave(num){
		if(confirm("탈퇴 하시겠습니까?")){
		var n = $('#origin_num').val(num);
		$('#pf').attr('action','${pageContext.request.contextPath}/del')
		$('#pf').submit();
		}
	}
</script>
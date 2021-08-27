<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
#mypageT th{
 font-family: 'Ubuntu', sans-serif;
}
</style>

<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <jsp:include page="../commons/head.jsp" />
	<link href='<c:url value="/resources/style/store.css"/>' rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
<main>
<br>
<br>
<!-- 내정보 -->
<div class="in list-in" style="width:70%;">
   <div class="card align-middle list-card photo">
	  <div class="card-body">	
		<h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">MyPage</h1>
		<br>
	    <!-- 내상태  -->
	    <div style="margin-right:20px;color:#E30F0C;">
		<c:if test="${user.user_dt==1}">
			<h5 class="text-right font-weight-bold">일반회원</h5>
		</c:if>
		<c:if test="${user.user_dt==2}">
			<h5 class="text-right font-weight-bold">스토어회원</h5>
		</c:if>
		<c:if test="${user.user_dt==4}">
			<h5 class="text-right font-weight-bold">탈퇴회원</h5>
		</c:if>
		<c:if test="${user.user_dt==9}">
			<div style="text-align:right; margin-right:7px;margin-bottom: 0.5rem;font-size:20px;">
			<span class="badge badge-primary">관리자</span>
			</div>
		</c:if>
	    </div>
		
		  <input type="hidden" name="id" value="${loginUser.id}">

		<table class="table table-hover" id="mypageT">
			<tr>
				<th>이름</th>
				<td colspan="2">${user.name}</td>
				<th>아이디</th>
				<td colspan="2">${user.id}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td colspan="2">${user.tel}</td>
				<th>이메일</th>
				<td colspan="2">${user.email}</td>
			</tr>
			<tr>
				<th colspan="1">내 주소</th>
				<td colspan="4">(${user.postcode})&nbsp;${user.address}&emsp;&nbsp;${user.address_dt}</td>
			</tr>
		</table>
		<div style="text-align:right; margin-right:30px;">
		<label><a href="${pageContext.request.contextPath}/myboard?id=${user.id}" id="myBoard" ><h4 style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">My Q&A</h4></a></label>
		</div>
		<div class="container text-right">
				<button class="btn" id="edit"
					onclick="location.href='edit?origin_num=${user.origin_num}'">수정하기</button>
				<button class="btn" id="leave"
					onclick="leave(${user.origin_num})">탈퇴하기</button>
		</div>
		 
       </div>
	</div>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <jsp:include page="../commons/head.jsp" />
</head>
    <header>
		<jsp:include page="../commons/header.jsp" />
	</header>  
<body>

<main>
<br><br><br>
<div class="in" style=" margin-top: 10rem;">
   <div class="card align-middle"
        style="width: 30rem; border-radius: 20px; margin: 0 auto;">
			<div class="card-title" style="margin-top: 30px;">
				<h3 class="card-title text-center">비밀번호 찾기
					</h3>
	           </div>
	           <div class="card-body">     
	           	<form name="pwdSearch" id="pwdSearch" action="pwdSearchEnd" method="GET"
	           	onsubmit="return send()">              
					<label for="id" class="sr-only">아이디</label>
					 <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요." required style="margin-bottom: 0.5rem;">
					<label for="email" class="sr-only">이메일</label>
					 <input	type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요" required>
					 <br>
					<div class="form-group">
					<button class="btn btn-primary btn-block">확인</button>
					<a href="${pageContext.request.contextPath}/user/login"><button class="btn btn-primary btn-block">취소</button></a>
					</div>
				</form>
			</div>
		</div>
		</div>
</main>
	
    <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>

<script>
	function send() {
		if (!$('#id').val()) {
			alert('아이디를 입력하세요');
			$('#id').focus();
			return false;
		}
		if (!$('#email').val()) {
			alert('이메일을 입력 하세요');
			$('#email').focus();
			return false;
		}
		return true;
	}
</script>	
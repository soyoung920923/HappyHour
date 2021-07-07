<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/user/userIdSearchModal.jsp" %> 

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

<script>
$(document).ready(function() {
	// 1. 모달창 히든 불러오기
	$('#searchBtn').click(function() {
		$('#background_modal').modal('show');
	});
	// 2. 모달창 닫기 버튼
	$('.close').on('click', function() {
		$('#background_modal').hide();
	});
	// 3. 모달창 윈도우 클릭 시 닫기
	$(window).on('click', function() {
		if (event.target == $('#background_modal').get(0)) {
            $('#background_modal').hide();
         }
	});
});

var idV = "";
//닉네임 값 받고 출력하는 ajax
var idSearch = function(){
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/userSearch?name="
				+$('#name').val()+"&email="+$('#email').val(),
		success:function(data){
			if(data == 0){
				$('#id_value').text("일치하는 아이디가 없습니다.");	
			} else {
				$('#id_value').text(data);
				// 아이디값 별도로 저장
				idV = data;
			}
		}
	});
}
</script>
	
<main>
<br><br><br>
<div class="in" style=" margin-top: 10rem;">
   <div class="card align-middle"
        style="width: 30rem; border-radius: 20px; margin: 0 auto;">
			<div class="card-title" style="margin-top: 30px;">
				<h3 class="card-title text-center">아이디 찾기
					</h3>
	           </div>
	           <div class="card-body">                
					<label for="name" class="sr-only">이름</label>
					 <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력하세요." required style="margin-bottom: 0.5rem;">
					<label for="email" class="sr-only">이메일</label>
					 <input	type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요" required>
					 <br>
					<div class="form-group">
						<button id="searchBtn" type="button" onclick="idSearch()" class="btn btn-primary btn-block">확인</button>
					<a href="${pageContext.request.contextPath}/user/login"><button type="button" class="btn btn-primary btn-block">취소</button></a>
					</div>
			</div>
			</div>
		</div>
</main>	
	
    <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>

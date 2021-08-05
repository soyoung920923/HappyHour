<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <jsp:include page="../commons/head.jsp" />
<style>
	.card-title{
		color: #E30F0C;
	}
</style>
</head>
<body>

	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
 <main> 
<br><br><br>


	<div class="in" style="text-align: center; margin-top: 10rem;">
		<div class="card align-middle" style="width: 30rem; border-radius:20px; margin: 0 auto;">
			   <div class="card-title" style="margin-top: 30px;">
			      <h2 class="card-title text-center" id="logo">HAPPY HOUR
			      	<svg xmlns="http://www.w3.org/2000/svg" width="1.8rem" height="" fill="currentColor" class="bi bi-alarm-fill" viewBox="0 0 16 16">
				  		<path d="M6 .5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1H9v1.07a7.001 7.001 0 0 1 3.274 12.474l.601.602a.5.5 0 0 1-.707.708l-.746-.746A6.97 6.97 0 0 1 8 16a6.97 6.97 0 0 1-3.422-.892l-.746.746a.5.5 0 0 1-.707-.708l.602-.602A7.001 7.001 0 0 1 7 2.07V1h-.5A.5.5 0 0 1 6 .5zm2.5 5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5zM.86 5.387A2.5 2.5 0 1 1 4.387 1.86 8.035 8.035 0 0 0 .86 5.387zM11.613 1.86a2.5 2.5 0 1 1 3.527 3.527 8.035 8.035 0 0 0-3.527-3.527z"/>
					</svg>
			      </h2>
			   </div>
		   <div class="card-body">
		       <form action="${pageContext.request.contextPath}/login" name="loginF" method="POST">
				   <input title="아이디" type="text" name="id" placeholder="아이디를 입력하세요" style="vertical-align:10px; margin-bottom: 0.5rem;" class="form-control" required/>
				   <input title="비밀번호" type="password" name="password" placeholder="비밀번호를 입력하세요"  class="form-control" required/>
					 <div class="form-group">
						<span class="font-weight-bold text-white bg-dark"
							id="spanLoginCheck"></span>
					 </div>
					      <div class="save_id">
					      <label>
					        <input type="checkbox" id="saveId" name="saveId">아이디 저장
					      </label>
					      </div>
					      <div>
					       <a href="${pageContext.request.contextPath}/user/userSearch" style="color:#1F2229;">아이디</a>
					       /<a href="${pageContext.request.contextPath}/user/pwdSearch" style="color:#1F2229;">&nbsp;비밀번호 찾기</a>
					    </div>
				   <button type="submit" class="btn form-control" style=" margin-bottom: 0.5rem;">Login</button>
				  <!--  <button type="button" class="btn" onclick="kakaoLogin()" style="background-color:#FEE500;color:#191919;">Kakao Login</button> --> 
			</form>
		   </div>
		</div>
	</div>

</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
	
<script type="text/javascript">

	$(document).ready(function() {
		var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
		$("input[name='id']").val(userInputId);

		if ($("input[name='id']").val() != "") { 
			$("#saveId").attr("checked", true);
		}

		$("#saveId").change(function() { //체크 박스 ID 저장하기 체크 했을 때 
			if ($("#saveId").is(":checked")) { 
				var userInputId = $("input[name='id']").val();
				setCookie("userInputId", userInputId, 7); 
			} else { 
				deleteCookie("userInputId");
			}
		});

		$("input[name='id']").keyup(function() {
			if ($("#saveId").is(":checked")) { 
				var userInputId = $("input[name='id']").val();
				setCookie("userInputId", userInputId, 7); 
			}
		});
	});

	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}

	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) {
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1)
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}


/* 	window.Kakao.init('ba0ed2d064b8fe054898b59b89e74bf9');
	
	function kakaoLogin() {
		window.Kakao.Auth.login({ 
		    success: function(response) {
		    	console.log(response)
		        window.Kakao.API.request({
		           url: '/v2/user/me', 
		           success: (res) => {
		    	      const kakao_account = res.kakao_account;
		    	      console.log(kakao_account)
		    } 
		    }); 
		    	window.location.href='http://localhost:8090/happyhour/' 
		    }, 
		    fail: function(error) { 
		    	console.log(error); 
		    }
		   });
	} 
	 */
</script>

</body>
</html>

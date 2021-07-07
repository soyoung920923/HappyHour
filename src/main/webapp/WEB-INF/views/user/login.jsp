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
    <jsp:include page="../commons/head.jsp" />
</head>
<body>

	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
  
<br><br><br>

<div class="col-sm-8 text-center">
	<div class="in" style=" display: inline-block; margin-left: 40%;">
		<div class="card align-middle" style="width: 30rem; border-radius:20px;">
			   <div class="card-title" style="margin-top: 30px;">
			      <h2 class="card-title text-center" style="color:#E30F0C;">HAPPY HOUR</h2>
			   </div>
		   <div class="card-body">
		       <form action="${pageContext.request.contextPath}/login" name="loginF" method="POST">
				   <input title="아이디" type="text" name="id" placeholder="아이디를 입력하세요" style="vertical-align:10px;" required/><br>
				   <input title="비밀번호" type="password" name="password" placeholder="비밀번호를 입력하세요" required/>
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
				   <button type="submit">Login</button>
		      </form>
		   </div>
		</div>
	</div>
</div>

	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
	
<script>

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
</script>

</body>
</html>

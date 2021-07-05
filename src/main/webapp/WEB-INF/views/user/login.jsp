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
</head>
<body>
  
<br><br><br>

<div class="col-sm-8 text-center">
	<div class="in" style=" display: inline-block; margin-left: 40%;">
		<div class="card align-middle" style="width: 30rem; border-radius:20px;">
			   <div class="card-title" style="margin-top: 30px;">
			      <h2 class="card-title text-center" style="color:#E30F0C;">HAPPY HOUR</h2>
			   </div>
		   <div class="card-body">
		       <form action="${pageContext.request.contextPath}/login" method="POST">
				   <input title="아이디" type="text" name="id" value="${cookie.id.value}" placeholder="아이디를 입력하세요" style="vertical-align:10px;" required/><br>
				   <input title="비밀번호" type="password" name="password" placeholder="비밀번호를 입력하세요" required/>
					 <div class="form-group">
						<span class="font-weight-bold text-white bg-dark"
							id="spanLoginCheck"></span>
					 </div>
					      <div class="save_id">
					      <label for="saveId">
					        <input type="checkbox" id="saveId" name="saveId" ${checked}>아이디 저장</label>
					      </div>
					      <div>
					       <a href="${pageContext.request.contextPath}/user/idSearch" style="color:#1F2229;">아이디</a>
					       /<a href="${pageContext.request.contextPath}/user/pwdSearch" style="color:#1F2229;">&nbsp;비밀번호 찾기</a>
					    </div>
				   <button type="submit" class="btn">Login</button>
		      </form>
		   </div>
		</div>
	</div>
</div>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

</script>

</body>
</html>

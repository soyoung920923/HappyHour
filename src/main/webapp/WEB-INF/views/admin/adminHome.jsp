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
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
<main> 
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<div class="in list-in">
   <div class="card align-middle list-card photo">
	  <div class="card-body">	
		<h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Admin Page</h1>


		<nav class="navbar navbar-expand-sm bg-white navbar-white">
		    <%-- <a class="navbar-brand" href="#">${loginUser.name}님</a> --%>
		   <ul class="mr-auto">
		           <li class="nav-item">
		               <a class="nav-link" href="${pageContext.request.contextPath}/admin/userList">회원 관리</a>
		           </li>
		           <li class="nav-item">
		               <a class="nav-link" href="${pageContext.request.contextPath}/admin/boardList">게시판 관리</a>
		           </li>
		           <li class="nav-item">
		               <a class="nav-link" href="${pageContext.request.contextPath}/banner/list">배너 관리</a>
		            </li>
		
		        </ul>
		</nav>



    </div>
  </div>
</div>

</main>

	 <%-- <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
</body>

</html>


<style>
	.mr-auto{margin: 0 auto;}
	.nav-item{
	text-align: center;}
</style>


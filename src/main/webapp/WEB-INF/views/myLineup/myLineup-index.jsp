<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../commons/head.jsp"/>
	<link href='<c:url value="/resources/style/store.css"/>' rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp"/>
	</header>
	
	<main>
		<br><br><br>
		<div class="in list-in" >
			<a href="<c:url value='/lineup/list/1?userIdx=${userIdx}&myOrStore=myPage'/>">
				<div class="card align-middle list-card lineup-visit-btn lineup-index-btn">
					내 줄서기
				</div>
			</a>
			<a href="<c:url value='/lineup/list/2?userIdx=${userIdx}&myOrStore=myPage'/>">
				<div class="card align-middle list-card lineup-visit-btn lineup-index-btn">
					내 예약
				</div>
			</a>							
		</div>	
		<br><br><br><br>			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
<style>
	.lineup-visit-btn{
		text-align: center;
		cursor:pointer;
		border-color: #E30F0C;
		font-size: 2rem;
		color: #E30F0C;
		font-weight: bold;
		padding: 9rem 0;
	}
	.lineup-visit-btn:hover{
		background-color: #E30F0C;
		color: #fff;
	}
	.lineupNs-btn:hover{
		background-color: #1F2229;
		color: #fff;
	}
	#list-waiting{font-weight: normal; font-size: 1rem; line-height: 2;}
	.lineup-index-btn{
		width: 49.6%;
		display:inline-block;
	}
</style>
	
<script type="text/javascript">
	$(function(){
		
		
	});
	
</script>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body id="f-body">
	<div class="container footer-container">
		<h3 id="footer-logo">HAPPY HOUR <svg xmlns="http://www.w3.org/2000/svg" width="1.8rem" height="" fill="#666" class="bi bi-alarm-fill" viewBox="0 0 16 16">
				  <path d="M6 .5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1H9v1.07a7.001 7.001 0 0 1 3.274 12.474l.601.602a.5.5 0 0 1-.707.708l-.746-.746A6.97 6.97 0 0 1 8 16a6.97 6.97 0 0 1-3.422-.892l-.746.746a.5.5 0 0 1-.707-.708l.602-.602A7.001 7.001 0 0 1 7 2.07V1h-.5A.5.5 0 0 1 6 .5zm2.5 5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5zM.86 5.387A2.5 2.5 0 1 1 4.387 1.86 8.035 8.035 0 0 0 .86 5.387zM11.613 1.86a2.5 2.5 0 1 1 3.527 3.527 8.035 8.035 0 0 0-3.527-3.527z"/>
				</svg></h3>
		<p id="footer-contents">(주)해피아워 | 대표자: 이봉헌 | 대표번호: 010-1234-5678</p>
		<div id ="footer-login">
			<c:if test="${loginUser eq null}">
				<a href="${pageContext.request.contextPath}/user/login"><button>로그인</button></a>&nbsp;
				<a href="${pageContext.request.contextPath}/user/join"><button>회원가입</button></a>
			</c:if>
			<c:if test="${loginUser ne null}">
				<a href="${pageContext.request.contextPath}/user/logout"><button>로그아웃</button></a>&nbsp;
				<a href="${pageContext.request.contextPath}/user/myInfo?origin_num=${origin_num}"><button>마이페이지</button></a>
			</c:if>
		</div>
		
	</div>
</body>
</html>
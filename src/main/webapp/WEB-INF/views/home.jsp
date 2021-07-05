<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

${loginUser}

<br>
<br>
<c:if test="${loginUser eq null}">
<a href="${pageContext.request.contextPath}/user/login"><button>로그인</button></a>
<a href="${pageContext.request.contextPath}/user/join"><button>회원가입</button></a>
</c:if>
<c:if test="${loginUser ne null}">
<a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
<a href="${pageContext.request.contextPath}/user/myInfo?origin_num=${origin_num}">마이페이지</a>
</c:if>

</body>
</html>

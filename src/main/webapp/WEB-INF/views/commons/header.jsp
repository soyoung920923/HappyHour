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
<body>
	<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
        <div class="container-fluid">
          <form class="d-flex">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success" type="submit">Search</button>
          </form>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav me-auto mb-2 mb-md-0">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/happyhour">홈</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">식당</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">게시판</a>
              </li>
              <c:if test="${loginUser eq null}">
              	<li class="nav-item">
                	<a class="nav-link" href="${pageContext.request.contextPath}/user/login">Login</a>
             	</li>
			  </c:if>
			  <c:if test="${loginUser ne null}">
			  	<li class="nav-item">
                	<a class="nav-link" href="${pageContext.request.contextPath}/user/myInfo?origin_num=${origin_num}">My Page</a>
             	</li>
			  </c:if>
            </ul>
            <a class="navbar-brand" href="/happyhour" id="logo">
            	HAPPY HOUR
            	<svg xmlns="http://www.w3.org/2000/svg" width="1.8rem" height="" fill="currentColor" class="bi bi-alarm-fill" viewBox="0 0 16 16">
				  <path d="M6 .5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1H9v1.07a7.001 7.001 0 0 1 3.274 12.474l.601.602a.5.5 0 0 1-.707.708l-.746-.746A6.97 6.97 0 0 1 8 16a6.97 6.97 0 0 1-3.422-.892l-.746.746a.5.5 0 0 1-.707-.708l.602-.602A7.001 7.001 0 0 1 7 2.07V1h-.5A.5.5 0 0 1 6 .5zm2.5 5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5zM.86 5.387A2.5 2.5 0 1 1 4.387 1.86 8.035 8.035 0 0 0 .86 5.387zM11.613 1.86a2.5 2.5 0 1 1 3.527 3.527 8.035 8.035 0 0 0-3.527-3.527z"/>
				</svg>
            	
            </a>
          </div>
        </div>
      </nav>
      <div id="fixed-box">
      	<p id="go-top">
      		<a href="#">
      			<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="#F9EBE0" class="bi bi-arrow-up-circle-fill" viewBox="0 0 16 16">
  					<path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
				</svg>
			</a>
		</p>
		<div id="bottom-nav">			
			<ul id="bottom-nav-ul">
				<li class="bottom-nav-li on">전체</li>
				<li class="bottom-nav-li">한식</li>
				<li class="bottom-nav-li">분식</li>
				<li class="bottom-nav-li">중식</li>
				<li class="bottom-nav-li">패스트푸드</li>
				<li class="bottom-nav-li">양식</li>
				<li class="bottom-nav-li">카페/디저트</li>
				<li class="bottom-nav-li">일식</li>
			</ul>			
		</div>
      </div>
      <div class="bottom-nav-arrow" id="arrow-left">
			<i style='font-size:1.3rem' class='fas'>&#xf0d9;</i>
	  </div>
	 <div class="bottom-nav-arrow" id="arrow-right">
			<i style='font-size:1.3rem' class='fas'>&#xf0da;</i>
		</div>
      <script>
      	$(function(){
      		$('.go-top > a').click(function(){
      			$('body').animate({scrollTop:0},500);
      		});
      		
      		$('#arrow-left').click(function(){
      			$('#bottom-nav').animate({
    				scrollLeft: '-=100'
    			}, 200);
      		});
      		
      		$('#arrow-right').click(function(){
      			$('#bottom-nav').animate({
    				scrollLeft: '+=100'
    			}, 200);
      		});
      		
      	});
      </script>
</body>
</html>
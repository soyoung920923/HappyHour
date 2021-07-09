<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="commons/head.jsp" />
</head>
<body>
	<header>
		<jsp:include page="commons/header.jsp" />
	</header>
	<main>
		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#1F2229"/>           	
            </svg>
			<img class="banner-img" src="<c:url value='/resources/image/banner1.jpg'/>"/>
            <div class="container">
              <div class="carousel-caption text-start">
                <h1>Example headline.</h1>
                <p>Some representative placeholder content for the first slide of the carousel.</p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#1F2229"/></svg>
			<img class="banner-img" src="<c:url value='/resources/image/banner2.jpg'/>"/>
            <div class="container">
              <div class="carousel-caption">
                <h1>Another example headline.</h1>
                <p>Some representative placeholder content for the second slide of the carousel.</p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#1F2229"/></svg>
			<img class="banner-img" src="<c:url value='/resources/image/banner3.jpg'/>"/>
            <div class="container">
              <div class="carousel-caption text-end">
                <h1>One more for good measure.</h1>
                <p>Some representative placeholder content for the third slide of this carousel.</p>
              </div>
            </div>
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>


      <!-- Marketing messaging and featurettes
      ================================================== -->
      <!-- Wrap the rest of the page in another container to center all the content. -->
      <div class="container marketing" id="main-frame">   
        <!-- Three columns of text below the carousel -->
        <div class="row">
          <ul id="ul-category">
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list">전체</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/1">한식</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/2">분식</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/3">중식</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/4">패스트푸드</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/5">양식</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/6">카페/디저트</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/7">일식</a></li>
            <li class="li-category"><a class="btn btn-secondary btn-category" href="${pageContext.request.contextPath}/store/list/8">아시안</a></li>
          </ul>
        </div>
        <div class="row">
          <h3 id="pg-title"><span id="pg-title-logo">HAPPY HOUR <svg xmlns="http://www.w3.org/2000/svg" width="1.8rem" height="" fill="#E30F0C" class="bi bi-alarm-fill" viewBox="0 0 16 16">
				  <path d="M6 .5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1H9v1.07a7.001 7.001 0 0 1 3.274 12.474l.601.602a.5.5 0 0 1-.707.708l-.746-.746A6.97 6.97 0 0 1 8 16a6.97 6.97 0 0 1-3.422-.892l-.746.746a.5.5 0 0 1-.707-.708l.602-.602A7.001 7.001 0 0 1 7 2.07V1h-.5A.5.5 0 0 1 6 .5zm2.5 5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5zM.86 5.387A2.5 2.5 0 1 1 4.387 1.86 8.035 8.035 0 0 0 .86 5.387zM11.613 1.86a2.5 2.5 0 1 1 3.527 3.527 8.035 8.035 0 0 0-3.527-3.527z"/>
				</svg></span> BEST!</h3>
        </div>
        <div class="row">
          <div class="col-lg-4">
            <div class="food-img"><img src="<c:url value='/resources/image/salady.jpg'/>"/></div>
            <h2 class="img-title">식당이름</h2>
            <ul class="img-contents">
              <li>대표메뉴: </li>
              <li>전화번호: </li>
              <li>위치: </li>
            </ul>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <div class="food-img"><img src="<c:url value='/resources/image/gossinae.jpg'/>"/></div>
            <h2 class="img-title">식당이름</h2>
            <ul class="img-contents">
              <li>대표메뉴: </li>
              <li>전화번호: </li>
              <li>위치: </li>
            </ul>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <div class="food-img"><img src="<c:url value='/resources/image/kimchi.jpg'/>"/></div>
            <h2 class="img-title">식당이름</h2>
            <ul class="img-contents">
              <li>대표메뉴: </li>
              <li>전화번호: </li>
              <li>위치: </li>
            </ul>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div><!-- /.col-lg-4 -->
        </div><!-- /.row -->
      </div><!-- /.container -->
	</main>
	
	 <footer>
		<jsp:include page="commons/footer.jsp"/>
	</footer>
	
	
<script type="text/javascript">
	$(function(){
		$(window).scroll(function(){
			$('.col-lg-4').eq(0).fadeIn(300);
			$('.col-lg-4').eq(1).fadeIn(450);
			$('.col-lg-4').eq(2).fadeIn(600);
		});
		
	});
</script>
</body>

</html>
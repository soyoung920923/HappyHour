<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../commons/head.jsp" />
	<link href='<c:url value="/resources/style/store.css"/>' rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
	
	<main>
			<br><br><br>
			<h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Bnner List</h2>
			<br>
			<c:forEach items="${banners}" var="banner">
				<!-- 리스트 한 개 시작 -->			
				<div class="in list-in">
					<a href="<c:url value='/banner/enroll?idx=${banner.idx}'/>">
						<div class="card align-middle list-card photo banner-thum">
							<div class="banner-thum-mask">${banner.banner_order}</div>
						    <img class="" src="<c:url value='${banner.PATH}${banner.banner_img_oid}'/>" />
						</div>
					</a>
				</div>			
				<!-- 리스트 한 개 끝 -->
			</c:forEach>
			
			
			<!-- 배너 추가 -->
			<div class="in list-in" >
				<a href="<c:url value='/banner/enroll'/>">
					<div class="card align-middle list-card photo banner-plus">
						+
					</div>
				</a>
			</div>
			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>

<script type="text/javascript">
	$(function(){
		
		$('.banner-thum-mask').on('mouseover', function(){
			$(this).animate({
				opacity: '-=1'
			}, 200);
			$(this).css('z-index','-999');
			stop();
		});
		
		$('.banner-thum').on('mouseleave', function(){
			$('.banner-thum-mask').css('z-index','999');
			$(this).children().animate({
				opacity: '+=1'
			}, 500);
			stop();
		});
		
	});
	
	
	/* function drag(ev) {
        
        ev.dataTransfer.setData("text", ev.target.id);
      
      }
      
       
      
      function dragOver(ev) {
      
        ev.preventDefault();
      
      }
      
       
      
      function drop(ev) {
      
        ev.preventDefault();
      
        var data = ev.dataTransfer.getData("text");
      
        ev.target.appendChild(document.getElementById(data));
      
      } */
</script>
</body>

</html>
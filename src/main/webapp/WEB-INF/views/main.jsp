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
		<input type="hidden" name="hidLink" id="hidLink" value="<c:url value='/banner/go'/>"/>
		<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
		<c:choose>			
			<c:when test="${size > 0 }">
	        <div class="carousel-indicators">
	        	<c:forEach var="i" begin="0" end="${size-1}">
	        		<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="${i}" <c:if test="${i == 0}">class="active" aria-current="true"</c:if>aria-label="Slide ${i+1 }"></button>
	        	</c:forEach>
	        </div>
		        <div class="carousel-inner">
		        	<c:forEach items="${banners}" var="banner" varStatus="stat">
		        		<div class="carousel-item <c:if test="${ stat.index == 0}">active</c:if>" onclick="location.href='<c:url value='/banner/go?idx=${banner.idx}&link=${banner.banner_link}'/>'">
				            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#1F2229"/>           	
				            </svg>
							<img class="banner-img" src="<c:url value='${banner.PATH}${banner.banner_img_oid}'/>"/>
							<c:if test="${banner.caption_yn == 1}">
								<div class="container">
					              <div class="carousel-caption <c:if test="${banner.banner_caption == 1}">text-start</c:if> <c:if test="${banner.banner_caption == 2}">text-end</c:if>">
					                <h1>${banner.banner_subject}</h1>
					                <p>${banner.banner_contents}</p>
					              </div>
					            </div>
							</c:if>		            
				         </div>
		        	</c:forEach>
		        </div>
		        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
		          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		          <span class="visually-hidden">Previous</span>
		        </button>
		        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
		          <span class="carousel-control-next-icon" aria-hidden="true"></span>
		          <span class="visually-hidden">Next</span>
		        </button>
			</c:when>
			<c:otherwise>
				<div class="carousel-inner">	        	
	        		<div class="carousel-item active">
			            <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#1F2229"/>           	
			            </svg>
						<img class="banner-img" src="<c:url value='/resources/image/spoon.jpg'/>"/>					
						<div class="container">
			              <div class="carousel-caption">
			                <h1>광고 준비중</h1>			                
			              </div>
			            </div>            
			         </div>
			     </div>
			</c:otherwise>
		</c:choose>
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
        <c:choose>
        	<c:when test="${best.size() > 0}">
	          <div class="row">
		         <h3 id="pg-title"><span id="pg-title-logo">HAPPY HOUR <svg xmlns="http://www.w3.org/2000/svg" width="1.8rem" height="" fill="#E30F0C" class="bi bi-alarm-fill" viewBox="0 0 16 16">
					<path d="M6 .5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1H9v1.07a7.001 7.001 0 0 1 3.274 12.474l.601.602a.5.5 0 0 1-.707.708l-.746-.746A6.97 6.97 0 0 1 8 16a6.97 6.97 0 0 1-3.422-.892l-.746.746a.5.5 0 0 1-.707-.708l.602-.602A7.001 7.001 0 0 1 7 2.07V1h-.5A.5.5 0 0 1 6 .5zm2.5 5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5zM.86 5.387A2.5 2.5 0 1 1 4.387 1.86 8.035 8.035 0 0 0 .86 5.387zM11.613 1.86a2.5 2.5 0 1 1 3.527 3.527 8.035 8.035 0 0 0-3.527-3.527z"/>
				</svg></span> BEST!</h3>
		      </div>
	          <div class="col-lg-4">
	            <div class="food-img"><img src="<c:url value='${best.get(0).PATH}${best.get(0).store_Img_Oid}'/>"/></div>
	            <h3 class="img-title">${best.get(0).store_Nm}</h3>
	            <ul class="img-contents">
	              <li><span class="best-span">카테고리</span> ${best.get(0).category}</li>
	              <li><span class="best-span">영업시간</span> ${best.get(0).store_open}~${best.get(0).store_close} <c:if test="${best.get(0).store_break eq '1'}">(break ${best.get(0).break_start} ~ ${best.get(0).break_end})</c:if></li>
	              <li><span class="best-span">위치</span> ${best.get(0).address}</li>
	            </ul>
	            <p class="best-more-p"><a class="btn btn-secondary best-more" href="<c:url value='/store/detail?idx=${best.get(0).idx}'/>">자세히 보기 &raquo;</a></p>
	          </div><!-- /.col-lg-4 -->
	          <c:choose>
        		<c:when test="${best.size() > 1}">	                   	
		          <div class="col-lg-4">
		            <div class="food-img"><img src="<c:url value='${best.get(1).PATH}${best.get(1).store_Img_Oid}'/>"/></div>
		            <h3 class="img-title">${best.get(1).store_Nm}</h3>
		            <ul class="img-contents">
		               <li><span class="best-span">카테고리</span> ${best.get(1).category}</li>
		              <li><span class="best-span">영업시간</span> ${best.get(1).store_open}~${best.get(1).store_close} <c:if test="${best.get(1).store_break eq '1'}">(break ${best.get(1).break_start} ~ ${best.get(1).break_end})</c:if></li>
		              <li><span class="best-span">위치</span> ${best.get(1).address}</li>
		            </ul>
		            <p class="best-more-p"><a class="btn btn-secondary best-more" href="<c:url value='/store/detail?idx=${best.get(1).idx}'/>">자세히 보기 &raquo;</a></p>
		          </div><!-- /.col-lg-4 -->
	          	</c:when>
	          	<c:otherwise>
	          		<div class="col-lg-4">
			           <div class="food-img"><img src="<c:url value='/resources/image/spoon.jpg'/>"/></div>
			           <h3 class="img-title">식당 준비중</h3>
			           <p class="best-more-p">...</p>	            
			        </div><!-- /.col-lg-4 -->	          		
	          	</c:otherwise>
	          </c:choose>
	          <c:choose>
        		<c:when test="${best.size() > 2}">
		          <div class="col-lg-4">
		            <div class="food-img"><img src="<c:url value='${best.get(2).PATH}${best.get(2).store_Img_Oid}'/>"/></div>
		            <h3 class="img-title">${best.get(2).store_Nm}</h3>
		            <ul class="img-contents">
		               <li><span class="best-span">카테고리</span> ${best.get(2).category}</li>
		              <li><span class="best-span">영업시간</span> ${best.get(2).store_open}~${best.get(2).store_close} <c:if test="${best.get(2).store_break eq '1'}">(break ${best.get(2).break_start} ~ ${best.get(2).break_end})</c:if></li>
		              <li><span class="best-span">위치</span> ${best.get(2).address}</li>
		            </ul>
		            <p class="best-more-p"><a class="btn btn-secondary best-more" href="<c:url value='/store/detail?idx=${best.get(2).idx}'/>">자세히 보기 &raquo;</a></p>
		          </div><!-- /.col-lg-4 -->
        		</c:when>
        		<c:otherwise>
	          		<div class="col-lg-4">
			           <div class="food-img"><img src="<c:url value='/resources/image/spoon.jpg'/>"/></div>
			           <h3 class="img-title">식당 준비중</h3>
			           <p class="best-more-p">...</p>	            
			        </div><!-- /.col-lg-4 -->	          		
	          	</c:otherwise>
	          </c:choose>
        	</c:when>
        	<c:otherwise>
        		
        	</c:otherwise>
        </c:choose>
        </div><!-- /.row -->
      </div><!-- /.container -->
	</main>
	
	 <footer>
		<jsp:include page="commons/footer.jsp"/>
	</footer>
	
	
<script type="text/javascript">
	$(function(){
		/* $(window).scroll(function(){
			$('.col-lg-4').eq(0).fadeIn(300);
			$('.col-lg-4').eq(1).fadeIn(450);
			$('.col-lg-4').eq(2).fadeIn(600);
		});	 */
		
	});
	
	
	
	
</script>
</body>

</html>
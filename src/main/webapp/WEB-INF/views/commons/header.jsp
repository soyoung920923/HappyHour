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
          <form class="d-flex" method="POST" action="${pageContext.request.contextPath}/store/list">
            <input class="form-control me-2" type="search" placeholder="식당명으로 검색하세요." aria-label="Search" name="search" value="${search}">
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
                <a class="nav-link" href="${pageContext.request.contextPath}/store/list">식당</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdownMenuButton1" type="button" data-bs-toggle="dropdown" aria-expanded="false" href="#">Q&A</a>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <li><a class="dropdown-item" href="${pageContext.request.contextPath}/complain">Q&A</a></li>
                </ul>
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
			  <li class="nav-item nav-link myPoint-li">
                <span class="myPointActive" onclick="myPointUtil()">
                	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
  						<path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
					</svg> on
				</span>
				<span class="myPointOff" onclick="myPointUtil()">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt" viewBox="0 0 16 16">
					  <path d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94zM8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10z"/>
					  <path d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
					</svg> off
				</span>
              </li>
            <c:if test="${loginUser.user_dt eq 9}">
	           <li class="nav-item">
	              <a class="nav-link" href="${pageContext.request.contextPath}/admin">관리자 페이지</a>
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
      <div id="fixed-box-top">
      	<p id="go-top">
      		<a href="#">
      			<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="#F9EBE0" class="bi bi-arrow-up-circle-fill" viewBox="0 0 16 16">
  					<path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
				</svg>
			</a>
		</p>
	  </div>
	  <div id="fixed-box">
		<div id="bottom-nav">			
			<ul id="bottom-nav-ul">
				<li class="bottom-nav-li on"><a href="${pageContext.request.contextPath}/store/list">전체</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/1">한식</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/2">분식</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/3">중식</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/4">패스트푸드</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/5">양식</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/6">카페/디저트</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/7">일식</a></li>
				<li class="bottom-nav-li"><a href="${pageContext.request.contextPath}/store/list/8">아시안</a></li>
			</ul>			
		</div>
      </div>
      <div class="bottom-nav-arrow" id="arrow-left">
			<i style='font-size:1.3rem' class='fas'>&#xf0d9;</i>
	  </div>
	  <div class="bottom-nav-arrow" id="arrow-right">
			<i style='font-size:1.3rem' class='fas'>&#xf0da;</i>
	  </div>
	  
	  <div id="fixed-box2">
	  	<div id="bottom-nav2">			
			<ul id="bottom-nav-ul2">
				<li class="bottom-nav-li2 on"><a href="" id="real">실시간</a></li>
				<li class="bottom-nav-li2"><a href="" id="past">지난내역</a></li>
			</ul>			
		</div>
	  </div>
	  
	  <!-- 내위치 모달 팝업 -->
	  <div id="myPointUtil">
	  	<br>
	  	<br>
	  	<br>
	  	<br>
	  	<br>
	  	<div id="mp-modal" class="in">	  		
	    	<div class="card align-middle">
	    		<div class="card-title" style="margin-top: 30px;">
	    			<h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">My Location</h2>
	    		</div>
	    		<div class="card-body">	    			
	    			<div class="form-check form-switch">
					  <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">
					  <label class="form-check-label" for="flexSwitchCheckDefault" id="myPoint-label"></label>
					</div>
	    			<div id="map_h" class="h-map"></div>
	    			<div id="map_x" class="h-map h-map2">내 위치를 켜주세요.</div>
	    			<input type="button" id="closeMyPointUtil" value="닫&nbsp;기" class="btn-btn btn form-control" style="margin-bottom: 0.8rem; "/>
	    		</div>
	  		</div>
	  	</div>
	  </div>
	  
      <script>
      	$(function(){
      		var loca = document.location.href;
      		var pp = loca.substring(loca.indexOf('/happyhour/')).replace('/happyhour/','');
      		
      		var mpInSession = '${myPoint}';
      		console.log("mpInSession: "+mpInSession);
      		
      		if (navigator.geolocation) {
      			console.log(1);
      			if (mpInSession == null || mpInSession == '') {
      				console.log(2);
      				if (pp == '') {					
		      			var sessionSet = confirm("내 위치를 켜시겠습니까?");
		      			if (sessionSet) {
		      				console.log(3);
				      		navigator.geolocation.getCurrentPosition(function(position) {
		 		      			 var lat = position.coords.latitude, // 위도
		 		 	            lon = position.coords.longitude; // 경도        
		 		 	        	settingMyPoint(lat, lon);
		 	      			});
			      			$('.myPointActive').show();
				      		$('.myPointOff').hide();
			      			$('#flexSwitchCheckDefault').prop('checked', true);
			      			$('#myPoint-label').text('내 위치 끄기');
			      			$('#map_h').show();
			      			myLocation();
			      			$('#map_x').hide();
			      			
						}else{
							console.log(4);
			      			$('.myPointActive').hide();
				      		$('.myPointOff').show();
			      			$('#flexSwitchCheckDefault').prop('checked', false);
			      			$('#myPoint-label').text('내 위치 켜기');
			      			$('#map_h').hide();
			      			$('#map_x').show();
			      			
						}
					}else{
						console.log(4);
		      			$('.myPointActive').hide();
			      		$('.myPointOff').show();
		      			$('#flexSwitchCheckDefault').prop('checked', false);
		      			$('#myPoint-label').text('내 위치 켜기');
		      			$('#map_h').hide();
		      			$('#map_x').show();
					}
				}else{
					console.log(5);
					$('.myPointActive').show();
		      		$('.myPointOff').hide();
	      			$('#flexSwitchCheckDefault').prop('checked', true);
	      			$('#myPoint-label').text('내 위치 끄기');
	      			$('#map_h').show();
	      			myLocation();
	      			$('#map_x').hide();
				}
      		}else{
      			console.log(6);
      			$('.myPointActive').hide();
	      		$('.myPointOff').show();
      			alert("브라우저 위치정보를 허용해주세요.");
      			$('#flexSwitchCheckDefault').prop('checked', false);
      			$('#myPoint-label').text('내 위치 켜기');
      			$('#map_h').hide();
      			$('#map_x').show();
      			
      		}
      		
      		  		
      		$('#flexSwitchCheckDefault').change(function(){
      			if ($(this).is(":checked")) {
      				if (navigator.geolocation) {
      	      			$('.myPointActive').show();
      	      			$('.myPointOff').hide();
      	      			navigator.geolocation.getCurrentPosition(function(position) {
      		      			 var lat = position.coords.latitude, // 위도
      		 	            lon = position.coords.longitude; // 경도        
      		 	        	settingMyPoint(lat, lon);
      	      			});
      	      		$('#myPoint-label').text('내 위치 끄기');
          			$('#map_h').show();
          			myLocation();
          			$('#map_x').hide();
      	      		}else{
      	      			$('.myPointActive').hide();
      	      			$('.myPointOff').show();
      	      			alert("브라우저 위치정보를 허용해주세요.");
     	      		}
      				
				}else{
					$('.myPointActive').hide();
  	      			$('.myPointOff').show();
  	      			offMyPoint();
	  	      		$('#myPoint-label').text('내 위치 켜기');
	      			$('#map_h').hide();
	      			$('#map_x').show();
	      			
				}

      		});
      		
      		var url = window.location.href;
      		console.log(url);
      		/*header nav*/
      		if (url.indexOf("store/list") > -1 || url.indexOf("store/detail") > -1 || url.indexOf("lineup/enroll") > -1) {
      			$('.nav-item > a').removeClass('active');
				$('.nav-item').eq(1).children('a').addClass('active');
			}else if (url.indexOf("/user/login") > -1) {
      			$('.nav-item > a').removeClass('active');
				$('.nav-item').eq(3).children('a').addClass('active');
			}else if (url.indexOf("myPage") > -1) {
      			$('.nav-item > a').removeClass('active');
				$('.nav-item').eq(3).children('a').addClass('active');
			}else{
				$('.nav-item > a').removeClass('active');
				$('.nav-item').eq(0).children('a').addClass('active');
			}
      		
      		
      		/*bottom nav*/
          	var dv = url.lastIndexOf("/");
          	var pth = url.substring(dv+1);
          	console.log(pth);
          		
          	if (url.indexOf("store/list/"+pth) > -1) {
          		$('.bottom-nav-li').removeClass('on');
          		$('.bottom-nav-li').eq(pth).addClass('on');
          		if (pth > 6) {
          			$('#bottom-nav').animate({
            			scrollLeft: '+=600'
            		}, 200);
          		}else if (pth > 3) {
          			$('#bottom-nav').animate({
            			scrollLeft: '+=400'
            		}, 200);
    			}
          	}else{
          		$('.bottom-nav-li').removeClass('on');
          		$('.bottom-nav-li').eq(0).addClass('on');
          	}
          		    		
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
      		
      		$('#closeMyPointUtil').click(function(){
      			$('#myPointUtil').hide();
      			if (pp != '') {
      				location.reload();
				}     			
      		});
      		
      	});
      	
      	function myPointUtil(){
      		$('#navbarCollapse').removeClass('show');
      		$('#myPointUtil').show();
      		$('#myPointUtil').on('scroll touchmove mousewheel', function(event) {
      		  event.preventDefault();
      		  event.stopPropagation();
      		  return false;
      		});
      		
      		if ($('#myPoint-label').text() == '내 위치 끄기') {
      			console.log(7);
      			$('#map_h').show();
      			myLocation();
      			$('#map_x').hide();
			}
      	}
      	
      	function settingMyPoint(lat, lon){
    		$.ajax({
    			type		: "GET",
    			url			: "/happyhour/myPoint",
    			data		: {"lat":lat, "lon": lon},
    			dataType	: "text",
    			success		: function(result){
    				console.log("success"); 				
    			},
    			error		: function(e){
    				console.log(e);
    			}			
    		});
    	}
      	
      	function offMyPoint(){
      		$.ajax({
    			type		: "GET",
    			url			: "/happyhour/myPointOff",
    			data		: {"lat":"0", "lon": "0"},
    			dataType	: "text",
    			success		: function(result){
    				console.log("success");   				
    			},
    			error		: function(){
    				console.log("error");
    			}			
    		});
      	}

      </script>
</body>
</html>
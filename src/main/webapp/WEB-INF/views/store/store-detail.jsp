<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	pageContext.setAttribute("cn", "\n");
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cr", "\r");
	pageContext.setAttribute("crcn", "\r\n");
%>
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
			<div class="in list-in">
				<div class="card align-middle list-card photo">
				    <img src="<c:url value='${store.PATH}${store.store_Img_Oid}'/>" />
				</div>
			</div>
			<div class="in list-in">
			    <div class="card align-middle list-card">
			        <div class="card-body">				       
				       <table id="detail-cont">
				       	<tr>
				       		<td class="cont-center"><h5><span class="list-category">${store.category}</span>&nbsp;&nbsp;&nbsp;${store.store_Nm}</h5></td>
				       	</tr>
				       	<tr>
				       		<td class="cont-center"><i style='font-size:1.3rem' class='far'>&#xf0a6;</i>&nbsp;클릭수&nbsp;${store.hit_Count}</td>
				       	</tr>
				       	<tr>
				       		<td class="cont-center">
				       			<ul id="utils-ul">
				       				<li onclick='telOrPop("${store.store_Nm}","${store.store_Tel}")'><i style='font-size:2rem; color: #E30F0C;' class='fas'>&#xf095;</i>&nbsp;&nbsp;전화걸기</a></li>
				       				<li onclick='findLoad()'><i style='font-size:2rem; color: #E30F0C;' class='fas'>&#xf3c5;</i>&nbsp;&nbsp;길찾기</li>
				       				<li onclick="location.href='<c:url value='/lineup/enroll?store=${store.idx}'/>'"><i style='font-size:2rem; color: #E30F0C;' class='fas'>&#xf274;</i>&nbsp;&nbsp;줄서기/예약</li>
				       			</ul>
				       		</td>
				       	</tr>
				       </table>				               
			        </div>   
			    </div>
			</div>
			<div class="in list-in">
				<div class="card align-middle list-card photo info-div">
				    <div class="card-body info-div-body">
				    	<c:if test=""></c:if>
				    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down more-info" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
						</svg><span class="more-info">&nbsp;&nbsp;</span>${fn:replace(store.store_Info,cn,br)}
				    </div>
				</div>
			</div>			       
			<div class="in list-in">
				<div class="card align-middle list-card photo">
				    <div class="card-body">				       
				       <table id="detail-cont">
				       	<tr>
				       		<th>대표번호</th>
				       		<td>${store.store_Tel}</td>
				       	</tr>
				       	<tr>
				       		<th>운영시간</th>
				       		<td>${store.store_open} ~ ${store.store_close}<c:if test="${store.store_break eq 0}">(브레이크타임 없음)</c:if></td>
				       	</tr>
				       	<c:if test="${store.store_break eq 1}">
				       		<tr>
					       		<th>브레이크타임</th>
					       		<td>${store.break_start} ~ ${store.break_end}</td>
					       	</tr>
				       	</c:if>				       	
				       	<tr>
				       		<th>위치</th>
				       		<td>${store.address}</td>
				       	</tr>
				       	<tr>
				       		<td colspan="2" id="map-td">
				       			<div id="map" style="width:100%;height:350px;"></div>
				       		</td>
				       	</tr>
				       </table>				               
			        </div> 
				</div>
			</div>		
			<br><br><br><br>
			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
		
<script type="text/javascript">
	$(function(){
		
		$('#bottom-nav').css('display','block');
		$('.bottom-nav-arrow').css('display','block');
		$('#fixed-box-top').css('bottom','5.5%');
		
		$('.more-info').click(function(){
			$('.info-div').addClass('auto');
			$('.more-info').css('display','none');
		});
		
		var thisCategory = '${store.store_Idt}';
  		
  		if (thisCategory != null && thisCategory != '') {
  			console.log(thisCategory);
  			$('.bottom-nav-li').removeClass('on');
  			$('.bottom-nav-li').eq(thisCategory).addClass('on');
  			if (thisCategory > 6) {
  				$('#bottom-nav').animate({
    				scrollLeft: '+=600'
    			}, 200);
  			}else if (thisCategory > 3) {
  				$('#bottom-nav').animate({
    				scrollLeft: '+=400'
    			}, 200);
			}
		}
		
	});
	
	const name = '${store.store_Nm}';
	const latitude = '${store.latitude}';
	const longitude = '${store.longitude}';
	
	
	var url = "";
	var myLong = "";
	var myLati = "";
	function findLoad(){
		if ('${myPoint}' != null && '${myPoint}' != '') {
			myLong = '${myPoint.lon}';
			myLati = '${myPoint.lat}';
			goNaverMap();
		}else{
			askMyPointOn();
			myLong = '${myPoint.lon}';
			myLati = '${myPoint.lat}';
			goNaverMap();
		}
		
		
	}
	function goNaverMap(){
		console.log("내위치:	"+myLong+"	/	"+myLati);
		console.log("목적지:	"+latitude+"	/	"+longitude);
		if (isMobile()) {				
			url = "http://m.map.naver.com/route.nhn?menu=route&sname=내위치&sx="+myLong+"&sy="+myLati+"&ename="+name+"&ex="+longitude+"&ey="+latitude+"&pathType=0&showMap=true";
		}else{
			url = "http://map.naver.com/index.nhn?slng="+myLong+"&slat="+myLati+"&stext=내위치&elng="+longitude+"&elat="+latitude+"&etext="+name+"&menu=route&pathType=1";
		}
		console.log(url);
		location.href = url;
	}
	
	
	var searchAddress = '${store.store_Address}';
	searchAddress = searchAddress.substring(searchAddress.indexOf("|")+1);
	
	var storeNm = '${store.store_Nm}';
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(searchAddress, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+name+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});  
	
	function telOrPop(nm, tel){
		if (isMobile()) {
			document.location.href = "tel:"+tel;
		}else{
			alert("'"+nm+"'의 전화번호는 "+tel+"'입니다.");
		}
	}
	
	function isMobile() {
	    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
	}
</script>
</body>

</html>
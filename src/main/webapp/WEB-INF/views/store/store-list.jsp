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
			<form id="searchList" name="searchList">
				<input type="hidden" id="startCount" name="startCount" value="0"/>
				<input type="hidden" id="viewCount" name="viewCount" value="0"/>
				<input type="hidden" id="totalCount" name="totalCount" value="${total}"/>
				<input type="hidden" id="path" name="path" value="${path}"/>
				<input type="hidden" id="search" name="search" value="${search}"/>
			</form>
			<table style="margin: 0 auto; width: 100%;" id="store-list">
				<c:if test="${total > 0}">
					<c:forEach items="${list}" var="list">
						<tr>
							<td>
								<!-- 리스트 한 개 시작 -->
								<div class="in list-in">
								    <div class="card align-middle list-card">
								        <div class="card-body">				       
									       <ul class="list-ul">
									       	<li class="list-li-img">
									       		<a href="<c:url value='/store/detail?idx=${list.idx}'/>">
									       			<div class="list-img-thum">
									       				<img alt="" src="<c:url value='${list.PATH}${list.store_Img_Oid}'/>">
									       				<div class="ready-block <c:if test="${list.holiday ne null && list.holiday ne ''}">block</c:if>">
									       					<i class='fas'>&#xf2e7;</i> 
									       					<c:choose>
									       						<c:when test="${list.holiday eq 'holiday' }">
									       							정기휴일
									       						</c:when>
									       						<c:otherwise>
									       							${list.holiday}
									       						</c:otherwise>
									       					</c:choose>
									       				</div>
									       			</div>
									       		</a>
									       	</li>
									       	<li class="list-li-contents list-li-contents-1">
									       		<h6 class="list-title"><a href="<c:url value='/store/detail?idx=${list.idx}'/>"><span class="list-category">${list.category}</span>&nbsp;&nbsp;&nbsp;${list.store_Nm}</a></h6>
									       		<p class="list-cont">
									       			<i class='fas'>&#xf017;</i><span class='miniTitle'> 영업시간</span> ${list.store_open} ~ ${list.store_close}
									       			<c:choose>
											       		<c:when test="${list.store_break eq 0}"></c:when>
											       		<c:otherwise><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break ${list.break_start} ~ ${list.break_end}</c:otherwise>
											       	</c:choose>
											       	<br><i class='fas' style="font-size: 1.1rem;">&#xf273;</i><span class="miniTitle"> 휴일</span>
											       	<c:choose>
									       				<c:when test="${list.holidays ne null}">매주
										       				<c:forEach items="${list.holidays}" var="holiday">
											       				<c:if test="${holiday eq 2}">월 </c:if>
											       				<c:if test="${holiday eq 3}">화 </c:if>
											       				<c:if test="${holiday eq 4}">수 </c:if>
											       				<c:if test="${holiday eq 5}">목 </c:if>
											       				<c:if test="${holiday eq 6}">금 </c:if>
											       				<c:if test="${holiday eq 7}">토 </c:if>
											       				<c:if test="${holiday eq 1}">일 </c:if>
											       			</c:forEach>
										       			</c:when>
										       			<c:otherwise>
										       				<c:choose>
										       					<c:when test="${list.holiday_etc ne null && list.holiday_etc ne ''}">${list.holiday_etc}</c:when>
										       					<c:otherwise>-</c:otherwise>
										       				</c:choose>										       				
										       			</c:otherwise>
										       		</c:choose>
									       		</p>
									       		<%-- <p class="list-cont">${list.store_Info}</p> --%>
									       	</li>
									       	<li class="list-li-hit">
									       		<i style='font-size:1.3rem' class='fa open-utils'>&#xf141;</i><br>
									       		<i style='font-size:1.3rem' class='far'>&#xf0a6;</i> ${list.hit_Count}
									       	</li>
									       </ul> 				               
								        </div>   
								    </div>
								    <div class="utils">
								        	<div class="util">
									        	<i onclick="telOrPop('${list.store_Nm}','${list.store_Tel}')" style='font-size:24px; color: #FFF;' class='fas'>&#xf095;</i>
								        	</div>
								        	<div class="util">
									        	<i onclick="findLoad('${list.store_Nm}','${list.longitude}','${list.latitude}');" style='font-size:24px; color: #FFF;' class='fas'>&#xf3c5;</i>
								        	</div>
								        	<div class="util">
									        	<i onclick="location.href='<c:url value='/lineup/enroll?store=${list.idx}'/>'" style='font-size:24px; color: #FFF;' class='fas'>&#xf274;</i>
								        	</div>
								        </div>
								</div>
								<!-- 리스트 한 개 끝 -->
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${total < 1}">
					<h5 style="width: 100%; text-align:center;">등록된 가게가 없습니다.</h5>
				</c:if>
			</table>
			
			<c:if test="${total > 5}">
				<div class="in list-in" id="btn-in">
					<div class="card align-middle plus-card">				
						<div class="card-body plus-card-body" id="moreList">
							<i style='font-size:1.3rem' class='fas'>&#xf078;</i>&nbsp;&nbsp;<span class="beside-icon">더보기</span>
						</div>			
					</div>
				</div>
			</c:if>
			
			
			<br><br><br><br>
			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
	
<script type="text/javascript">
		
	$(function(){
		
		var ii = 0;

		$('#moreList').click(function(){
			moreList('store-list',5);
		});
		
		function moreList(id, cnt) {
			var listLength = $('#'+id+" tr").length;
			var callLength = listLength;
			var total = $('#totalCount').val();
			
			$('#startCount').val(callLength);  	//불러올 리스트의 시작 번호
			$('#viewCount').val(cnt);			//불러올 리스트의 갯수
			
			$.ajax({
				type		: "POST",
				url			: "getMoreList",
				data		: $('#searchList').serialize(),
				dataType	: "json",
				success		: function(result){
					if (result.resultCnt > 0) {
						ii++;
						var resultList = result.resultList;						
						drawMoreList(resultList);
						var nowCount = $('#'+id+" tr").length;
						if (nowCount == total) {
							$('#btn-in').hide();
						}
					}
				},
				error		: function(){
					console.log("error");
				}
				
			});
		}
		
		
		function drawMoreList(resultList){
			
			var _html = "";
			for (var i = 0; i < resultList.length; i++) {
				var list = resultList[i];
				var imgPath = "/happyImage/"+list.store_Img_Oid;
				var _choose = list.store_open+" ~ "+list.store_close;
				if (list.store_break == 0) {
					
				}else{
					_choose = _choose+"<br>break "+list.break_start+" ~ "+list.break_end;
				}
				var enrollUrl = "/happyhour/lineup/enroll?store="+list.idx;
				var holiday = list.holiday;
				if (holiday == 'holiday') {
					holiday = "block";
				}else{
					holiday = "";
				}
				var holidayCont = "매주 ";
				if (true) {
					//var holidays[] = list.holidays;
					var weekOfDay = "";
					for (var i = 0; i < list.holidays.length; i++) {
						if (list.holidays[i] == 1){
							holidayCont += "일 ";
						}else if(list.holidays[i] == 2){
							holidayCont += "월 ";
						}else if(list.holidays[i] == 3){
							holidayCont += "화 ";
						}else if(list.holidays[i] == 4){
							holidayCont += "수 ";
						}else if(list.holidays[i] == 5){
							holidayCont += "목 ";
						}else if(list.holidays[i] == 6){
							holidayCont += "금 ";
						}else{
							holidayCont += "토 ";
						}
					}
				}else{
					holidayCont = list.holiday_etc;
					if (holidayCont == null || holidayCont == '') {
						holidayCont = "-";
					}
				}
				
				
				_html += "<tr><td><div class='in list-in'><div class='card align-middle list-card'><div class='card-body'><ul class='list-ul'><li class='list-li-img'><a href='<c:url value='/store/detail?idx="+list.idx+"'/>'><div class='list-img-thum'>";
				_html += "<img alt='' src='"+imgPath+"'><div class='ready-block "+holiday+"'><i class='fas'>&#xf2e7;</i> 정기휴일</div></div></a></li>";
				_html += "<li class='list-li-contents list-li-contents-1'><a href='<c:url value='/store/detail?idx="+list.idx+"'/>'><h6 class='list-title'><span class='list-category'>"+list.category+"</span>&nbsp;&nbsp;&nbsp;"+list.store_Nm+"</h6></a>";
				_html += "<p class='list-cont'><i class='fas'>&#xf017;</i><span class='miniTitle'> 영업시간</span>"+_choose+"<br><i class='fas' style='font-size: 1.1rem;'>&#xf273;</i><span class='miniTitle'> 휴일</span> "+holidayCont+"</p></li>";
				_html += "<li class='list-li-hit'><i style='font-size:1.3rem' class='fa open-utils' onclick ='onUtils("+i+","+ii+")'>&#xf141;</i><br><i style='font-size:1.3rem' class='far'>&#xf0a6;</i> "+list.hit_Count+"</li></ul></div></div>";
				_html += "<div class='utils' id='"+ii+"utils"+i+"'><div class='util'><i onclick='telOrPop(\""+list.store_Nm+"\",\""+list.store_Tel+"\")' style='font-size:24px; color: #FFF;' class='fas'>&#xf095;</i></div>";
				_html += "<div class='util'><i onclick='findLoad(\""+list.store_Nm+"\",\""+list.longitude+"\",\""+list.latitude+"\");' style='font-size:24px; color: #FFF;' class='fas'>&#xf3c5;</i></div>";
				_html += "<div class='util'><i onclick='location.href='"+enrollUrl+"'' style='font-size:24px; color: #FFF;' class='fas'>&#xf274;</i></div></div></div></td></tr>";		       				
			}
			$('#store-list tr:last').after(_html);
		}
		
		$('.open-utils').click(function(){
			var thisUtil = $(this).parents('.card').next('.utils');
			
			if (thisUtil.hasClass('open')) {
				thisUtil.removeClass('open');
			}else{
				$('.utils').removeClass('open');
				thisUtil.addClass('open');
			}
					
		});
	});
	
	function onUtils(i, ii) {
			
		var thisId = $('#'+ii+'utils'+i);
	
		if (thisId.hasClass('open')) {
			thisId.removeClass('open');
		}else{
			$('.utils').removeClass('open');
			thisId.addClass('open');
		}
			
	}
	
	var name = "";
	var latitude = "";
	var longitude = "";	
	var url = "";
	var myLong = "";
	var myLati = "";
	
	function findLoad(nm, lg, lt){
		
		if ('${myPoint}' != null && '${myPoint}' != '') {
			myLong = '${myPoint.lon}';
			myLati = '${myPoint.lat}';
			goNaverMap(nm, lg, lt);
		}else{
			askMyPointOn();
			myLong = '${myPoint.lon}';
			myLati = '${myPoint.lat}';
			goNaverMap(nm, lg, lt);
		}			
	}
	
	function goNaverMap(nm, lg, lt){
		name = nm;
		longitude = lg;
		latitude = lt;
		if (isMobile()) {				
			url = "http://m.map.naver.com/route.nhn?menu=route&sname=내위치&sx="+myLong+"&sy="+myLati+"&ename="+name+"&ex="+longitude+"&ey="+latitude+"&pathType=0&showMap=true";
		}else{
			url = "http://map.naver.com/index.nhn?slng="+myLong+"&slat="+myLati+"&stext=내위치&elng="+longitude+"&elat="+latitude+"&etext="+name+"&menu=route&pathType=1";
		}
		location.href = url;
	}
	function isMobile() {
	    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
	}
	
	function telOrPop(nm, tel){
		if (isMobile()) {
			document.location.href = "tel:"+tel;
		}else{
			alert("'"+nm+"'의 전화번호는 "+tel+"'입니다.");
		}
	}
	
</script>
</body>

</html>
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
			<h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">My Store List</h2>
			<br>
			<!-- 배너 추가 -->
			<div class="in list-in" >
				<a href="<c:url value='/store/enroll'/>">
					<div class="card align-middle list-card photo banner-plus store-plus">
						+
					</div>
				</a>
			</div>
			<form id="searchList" name="searchList">
				<input type="hidden" id="startCount" name="startCount" value="0"/>
				<input type="hidden" id="viewCount" name="viewCount" value="0"/>
				<input type="hidden" id="totalCount" name="totalCount" value="${total}"/>
				<input type="hidden" id="path" name="path" value="${path}"/>
				<input type="hidden" id="search" name="search" value="${search}"/>
				<input type="hidden" id="userIdx" name="userIdx" value="${userIdx}"/>
				<input type="hidden" id="business" name="business" value="business"/>
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
									       	<li class="list-li-img"><a href="<c:url value='/store/enroll?idx=${list.idx}'/>"><div class="list-img-thum"><img alt="" src="<c:url value='${list.PATH}${list.store_Img_Oid}'/>"></div></a></li>
									       	<li class="list-li-contents">
									       		<h6 class="list-title"><a href="<c:url value='/store/enroll?idx=${list.idx}'/>"><span class="list-category">${list.category}</span>&nbsp;&nbsp;&nbsp;${list.store_Nm}</a></h6>
									       		<p class="list-cont">
									       			<a href="/happyhour/lineup/list/1?store=${list.idx}&myOrStore=store"><input type="button" class="btn-btn btn form-contol modi-btn" value="줄서기 현황"/></a>
									       			<a href="/happyhour/lineup/list/2?store=${list.idx}&myOrStore=store"><input type="button" class="btn-btn btn form-contol modi-btn" value="예약관리"/></a>
									       		</p>
									       		<%-- <p class="list-cont">${list.store_Info}</p> --%>
									       	</li>
									       	<li class="list-li-hit">
									       		<i style='font-size:1.3rem' class='far'>&#xf0a6;</i> ${list.hit_Count}
									       	</li>
									       </ul> 				               
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
<style>
.store-plus{height: 197px;}
	.list-li-contents {
    padding-bottom: 0rem;}
	.modi-btn{width: 100%; background-color: #FFAB2F; color: #fff; height: 42px; font-size: 1.2rem;}
	.modi-btn:hover{background-color: #E30F0C;}

</style>	
<script type="text/javascript">
	$(function(){
		
		var ii = 0;
		$('#bottom-nav3').css('display','block');
		$('#fixed-box-top').css('bottom','5.5%');
		$('.bottom-nav-li3').removeClass('on');
  		$('.bottom-nav-li3').eq(2).addClass('on');

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
				
				_html += "<tr><td><div class='in list-in'><div class='card align-middle list-card'><div class='card-body'><ul class='list-ul'><li class='list-li-img'><a href='<c:url value='/store/detail?idx="+list.idx+"'/>'><div class='list-img-thum'>";
				_html += "<img alt='' src='"+imgPath+"'></div></a></li>";
				_html += "<li class='list-li-contents'><a href='<c:url value='/store/detail?idx="+list.idx+"'/>'><h6 class='list-title'><span class='list-category'>"+list.category+"</span>&nbsp;&nbsp;&nbsp;"+list.store_Nm+"</h6></a>";
				_html += "<p class='list-cont'><a href='/happyhour/lineup/list/1?store="+list.idx+"&myOrStore=store'><input type='button' class='btn-btn btn form-contol modi-btn' value='줄서기 현황'/></a>";
				_html += "<a href='/happyhour/lineup/list/2?store="+list.idx+"&myOrStore=store'><input type='button' class='btn-btn btn form-contol modi-btn' value='예약관리'/></a></p></li>";
				_html += "<li class='list-li-hit'><i style='font-size:1.3rem' class='far'>&#xf0a6;</i> "+list.hit_Count+"</li></ul></div></div>";		       				
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
		
	function findLoad(name,longitude,latitude){
		var url = "https://map.kakao.com/link/to/"+name+","+longitude+","+latitude;
		console.log(url);
		// 모바일(앱) -> var url2 = "kakaomap://route?sp=37.537229,127.005515&ep="+longitude+","+latitude+"&by=CAR"
		location.href = url;
	}
</script>
</body>

</html>
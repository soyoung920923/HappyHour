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
				<input type="hidden" id="store" name="store" value="${store}"/>
				<input type="hidden" id="pastOrNot" name="past" value="${past}"/>
			</form>
			<div class="in list-in" >
			<c:choose>
				<c:when test="${past eq null || past eq ''}">
					<ul id="top-arrow-menu-ul">
						<li>
							<a href="<c:url value='/store/list?business=business'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:if test='${path == 2}'><c:url value='/lineup/list/2?store=${store}&myOrStore=store&past=past'/></c:if><c:if test='${path == 1}'><c:url value='/lineup/list/1?store=${store}&myOrStore=store&past=past'/></c:if>" class="top-arrow-menu">
								<c:if test="${path == 2}">지난 예약</c:if><c:if test="${path == 1}">지난 줄서기</c:if>&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
								</svg>
							</a>
						</li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul id="top-arrow-menu-ul">
						<li>
							<a href="<c:url value='/store/list?business=business'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:if test='${path == 2}'><c:url value='/lineup/list/2?store=${store}&myOrStore=store'/></c:if><c:if test='${path == 1}'><c:url value='/lineup/list/1?store=${store}&myOrStore=store'/></c:if>" class="top-arrow-menu">
								<c:if test="${path == 2}">실시간 예약</c:if><c:if test="${path == 1}">실시간 줄서기</c:if>&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
								</svg>
							</a>
						</li>
					</ul>
				</c:otherwise>
			</c:choose>
																
			<c:if test="${total > 0}">
				<c:choose>
					<c:when test="${past eq null || past eq ''}">					
						<a href="<c:url value='/lineup/visitTeam?visit=1&idx=${list.get(0).idx}&path=${path}&store=${store}'/>">
							<div class="card align-middle list-card lineup-visit-btn">
								<c:if test="${path == 1}">
									줄서기 입장<br>						
									<span id="list-waiting">대기팀: ${waiting}</span>
								</c:if>
								<c:if test="${path == 2}">
									예약 입장<br>
								</c:if>
							</div>
						</a>							
					</c:when>
					<c:otherwise>
						<div class="card align-middle list-card lineup-visit-btn1">
								<c:if test="${path == 1}">
									이전 줄서기 내역<br>
								</c:if>
								<c:if test="${path == 2}">
									이전 예약 내역<br>
								</c:if>
							</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			</div>
			<table style="margin: 0 auto; width: 100%;" id="store-list">
				<c:if test="${total > 0}">
					<c:forEach items="${list}" var="list" varStatus="i">
						<tr class='listS'>
							<td>								
								<div class="in">
								    <div class="card align-middle <c:if test="${list.lineup_visit eq 4}">card-bold</c:if>">
								        <div class="card-body">				       
									       <table style="width: 100%;">
									       <c:choose>
												<c:when test="${past eq null || past eq ''}">
											       	<c:choose>
										       			<c:when test="${path eq 1}">
													       	<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:30%;">${list.lineup_nm}</td>
													       		<td style="width:40%;">${list.lineup_tel}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>											       		
													       		<td style="width:15%; text-align: right;">
													       			<input type='button' class='form-control lineupNs-btn' value="노쇼" onclick="location.href='<c:url value='/lineup/visitTeam?visit=2&idx=${list.idx}&path=${path}&store=${store}'/>'"/>
													       		</td>
													       	</tr>
										       			</c:when>
										       			<c:otherwise>
										       				<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:40%;">${list.lineup_nm} [${list.lineup_Date}]</td>
													       		<td style="width:30%;">${list.lineup_tel}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>												       		
													       		<td style="width:15%; text-align: right;">
													       			<c:choose>
													       				<c:when test="${list.lineup_visit eq 4}">
													       					<input type='button' class='form-control lineupApp-btn' value="예약확인" onclick="messagePop('${list.idx}','${list.lineup_Date}');"/>
													       				</c:when>
													       				<c:otherwise>
															       			<input type='button' class='form-control lineupNs-btn' value="노쇼" onclick="location.href='<c:url value='/lineup/visitTeam?visit=2&idx=${list.idx}&path=${path}&store=${store}'/>'"/>
													       				</c:otherwise>
													       			</c:choose>
													       		</td>
													       	</tr>
										       			</c:otherwise>
										       		</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
										       			<c:when test="${path eq 1}">
													       	<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:30%;">${list.lineup_nm}</td>
													       		<td style="width:40%;">${list.lineup_tel}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>											       		
													       		<td style="width:15%; text-align: right;">
													       			<c:if test="${list.lineup_visit eq 1}">입장</c:if>
													       			<c:if test="${list.lineup_visit eq 2}">노쇼</c:if>
													       			<c:if test="${list.lineup_visit eq 3}">취소</c:if>
													       		</td>
													       	</tr>
										       			</c:when>
										       			<c:otherwise>
										       				<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:40%;">${list.lineup_nm} [${list.lineup_Date}]</td>
													       		<td style="width:30%;">${list.lineup_tel}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>											       		
													       		<td style="width:15%; text-align: right;">
													       			<c:if test="${list.lineup_visit eq 1}">입장</c:if>
													       			<c:if test="${list.lineup_visit eq 2}">노쇼</c:if>
													       			<c:if test="${list.lineup_visit eq 3}">취소</c:if>
													       		</td>
													       	</tr>
										       			</c:otherwise>
										       		</c:choose>
												</c:otherwise>
											</c:choose>
									       </table> 				               
								        </div>   
								    </div>
								</div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${total < 1}">
					<c:choose>
						<c:when test="${past eq null || past eq ''}">
							<c:choose>
								<c:when test="${path eq 1}">
									<h5 style="width: 100%; text-align:center;">대기중인 손님이 없습니다.</h5>
								</c:when>
								<c:otherwise>
									<h5 style="width: 100%; text-align:center;">예약손님이 없습니다.</h5>
								</c:otherwise>
							</c:choose>						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${path eq 1}">
									<h5 style="width: 100%; text-align:center;">지난 줄서기 내역이 없습니다.</h5>
								</c:when>
								<c:otherwise>
									<h5 style="width: 100%; text-align:center;">지난 예약 내역이 없습니다.</h5>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>					
				</c:if>
			</table>
			
			<c:if test="${total > 5}">
				<div class="in list-in" id="btn-in" style="margin-top:1rem">
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
.card-bold{
	box-shadow: 5px 2px 10px 0px rgb(0 0 0 / 30%);
	border-color: #FFAB2F;
	background-color: #FFAB2F;
	color: #fff;
}
#top-arrow-menu-ul{
	width: 100%;
}
#top-arrow-menu-ul > li{
	display: inline-block;
	width: 49.5%;
}
#top-arrow-menu-ul > li:nth-child(2){
	text-align: right;
}
	.top-arrow-menu{
		color: #FFAB2F;
	}
	.lineup-visit-btn, .lineup-visit-btn1{
		text-align: center;
		border-color: #E30F0C;
		font-size: 2rem;
		color: #E30F0C;
		font-weight: bold;
		padding: 1.5rem 0;
	}
	.lineup-visit-btn{cursor:pointer;}
	.lineup-visit-btn:hover{
		background-color: #E30F0C;
		color: #fff;
	}
	.lineupNs-btn:hover{
		background-color: #1F2229;
		color: #fff;
	}
	.lineupApp-btn{border-color: #FFF; background-color: #FFAB2F; color: #fff;}
	.lineupApp-btn:hover{background-color: #fff; color: #FFAB2F;}
	#list-waiting{font-weight: normal; font-size: 1rem; line-height: 2;}
</style>
	
<script type="text/javascript">
	$(function(){
		var ii = 5;
		var path = $('#path').val();
		var pastOrNot = $('#pastOrNot').val();
		var store = $('#store').val();
		
		$('#bottom-nav3').css('display','block');
		$('#fixed-box-top').css('bottom','5.5%');
		$('.bottom-nav-li3').removeClass('on');
		$('.bottom-nav-li3').eq(2).addClass('on');
		
		$('#moreList').click(function(){
			moreList('store-list',5);
		});
		
		function moreList(id, cnt) {
			var listLength = $('.listS').length;
			console.log(listLength);
			var callLength = listLength;
			var total = $('#totalCount').val();
			
			$('#startCount').val(callLength);  	//불러올 리스트의 시작 번호
			$('#viewCount').val(cnt);			//불러올 리스트의 갯수
			
			$.ajax({
				type		: "POST",
				url			: "/happyhour/lineup/getMoreList",
				data		: $('#searchList').serialize(),
				dataType	: "json",
				success		: function(result){
					console.log(result);
					if (result.resultCnt > 0) {
						var resultList = result.resultList;						
						drawMoreList(resultList);
						var nowCount = $('.listS').length;
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
				var visit = list.lineup_visit;
				if (visit == "1") {
					visit = "입장";
				}else if (visit == "2") {
					visit = "노쇼";
				}else {
					visit = "취소";
				}
				ii++;
				if (pastOrNot == "past") {
					if (path == 1) {					
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%; '>"+ii+"</td>";
						_html += "<td style='width:30%;'>"+list.lineup_nm+"</td>";	       		
						_html += "<td style='width:40%;'>"+list.lineup_tel+"</td>";	
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: right;'>"+visit+"</td>";
						_html += "</tr></table></div></div></div></td></tr>";	       		
					}else{
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%; '>"+ii+"</td>";
						_html += "<td style='width:40%;'>"+list.lineup_nm+" ["+list.lineup_Date+"]</td>";	       		
						_html += "<td style='width:30%;'>"+list.lineup_tel+"</td>";	
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: right;'>"+visit+"</td>";
						_html += "</tr></table></div></div></div></td></tr>";
					}				
				}else{
					if (path == 1) {					
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%; '>"+ii+"</td>";
						_html += "<td style='width:30%;'>"+list.lineup_nm+"</td>";	       		
						_html += "<td style='width:40%;'>"+list.lineup_tel+"</td>";	       		
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";	       		
						_html += "<td style='width:15%; text-align: center;'><input type='button' class='form-control lineupNs-btn' value='노쇼' onclick='location.href='<c:url value='/lineup/visitTeam?visit=2&idx="+list.idx+"&path="+path+"&store="+store+"'/>''/></td>";
						_html += "</tr></table></div></div></div></td></tr>";	       		
					}else{
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%; '>"+ii+"</td>";
						_html += "<td style='width:40%;'>"+list.lineup_nm+" ["+list.lineup_Date+"]</td>";	       		
						_html += "<td style='width:30%;'>"+list.lineup_tel+"</td>";
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: center;'><input type='button' class='form-control lineupNs-btn' value='노쇼' onclick='location.href='<c:url value='/lineup/visitTeam?visit=2&idx="+list.idx+"&path="+path+"&store="+store+"'/>''/></td>";
						_html += "</tr></table></div></div></div></td></tr>";
					}	
					
				}
					       							       			       				
			}
			$('.listS:last').after(_html);
		}
		
		$('#closeMyReserveUtil').click(function(){
			$('#myReserveUtil').hide();
		});
		
		
		$(document).on('change', "input[name='approval']" ,function() {
			approval = $("input[name='approval']:checked").val();
			if (approval == 0) {
				$('#userMsg').text(dateTime+"에 예약이 확정되었습니다.");
			}else{
				$('#userMsg').text("식당의 사정으로 예약이 반려되었습니다.");
			}
		});
		
		$('#submitMyReserve').click(function(){
			oneClickAjax();
			//window.location.href = "/happyhour/lineup/oneclick?idx="+idx+"&dateTime="+dateTime+"&approval="+approval+"oneclick=no&userMsg=";
		});
		
	});
	
	function messagePop(i,time){
		$('#navbarCollapse').removeClass('show');
		$('#idx').val(i);
		$('#dateTime').val(time);
		$('#userMsg').text(time+"에 예약이 확정되었습니다.");
  		$('#myReserveUtil').show();
  		$('#myReserveUtil').on('scroll touchmove mousewheel', function(event) {
      		event.preventDefault();
      		event.stopPropagation();
      		return false;
  		});
	}
	
	function oneClickAjax(){
		$.ajax({
			type		: "POST",
			url			: "/happyhour/lineup/oneclick",
			data		: $('#approveReservation').serialize(),
			success		: function(result){
				alert(result);
				$('#myReserveUtil').hide();
				location.reload();
			},
			error		: function(e){
				console.log(e);
			}
			
		});
	}
	
</script>
</body>

</html>
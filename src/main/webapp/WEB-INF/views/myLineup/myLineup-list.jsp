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
			<br><br>
			<form id="searchList" name="searchList">
				<input type="hidden" id="startCount" name="startCount" value="0"/>
				<input type="hidden" id="viewCount" name="viewCount" value="0"/>
				<input type="hidden" id="totalCount" name="totalCount" value="${total}"/>
				<input type="hidden" id="path" name="path" value="${path}"/>
				<input type="hidden" id="userIdx" name="userIdx" value="${userIdx}"/>
				<input type="hidden" id="pastOrNot" name="past" value="${past}"/>
				<input type="hidden" id="myOrStore" name="myOrStore" value="myPage"/>
			</form>
			<div class="in list-in" >
			
			<c:choose>
				<c:when test="${past eq null || past eq ''}">
					<ul id="top-arrow-menu-ul">
						<li>
							<a href="<c:url value='/lineup/myIndex'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:if test='${path == 2}'><c:url value='/lineup/list/2?userIdx=${userIdx}&myOrStore=myPage&past=past'/></c:if><c:if test='${path == 1}'><c:url value='/lineup/list/1?userIdx=${userIdx}&myOrStore=myPage&past=past'/></c:if>" class="top-arrow-menu">
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
							<a href="<c:url value='/lineup/myIndex'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:if test='${path == 2}'><c:url value='/lineup/list/2?userIdx=${userIdx}&myOrStore=myPage'/></c:if><c:if test='${path == 1}'><c:url value='/lineup/list/1?userIdx=${userIdx}&myOrStore=myPage'/></c:if>" class="top-arrow-menu">
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
						<div class="card align-middle list-card lineup-visit-btn">
							<c:choose>
								<c:when test="${path eq 1}">내 줄서기</c:when>
								<c:otherwise>내 예약</c:otherwise>
							</c:choose>
						</div>										
					</c:when>
					<c:otherwise>
						<div class="card align-middle list-card lineup-visit-btn">
							<c:choose>
								<c:when test="${path eq 1}">이전 줄서기 내역</c:when>
								<c:otherwise>이전 예약 내역</c:otherwise>
							</c:choose>
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
								<div class="in" >
								    <div class="card align-middle">
								        <div class="card-body">				       
									       <table style="width: 100%;">
									       <c:choose>
												<c:when test="${past eq null || past eq ''}">
											       	<c:choose>
										       			<c:when test="${path eq 1}">
													       	<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:45%;"><a href="<c:url value='/store/detail?idx=${list.store_origin}'/>">${list.store_nm}</a></td>
													       		<td style="width:25%;">대기팀: ${list.waiting}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>										       		
													       		<td style="width:15%; text-align: right;">
													       			<input type='button' class='form-control lineupNs-btn' value="취소" onclick="location.href='<c:url value='/lineup/visitTeam?visit=3&idx=${list.idx}&path=${path}&store=${list.store_origin}'/>'"/>
													       		</td>
													       	</tr>
										       			</c:when>
										       			<c:otherwise>
										       				<tr>
													       		<td style="width:5%;">${i.count}</td>
													       		<td style="width:45%;"><a href="<c:url value='/store/detail?idx=${list.store_origin}'/>">${list.store_nm}</a></td>
													       		<td style="width:25%;">${list.lineup_Date}</td>
													       		<td style="width:10%;">${list.lineup_count}명</td>											       		
													       		<td style="width:15%; text-align: right;">
													       			<input type='button' class='form-control lineupNs-btn' value="취소" onclick="location.href='<c:url value='/lineup/visitTeam?visit=3&idx=${list.idx}&path=${path}&store=${list.store_origin}'/>'"/>
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
													       		<td style="width:45%;"><a href="<c:url value='/store/detail?idx=${list.store_origin}'/>">${list.store_nm}</a></td>
													       		<td style="width:25%;">${list.lineup_Date}</td>
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
													       		<td style="width:45%;"><a href="<c:url value='/store/detail?idx=${list.store_origin}'/>">${list.store_nm}</a></td>
													       		<td style="width:25%;">${list.lineup_Date}</td>
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
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;">오늘 줄서기한 식당이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:when>
								<c:otherwise>
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;">예약한 식당이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:otherwise>
							</c:choose>						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${path eq 1}">
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;">지난 줄서기 내역이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:when>
								<c:otherwise>
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;">지난 예약 내역이 없습니다.</h5></div>
									    </div>
								    </div>
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
	.lineup-visit-btn{
		text-align: center;
		border-color: #E30F0C;
		font-size: 2rem;
		color: #E30F0C;
		font-weight: bold;
		padding: 1.5rem 0;
	}
	
	.lineupNs-btn:hover{
		background-color: #1F2229;
		color: #fff;
	}
	.box-input{
		display: inline-block !important;
		border-color: #fff !important;
	}
</style>
	
<script type="text/javascript">
	$(function(){
		var ii = 5;
		var path = '${path}';
		
		var pastOrNot = $('#pastOrNot').val();
		
		/* var real = "/happyhour/lineup/list/${path}?userIdx=${userIdx}&myOrStore=myPage";
		var past = "/happyhour/lineup/list/${path}?userIdx=${userIdx}&myOrStore=myPage&past=past"; */
		var lineup_url = window.location.href;
		
		/* $('#real').prop('href',real);
		$('#past').prop('href',past); */

		/* if (lineup_url.indexOf("past") > -1) {
      		$('.bottom-nav-li2').removeClass('on');
      		$('.bottom-nav-li2').eq(1).addClass('on');
		}else{
			$('.bottom-nav-li2').removeClass('on');
      		$('.bottom-nav-li2').eq(0).addClass('on');
		} */
		
		$('#moreList').click(function(){
			moreList('store-list',5);
		});
		
		function moreList(id, cnt) {
			var listLength = $('.listS').length;
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
				var waiting = list.waiting;
				var locaUrl = "/happyhour/lineup/visitTeam?visit=3&idx="+list.idx+"&path="+path+"&store="+list.store_origin;
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
						_html += "<td style='width:45%;'><a href='<c:url value='/store/detail?idx="+list.store_origin+"'/>'>"+list.store_nm+"</a></td>";	       		
						_html += "<td style='width:25%;'>"+list.lineup_Date+"</td>";
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: right;'>"+visit+"</td>";
						_html += "</tr></table></div></div></div></td></tr>";	       		
					}else{
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%;'>"+ii+"</td>";
						_html += "<td style='width:45%;'><a href='<c:url value='/store/detail?idx="+list.store_origin+"'/>'>"+list.store_nm+"</a></td>";	       		
						_html += "<td style='width:25%;'>"+list.lineup_Date+"</td>";
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: right;'>"+visit+"</td>";
						_html += "</tr></table></div></div></div></td></tr>";
					}					
				}else{
					if (path == 1) {					
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%; '>"+ii+"</td>";
						_html += "<td style='width:45%;'><a href='<c:url value='/store/detail?idx="+list.store_origin+"'/>'>"+list.store_nm+"</a></td>";	       		
						_html += "<td style='width:25%;'>대기팀: "+waiting+"</td>";
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: center;'><a href='<c:url value='"+locaUrl+"'/>'><input type='button' class='form-control lineupNs-btn' value='취소' onclick='location.href='"+locaUrl+"'/></a></td>";
						_html += "</tr></table></div></div></div></td></tr>";	       		
					}else{
						_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
						_html += "<td style='width:5%;'>"+ii+"</td>";
						_html += "<td style='width:45%;'><a href='<c:url value='/store/detail?idx="+list.store_origin+"'/>'>"+list.store_nm+"</a></td>";	       		
						_html += "<td style='width:25%;'>"+list.lineup_Date+"</td>";
						_html += "<td style='width:10%;'>"+list.lineup_count+"명</td>";
						_html += "<td style='width:15%; text-align: center;'><a href='<c:url value='"+locaUrl+"'/>'><input type='button' class='form-control lineupNs-btn' value='취소'/></a></td>";
						_html += "</tr></table></div></div></div></td></tr>";
					}
					
				}
					       							       			       				
			}
			$('.listS:last').after(_html);
		}

		
	});
	
</script>
</body>

</html>
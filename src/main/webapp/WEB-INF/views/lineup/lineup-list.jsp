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
				<input type="hidden" id="store" name="store" value="${store}"/>
				<input type="hidden" id="pastOrNot" name="past" value="${past}"/>
				<input type="hidden" id="service" name="service" value="${service}"/>
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
		
			<div class="in list-in" id="setting-card">					
				<i style='font-size:26px' class='fas' onclick="rsvSettingOn()">&#xf013;</i>			
			</div>
			<c:if test="${path == 1 && total > 0}">
				<div class="in clickInfo-par">
			    	<div class="card align-middle clickInfo">
			    		대기팀:&nbsp;${waiting}
			    	</div>
			    </div>
			</c:if>
																
			<c:if test="${total > 0}">
				<c:choose>
					<c:when test="${past eq null || past eq ''}">					
						<a href="<c:url value='/lineup/visitTeam?visit=1&idx=${visitTeamIdx}&path=${path}&store=${store}'/>">
							<div class="card align-middle list-card lineup-visit-btn">
								[${storeNm}]
								<c:if test="${path == 1}">
									줄서기 입장	<i class='far' class="click-far" style="font-size: 1.5rem; margin-top: 0.3rem;"><span class="click">click</span> &#xf0a6;</i>				
								</c:if>
								<c:if test="${path == 2}">
									예약 입장<i class='far' class="click-far" style="font-size: 1.5rem; margin-top: 0.3rem;"><span class="click">click</span> &#xf0a6;</i>
								</c:if>
								
							</div>
						</a>							
					</c:when>
					<c:otherwise>
						<div class="card align-middle list-card lineup-visit-btn1">
							[${storeNm}]
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
						
						<c:if test="${list.lineup_visit eq 0}"><c:set var="listcount" value="${listcount+1}" /></c:if>
						<tr class='listS'>
							<td>								
								<div class="in">
								    <div class="card align-middle">
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
										       					<c:choose>
												       				<c:when test="${list.lineup_visit eq 4}">
												       					<td style="width:5%;">
												       						<i style='font-size:20px; color: #FFAB2F;' class='fas'>&#xf0f3;</i>
																		</td>
												       					<td colspan="3">예약을 확인해주세요.</td>
												       					<td style="width:15%; text-align: right;">
												       						<input type='button' class='form-control lineupApp-btn' value="예약확인" onclick="messagePop('${list.idx}','${list.lineup_Date}','${list.lineup_nm}','${list.lineup_tel}','${list.lineup_count}')"/>
												       					</td>
												       				</c:when>
												       				<c:otherwise>
															       		<td style="width:5%;">${listcount}</td>
															       		<td style="width:40%;">${list.lineup_nm} [${list.lineup_Date}]</td>
															       		<td style="width:30%;">${list.lineup_tel}</td>
															       		<td style="width:10%;">${list.lineup_count}명</td>												       		
															       		<td style="width:15%; text-align: right;">
															       			<input type='button' class='form-control lineupNs-btn' value="노쇼" onclick="location.href='<c:url value='/lineup/visitTeam?visit=2&idx=${list.idx}&path=${path}&store=${store}'/>'"/>
															       		</td>
												       				</c:otherwise>
													       		</c:choose>
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
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;"><span class="noTitle">[${storeNm}]</span><br>대기중인 손님이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:when>
								<c:otherwise>
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;"><span class="noTitle">[${storeNm}]</span><br>예약손님이 없습니다.</h5></div>
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
									        <div class="card-body"><h5 style="width: 100%; text-align:center;"><span class="noTitle">[${storeNm}]</span><br>지난 줄서기 내역이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:when>
								<c:otherwise>
									<div class="in">
									    <div class="card align-middle">
									        <div class="card-body"><h5 style="width: 100%; text-align:center;"><span class="noTitle">[${storeNm}]</span><br>지난 예약 내역이 없습니다.</h5></div>
									    </div>
								    </div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>					
				</c:if>
			</table>
			
			<c:if test="${total > 5}">
				<div class="in list-in list-in-in" id="btn-in" style="margin-top:1rem">
					<div class="card align-middle plus-card">				
						<div class="card-body plus-card-body" id="moreList">
							<i style='font-size:1.3rem' class='fas'>&#xf078;</i>&nbsp;&nbsp;<span class="beside-icon">더보기</span>
						</div>			
					</div>
				</div>
			</c:if>
			
			<!-- <div class="in list-in" id="setting-card">
				<div class="card align-middle setting-card" onclick="rsvSettingOn()">
					<ul id="setting-ul">
						<li>
							<i style='font-size:26px' class='fas'>&#xf013;</i>
						</li>
						<li>설정</li>
					</ul>					
				</div>
			</div> -->
			<br><br><br><br>
			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
<style>
.list-in-in {
	margin-bottom: 0;
}

#setting-card {
	overflow: hidden;
	margin-top: 1rem;
	margin-bottom: 0.1rem;
	text-align: right;
	padding-right: 0.2rem;
	cursor: pointer;
}

.setting-card {
	width: 80px;
	background-color: #1F2229;
	font-weight: bold;
	padding: 0.5rem 1rem;
	float: right;
	cursor: pointer;
}

#setting-ul {
	width: 100%;
	text-align: center;
}

#setting-ul>li {
	/* display: inline-block; */
	
}

.lineup-visit-btn, .lineup-visit-btn1 {
	text-align: center;
	border-color: #E30F0C;
	font-size: 2rem;
	color: #E30F0C;
	font-weight: bold;
	padding: 1.5rem 0;
}

.lineup-visit-btn {
	cursor: pointer;
}

.lineup-visit-btn:hover {
	background-color: #E30F0C;
	color: #fff;
}

.lineupNs-btn:hover {
	background-color: #1F2229;
	color: #fff;
}

.lineupApp-btn:hover {
	border-color: #FFAB2F;
	background-color: #FFAB2F;
	color: #fff;
}

.lineupApp-btn {
	background-color: #fff;
	color: #FFAB2F;
	border-color: #FFAB2F;
}

#list-waiting {
	font-weight: normal;
	font-size: 1rem;
	line-height: 2;
}

.noTitle {
	font-weight: bold;
	line-height: 2;
	font-size: 2rem;
	color: #E30F0C;
}
</style>
	
<script type="text/javascript">
	$(function(){
		var service = $('#service').val();
		var ii = 5;
		var iii = '${listcount}';
		if (iii == null || iii == '') {
			iii = 0;
		}
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
				var apprHtml = "";
				
				if(visit == "0"){
					iii++;
					apprHtml += "<td style='width:5%; '>"+iii+"</td><td style='width:40%;'>"+list.lineup_nm+" ["+list.lineup_Date+"]</td><td style='width:30%;'>"+list.lineup_tel+"</td><td style='width:10%;'>"+list.lineup_count+"명</td><td style='width:15%; text-align: center;'>";
					apprHtml += "<input type='button' class='form-control lineupNs-btn' value='노쇼' onclick='location.href='<c:url value='/lineup/visitTeam?visit=2&idx="+list.idx+"&path="+path+"&store="+store+"'/>''/></td>";
				}else if(visit == "1") {
					visit = "입장";
				}else if (visit == "2") {
					visit = "노쇼";
				}else if (visit == "4") {
					apprHtml += "<td style='width:5%;'><i style='font-size:20px; color: #FFAB2F;' class='fas'>&#xf0f3;</i>";
					apprHtml +=	"</td><td colspan='3'>예약을 확인해주세요.</td><td style='width:15%; text-align: right;'>";
					apprHtml +=	"<input type='button' class='form-control lineupApp-btn' value='예약확인' onclick='messagePop(\""+list.idx+"\",\""+list.lineup_Date+"\",\""+list.lineup_nm+"\",\""+list.lineup_tel+"\",\""+list.lineup_count+"\")'/></td>";
				}else{
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
						_html += apprHtml;
						_html += "</tr></table></div></div></div></td></tr>";
					}	
					
				}
					       							       			       				
			}
			$('.listS:last').after(_html);
		}
		
		$('#closeMyReserveUtil').click(function(){
			$('#myReserveUtil').hide();
		});
		
		$('#closeMySetting').click(function(){
			$('.pathName').text("");
			$('#noticeMsg').val("");
			$('#myReserveSetting').hide();
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
			idx = $('#lidx').val();
			dateTime = $('#dateTime').val();
			userMsg = $('#userMsg').val();
			approval = $("input[name='approval']:checked").val();
			if (userMsg == null || userMsg == '') {
				alert("메세지를 입력해주세요.");
				return false;
			}else{				
				$('#approveReservation').submit();
			}
		});
		
		$('#submitMySetting').click(function(){
			if (userMsg == null || userMsg == '') {
				alert("메세지를 입력해주세요.");
				return false;
			}else{				
				$('#settingReservation').submit();
			}
		});
		
		$('#userMsg').on('keyup', function() {
	        $('#test_cnt').html("("+$(this).val().length+" / 40)");
	        $('#test_cnt').show();
	        if($(this).val().length > 40) {
	        	alert("글자수는 40자를 넘을 수 없습니다.");
	            $(this).val($(this).val().substring(0, 39));
	            $('#test_cnt').html("(40 / 40)");
	        }
	    });
		
		$('#noticeMsg').on('keyup', function() {
	        $('#test_cnt1').html("("+$(this).val().length+" / 40)");
	        $('#test_cnt1').show();
	        if($(this).val().length > 40) {
	        	alert("글자수는 40자를 넘을 수 없습니다.");
	            $(this).val($(this).val().substring(0, 39));
	            $('#test_cnt1').html("(40 / 40)");
	        }
	    });
		
		
	});
	var idx;
	var dateTime;
	var approval;
	var userMsg;

	function messagePop(i,time,nm,tel,cnt){
		$('#navbarCollapse').removeClass('show');
		$('#lidx').val(i);
		$('#dateTime').val(time);
		$('#nm').val(nm);
		$('#tel').val(tel);
		$('#cnt').val(cnt+"명");
		$('#userMsg').val(time+"에 예약이 확정되었습니다.");
		$('#myReserveUtil').show();
		$('#myReserveUtil').on('scroll touchmove mousewheel', function(event) {
	 		event.preventDefault();
	 		event.stopPropagation();
	 		return false;
		});
	}
	
	function rsvSettingOn(){
		$('#navbarCollapse').removeClass('show');
		var pathName = "";
		if ($('#path').val() == 1) {
			pathName = "줄서기";
		}else{
			pathName = "예약";
		}
		$('.pathName').text(pathName);
		$("input:radio[name='serviceYn']:radio[value='"+$('#service').val()+"']").prop('checked', true);
		$('#settingReservation').attr('action','/happyhour/store/setting/'+path+'?idx='+store);
		console.log($('#service').val());
		$('#noticeMsg').val(pathName+" 준비중");
		$('#myReserveSetting').show();
		$('#myReserveSetting').on('scroll touchmove mousewheel', function(event) {
	 		event.preventDefault();
	 		event.stopPropagation();
	 		return false;
		});
	}
	
	
	
</script>
</body>

</html>
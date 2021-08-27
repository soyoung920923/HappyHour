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
				<input type="hidden" id="store" name="store" value="${store}"/>
			</form>
			<div class="in list-in" >
			    <ul id="top-arrow-menu-ul">
					<li>
						<a href="<c:url value='/store/list?business=business'/>" class="top-arrow-menu">
							<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
							</svg>&nbsp;목록
						</a>
					</li>
					<%-- <li>
						<a href="<c:url value='/store/board?idx=${store.idx}'/>" class="top-arrow-menu">휴일등록&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
							</svg>
						</a>
					</li> --%>
				</ul>
			</div>
			<div class="in list-in" >							
				<div class="card align-middle list-card lineup-visit-btn" onclick="holidayEnroll('${store}','${storeNm}')">
					[${storeNm}]
					휴일 등록	<i class='far' class="click-far" style="font-size: 1.5rem; margin-top: 0.3rem;"><span class="click">click</span> &#xf0a6;</i>
				</div>							
			</div>
			
			<table style="margin: 0 auto; width: 100%;" id="store-list">
				<c:if test="${total > 0}">
					<c:forEach items="${list}" var="list" varStatus="i">
						<tr class='listS'>
							<td>								
								<div class="in">
								    <div class="card align-middle">
								        <div class="card-body">				       
									       <table style="width: 100%;">
									       		<tr>
										       		<td style="width:5%;">${i.count}</td>
										       		<td style="width:29%; text-align: center;">${list.holiday_start}</td>
										       		<td style="width:2%; text-align: center;">~</td>
										       		<td style="width:29%; text-align: center;">${list.holiday_end}</td>											       		
										       		<td style="width:20%; text-align: center;">${list.holiday_status}</td>
										       		<td style="width:15%; text-align: right;">
										       			<input type='button' class='form-control lineupNs-btn' value="삭제" onclick="deleteHoliday('${list.idx}')"/>
										       		</td>
										       	</tr>
									       </table> 				               
								        </div>   
								    </div>
								</div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${total < 1}">
					<div class="in">
					    <div class="card align-middle">
					        <div class="card-body"><h5 style="width: 100%; text-align:center;">등록한 휴일이 없습니다.</h5></div>
					    </div>
				    </div>				
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
		
		var ii = 5;	
		var store = $('#store').val();
		var storeNm = '${storeNm}';
		
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
				url			: "/happyhour/holiday/getMoreList",
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
				ii++;				
				_html += "<tr class='listS'><td><div class='in'><div class='card align-middle'><div class='card-body'><table style='width: 100%;'><tr>";
				_html += "<tr><td style='width:5%;'>"+ii+"</td>";
				_html += "<td style='width:29%; text-align: center;'>"+list.holiday_start+"</td>";
				_html += "<td style='width:2%; text-align: center;'>~</td>";
				_html += "<td style='width:29%; text-align: center;'>"+list.holiday_end+"</td>";											       		
				_html += "<td style='width:20%; text-align: center;'>"+list.holiday_status+"</td>";
				_html += "<td style='width:15%; text-align: right;'>";
				_html += "<input type='button' class='form-control lineupNs-btn' value='삭제' onclick='deleteHoliday(\""+list.idx+"\")'/></td></tr>";
				_html += "</tr></table></div></div></div></td></tr>";
					       							       			       				
			}
			$('.listS:last').after(_html);
		}
		
		$(document).on('change', "input[name='todayYn']" ,function() {
			var todayYn = $("input[name='todayYn']:checked").val();
			if (todayYn == 0) {
				$('#holiday-input-date').animate({
					height: '+=119'
				}, 500);
			}else{
				$('#holiday-input-date').animate({
					height: '-=119'
				}, 500);
			}
		});
		
		$('#closeMyHoliday').click(function(){
			$('#holiday_storeNm').text("");
			$('#hstore').val("");
			$('#history').attr('href','');
			$("input:radio[name='todayYn']:radio[value=1]").prop('checked', true);
			$("#startDate").val("");
			$("#endDate").val("");
			$("#holiday_status").val("");
			$('#myHolidaySetting').hide();
		});
		
		$('#submitMyHoliday').click(function(){
			
			var todayYn = $("input:radio[name='todayYn']:checked").val();
			if (todayYn == '2' && $('#startDate').val() == null || $('#endDate').val() == null) {
				alert("지정일을 입력해주세요.");
				return false;
			}else if ($('#holiday_status').val() == null || $('#holiday_status').val() == '') {
				alert("휴일구분을 입력해주세요.");
				return false;
			}else{	
				$('#settingHoliday').attr('action','/happyhour/holiday/enroll');
				$('#settingHoliday').submit();
			}	
		});
		
	});
	
	
	function holidayEnroll(idx, name){
		$('#holiday_storeNm').text("[ "+name+" ]");
		$('#hstore').val(idx);
		$('#history').attr('href','/happyhour/holiday/list?store='+idx);
		$('#myHolidaySetting').show();
		$('#myHolidaySetting').on('scroll touchmove mousewheel', function(event) {
	 		event.preventDefault();
	 		event.stopPropagation();
	 		return false;
		});
	}
	
	function deleteHoliday(idx){
		var deleteYn = confirm("휴일을 삭제하시겠습니까?");
		if (deleteYn) {
			location.href="/happyhour/holiday/delete?idx="+idx+"&store="+'${store}';
			
		}
	}
	
	
</script>
</body>

</html>
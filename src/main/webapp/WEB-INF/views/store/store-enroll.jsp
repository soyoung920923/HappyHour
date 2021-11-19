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
		<form:form modelAttribute="store" action="" id="f" name="f" method="POST" enctype="multipart/form-data">
			<c:if test="${store ne null}">
				<input type="hidden" name="idx" value="${store.idx}" />
			</c:if>
			<br><br>
			<c:if test="${store ne null}">			
				<%-- <div class="in clickInfo-par">
			    	<div class="card align-middle clickInfo">
			    		클릭수&nbsp;${store.hit_Count}
			    	</div>
			    </div> --%>
			    <div class="in list-in" >
				    <ul id="top-arrow-menu-ul">
						<li>
							<a href="<c:url value='/store/list?business=business'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:url value='/store/board?idx=${store.idx}'/>" class="top-arrow-menu">통계&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
								</svg>
							</a>
						</li>
					</ul>
				</div>
			</c:if>
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">
			            	<c:choose>
								<c:when test="${store ne null}">
									${store.store_Nm}
								</c:when>
								<c:otherwise>
									Store
								</c:otherwise>
							</c:choose>			            
			            </h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
				        <label class="sy-only">*상호명</label><br>
						<input type="text" name="store_Nm" id="storeNm" class="form-control" value="${store.store_Nm}"><br>
						<label class="sy-only">*대표사진</label><br>
						<c:choose>
							<c:when test="${store ne null}">
								<div style="margin-bottom: 1.2rem;">
									<input type="text" name="prev_img" id="prev_img" class="form-control" value="${store.store_Img}" readonly>
									<button type="button" class="btn-btn btn" id="change-img">사진변경</button><br>
									<input type="file" name="file" id="file" class="form-control hidFile" onchange="filName(this)">
								</div>
							</c:when>
							<c:otherwise>
								<input type="file" name="file" id="file" class="form-control" ><br>
							</c:otherwise>
						</c:choose>
						<label class="sy-only">*구분</label><br>
						<div id="chk-wrap">
					    	<input type="radio" name="store_Idt" class="storeIdt" value="1" class="inputName" <c:if test="${store.store_Idt eq '1'}"> checked </c:if>/>&nbsp;한식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="2" class="inputName" <c:if test="${store.store_Idt eq '2'}"> checked </c:if>/>&nbsp;분식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="3" class="inputName" <c:if test="${store.store_Idt eq '3'}"> checked </c:if>/>&nbsp;중식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="4" class="inputName" <c:if test="${store.store_Idt eq '4'}"> checked </c:if>/>&nbsp;패스트푸드&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="5" class="inputName" <c:if test="${store.store_Idt eq '5'}"> checked </c:if>/>&nbsp;양식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="6" class="inputName" <c:if test="${store.store_Idt eq '6'}"> checked </c:if>/>&nbsp;카페/디저트&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="7" class="inputName" <c:if test="${store.store_Idt eq '7'}"> checked </c:if>/>&nbsp;일식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="8" class="inputName" <c:if test="${store.store_Idt eq '8'}"> checked </c:if>/>&nbsp;아시안
					    </div>
					    <label class="sy-only">*대표전화</label><br>
					    <input type="text" name="store_Tel" id="storeTel" class="form-control" placeholder="'-' 없이 숫자만 입력" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${store.store_Tel }"><br>
						<label class="sy-only">*위치</label><br>
						<button type="button" class="btn-btn btn" id="findPostcode" onclick="findPostcode1()" class="form-control">우편번호 찾기</button>
						<input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control" readonly>
						<input type="text" name="address" id="address" placeholder="주소" class="form-control" readonly>
						<div id="address"></div>
						<input type="text" name="address2" id="address2" placeholder="상세주소" class="form-control" value="${store.store_Address_Dt}">
						<div id="address2"></div><br>
						<input type="hidden" name="store_Address" id="storeAddress" value="${store.store_Address}">
						<input type="hidden" name="store_Address_Dt" id="storeAddressDt" value="${store.store_Address_Dt}">
						<label class="sy-only">*영업시간</label><br>
						<select class="form-control store-select" name="store_open" id="store_open">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet}" var="time">
								<option value="${time}" <c:if test="${store.store_open eq time}"> selected </c:if>>${time}</option>
							</c:forEach>
						</select>
						&nbsp;~&nbsp;
						<select class="form-control store-select" name="store_close" id="store_close">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet}" var="time">
								<option value="${time}" <c:if test="${store.store_close eq time}"> selected </c:if>>${time}</option>
							</c:forEach>
						</select>
						<br>
						<label class="sy-only">브레이크&nbsp;&nbsp;
							<input type="checkbox" name="store_break" value="0" id="store_break" <c:if test="${store.store_break eq 0}"> checked </c:if>/> 있음
						</label><br>
						<select class="form-control store-select" name="break_start" id="break_start" <c:if test="${store.store_break ne 0}"> disabled </c:if>>
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet}" var="time">
								<option value="${time}" <c:if test="${store.store_open eq time}"> selected </c:if>>${time}</option>
							</c:forEach>
						</select>
						&nbsp;~&nbsp;
						<select class="form-control store-select" name="break_end" id="break_end" <c:if test="${store.store_break ne 0}"> disabled </c:if>>
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet}" var="time">
								<option value="${time}" <c:if test="${store.store_close eq time}"> selected </c:if>>${time}</option>
							</c:forEach>
						</select>
						<br>
						<br>		
						<label class="sy-only">*가게소개</label><br>
						<textarea class="form-control" placeholder="200자 이내" id="storeInfo" name="store_Info">${store.store_Info}</textarea>
						<div id="test_cnt2" style="width: 100%; text-align:right; font-size: 0.8rem; display: none;">(0 / 200)</div>
						<br>
						<label class="sy-only">기타서비스 사용</label><br>
						<input type="checkbox" name="line_yn" value="1" id="line_yn"<c:if test="${store.line_yn ne 0}"> checked </c:if>/> 줄서기&nbsp;&nbsp;
						<input type="checkbox" name="rsv_yn" value="1" id="rsv_yn" <c:if test="${store.rsv_yn ne 0}"> checked </c:if>/> 예약
						<br>
						<br>
						<label class="sy-only">정기휴일</label><br>
						<c:forEach items="${store.holidays}" var="holiday">
							<c:if test="${holiday eq 2}"><c:set var="mon" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 3}"><c:set var="tue" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 4}"><c:set var="wed" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 5}"><c:set var="thu" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 6}"><c:set var="fri" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 7}"><c:set var="sat" value="${holiday}"/></c:if>							
							<c:if test="${holiday eq 1}"><c:set var="sun" value="${holiday}"/></c:if>							
						</c:forEach>
						<input type="checkbox" name="holidays" value="2" class="holiday" <c:if test="${mon eq 2}">checked</c:if>/> 월&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="3" class="holiday" <c:if test="${tue eq 3}">checked</c:if>/> 화&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="4" class="holiday" <c:if test="${wed eq 4}">checked</c:if>/> 수&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="5" class="holiday" <c:if test="${thu eq 5}">checked</c:if>/> 목&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="6" class="holiday" <c:if test="${fri eq 6}">checked</c:if>/> 금&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="7" class="holiday" <c:if test="${sat eq 7}">checked</c:if>/> 토&nbsp;&nbsp;
						<input type="checkbox" name="holidays" value="1" class="holiday" <c:if test="${sun eq 1}">checked</c:if>/> 일&nbsp;&nbsp;
						<input type="checkbox" name="etc" value="etc" id="etc" <c:if test="${store.holiday_etc ne null && store.holiday_etc ne ''}">checked</c:if>/> 기타&nbsp;&nbsp;
						<div id="etc-box">
							<input type="text" name="holiday_etc" value="${store.holiday_etc}" id="holidayEtc" class="form-control" placeholder="예: 첫째/셋째 일요일"/>
							<span id="etc-comment">
								<i style="font-size: 1rem;" class='fas'>&#xf05a;</i>
								기타로 휴일 입력 시 가게 운영/미운영을 직접 설정하셔야합니다.
							</span>
						</div>
						
												
						<input type="hidden" name="latitude" id="latitude" value="${store.latitude}"/>
						<input type="hidden" name="longitude" id="longitude" value="${store.longitude}"/>
						<div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" id="enroll-btn">저&nbsp;장</button>
			              <c:if test="${store ne null}">
			              	<button type="button" class="btn-btn btn form-control" id="delete-btn">삭&nbsp;제</button>
			              </c:if>
			            </div>   
						<!-- <input type="submit" value="제출"/> -->
					        
			        </div>
			    </div>
			</div>
			<br><br><br><br>
			
		</form:form>		
	</main>
	
	 <%-- <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
</body>
<script type="text/javascript">
$(function(){
	$('#bottom-nav3').css('display','block');
	$('#fixed-box-top').css('bottom','5.5%');
	$('.bottom-nav-li3').removeClass('on');
	$('.bottom-nav-li3').eq(2).addClass('on');
		
	var saveOrDelete = 0;
	
	var add = '${store.store_Address}';
	var postcode = add.split("|")[0];
	var address = add.split("|")[1];

	$('#postcode').val(postcode);
	$('#address').val(address);
	
	if ($("input:checkbox[name=holidays]:checked").length > 0) {
		$('#etc').prop('disabled',true);
	}
	if ($("input:checkbox[name=etc]:checked").length > 0) {
		$('.holiday').prop('disabled',true);
		$('#etc-box').show();
	}
	
	$('#enroll-btn').click(function(){
		submitWhere(saveOrDelete);
	});
	
	$('#delete-btn').click(function(){
		var res = confirm("스토어를 영구적으로 삭제하시겠습니까?");
		var idx = '${store.idx}'
		if (res) {
			saveOrDelete = 1;
			submitWhere(saveOrDelete);
		}else{
			
		}
	});
	
	$(document).on('change', "input[name='file']" ,function() {
		var chkFileName = $(this).val();
		chkFileName = chkFileName.split('.').pop().toLowerCase();
		if ($.inArray(chkFileName, ['hwp','pdf', 'xls', 'zip', 'pptx', 'xlsx','doc']) > -1) {
			alert("이미지 형식의 파일만 업로드 가능합니다.");
			$(this).val("");
		}
	});
	
	$(document).on('change', "input[name='store_break']" ,function() {
		
		if ($(this).is(":checked")) {
			$(this).val("1");
			$('#break_start').prop('disabled',false);
			$('#break_end').prop('disabled',false);
		}else{
			$(this).val("0");			
			$('#break_start option:eq(0)').prop("selected", true);
			$('#break_end option:eq(0)').prop("selected", true);
			$('#break_start').prop('disabled',true);
			$('#break_end').prop('disabled',true);
		}
	});
	
	$(document).on('change', "input[name='holidays']" ,function() {
		if ($(this).is(":checked")) {
			$('#etc').prop('disabled',true);
		}else{
			var chkCnt = $("input:checkbox[name=holidays]:checked").length;
			if (chkCnt < 1) {
				$('#etc').prop('disabled',false);
			}			
		}
		
	});
	$(document).on('change', "input[name='etc']" ,function() {
		if ($(this).is(":checked")) {
			$('.holiday').prop('disabled',true);
			$('#etc-box').show();
		}else{
			$('.holiday').prop('disabled',false);
			$('#holidayEtc').val("");
			$('#etc-box').hide();
		}
	});
	
	
	$('#change-img').click(function(){
		if ($(this).hasClass('cancel')) {
			$('.hidFile').removeClass('show');
			$(this).removeClass('cancel');
			$(this).text('사진변경');
			$('.hidFile').val('');
			$('#prev_img').val('${store.store_Img}');
		}else{
			$('.hidFile').addClass('show');
			$(this).addClass('cancel');
			$(this).text('변경취소');
		}		
	});
	
	$('.hidFile').on('change',function(){
		var fileValue=$(this).val().split("\\");;
		var fileName = fileValue[fileValue.length-1];
		$('#prev_img').val(fileName);
	});
	
	$('#storeInfo').on('keyup', function() {
        $('#test_cnt2').html("("+$(this).val().length+" / 200)");
        $('#test_cnt2').show();
        if($(this).val().length > 200) {
        	alert("글자수는 40자를 넘을 수 없습니다.");
            $(this).val($(this).val().substring(0, 199));
            $('#test_cnt2').html("(200 / 200)");
        }
    });
	
	function submitWhere(saveOrDelete){
		
		if (saveOrDelete == 0) {
			
			var breakYn = $('#store_break').val();
			if (breakYn == 1) {
				if ($('#break_start').val() == null || $('#break_start').val() == '') {
					alert("브레이크 시작 시간을 입력해주세요");
					$(this).focus();
					return;
				}else if($('#break_end').val() == null || $('#break_end').val() == ''){
					alert("브레이크 종료 시간을 입력해주세요");
					$(this).focus();
					return;
				}
			}
			
			var pst = $('#postcode').val();
			var add = $('#address').val();
			var address = "";
			if (pst != null && pst != "") {
				pst = pst+"|";		
			}
			address = address.concat(pst).concat(add);
			$('#storeAddress').val(String(address));

			var addressDt = $('#address2').val();
			
			$('#storeAddressDt').val(addressDt);
				
		    if($('#storeNm').val() == null || $('#storeNm').val() == ''){
				alert('상호명을 입력하세요');
				$(this).focus();
				return;
			}
			if ('${store.store_Img}' == null) {
				
			    if($('#file').val() == null || $('#file').val() == ''){
					alert('배너사진을 선택하세요');
					$(this).focus();
					return;
				}
			    
			}
		    if($('.storeIdt').val() == null || $('.storeIdt').val() == ''){
				alert('구분을 입력하세요');
				$(this).focus();
				return;
			}
		   	if($('#storeTel').val() == null || $('#storeTel').val() == ''){
				alert('대표번호를 입력하세요');
				$(this).focus();
				return;
			}
		   	if($('#storeAddress').val() == null || $('#storeAddress').val() == ''){
				alert('우편번호 찾기를 통해 주소를 입력하세요');
				$('#findPostcode1').focus();
				return;
			}
		   	if($('#storeAddressDt').val() == null || $('#storeAddressDt').val() == ''){
				alert('상세주소를 입력하세요');
				$(this).focus();
				return;
			}
		   	if($('#storeInfo').val() == null || $('#storeInfo').val() == ''){
				alert('소개를 입력하세요');
				$(this).focus();
				return;
		   	}
		   	
		   	$('#f').attr('action','enroll');
		}else{
			$('#f').attr('action','deleteStore');
		}
		
		
	   	
	   $('#f').submit();
	}
	
	
});





</script>
</html>
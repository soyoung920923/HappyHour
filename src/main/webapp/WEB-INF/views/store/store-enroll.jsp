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
			<c:if test="${store ne null }">
				<input type="hidden" name="idx" value="${store.idx}" />
			</c:if>
			<br><br><br>
			<c:if test="${store ne null }">			
				<div class="in clickInfo-par">
			    	<div class="card align-middle clickInfo">
			    		클릭수&nbsp;${store.hit_Count }
			    	</div>
			    </div>
			</c:if>
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Store</h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
				        <label class="sy-only">*상호명</label><br>
						<input type="text" name="store_Nm" id="storeNm" class="form-control" value="${store.store_Nm }"><br>
						<label class="sy-only">*대표사진</label><br>
						<c:choose>
							<c:when test="${store ne null }">
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
					    	<input type="radio" name="store_Idt" class="storeIdt" value="1" class="inputName" <c:if test="${store.store_Idt eq '1' }"> checked </c:if>/>&nbsp;한식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="2" class="inputName" <c:if test="${store.store_Idt eq '2' }"> checked </c:if>/>&nbsp;분식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="3" class="inputName" <c:if test="${store.store_Idt eq '3' }"> checked </c:if>/>&nbsp;중식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="4" class="inputName" <c:if test="${store.store_Idt eq '4' }"> checked </c:if>/>&nbsp;패스트푸드&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="5" class="inputName" <c:if test="${store.store_Idt eq '5' }"> checked </c:if>/>&nbsp;양식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="6" class="inputName" <c:if test="${store.store_Idt eq '6' }"> checked </c:if>/>&nbsp;카페/디저트&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="7" class="inputName" <c:if test="${store.store_Idt eq '7' }"> checked </c:if>/>&nbsp;일식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="8" class="inputName" <c:if test="${store.store_Idt eq '8' }"> checked </c:if>/>&nbsp;아시안
					    </div>
					    <label class="sy-only">*대표전화</label><br>
					    <input type="text" name="store_Tel" id="storeTel" class="form-control" placeholder="'-' 없이 숫자만 입력" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${store.store_Tel }"><br>
						<label class="sy-only">*위치</label><br>
						<button type="button" class="btn-btn btn" id="findPostcode" onclick="findPostcode1()" class="form-control">우편번호 찾기</button>
						<input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control" readonly>
						<input type="text" name="address" id="address" placeholder="주소" class="form-control" readonly>
						<div id="address"></div>
						<input type="text" name="address2" id="address2" placeholder="상세주소" class="form-control" value="${store.store_Address_Dt }">
						<div id="address2"></div><br>
						<input type="hidden" name="store_Address" id="storeAddress" value="${store.store_Address}">
						<input type="hidden" name="store_Address_Dt" id="storeAddressDt" value="${store.store_Address_Dt }">
						<label class="sy-only">*영업시간</label><br>
						<select class="form-control store-select" name="store_open" id="store_open">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet }" var="time">
								<option value="${time }" <c:if test="${store.store_open eq time }"> selected </c:if>>${time }</option>
							</c:forEach>
						</select>
						&nbsp;~&nbsp;
						<select class="form-control store-select" name="store_close" id="store_close">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet }" var="time">
								<option value="${time }" <c:if test="${store.store_close eq time }"> selected </c:if>>${time }</option>
							</c:forEach>
						</select>
						<br>
						<label class="sy-only">브레이크&nbsp;&nbsp;
							<input type="checkbox" name="store_break" value="" id="store_break"/> 없음
						</label><br>
						<select class="form-control store-select" name="break_start" id="break_start">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet }" var="time">
								<option value="${time }" <c:if test="${store.store_open eq time }"> selected </c:if>>${time }</option>
							</c:forEach>
						</select>
						&nbsp;~&nbsp;
						<select class="form-control store-select" name="break_end" id="break_end">
							<option value="" disabled selected hidden>선택하세요</option>
							<c:forEach items="${timeSet }" var="time">
								<option value="${time }" <c:if test="${store.store_close eq time }"> selected </c:if>>${time }</option>
							</c:forEach>
						</select>
						<br>
						<br>
						
						<label class="sy-only">*상세설명</label><br>
						<textarea class="form-control" placeholder="200자 이내" id="storeInfo" name="store_Info">${store.store_Info }</textarea>
						<input type="hidden" name="latitude" id="latitude" value="${store.latitude}"/>
						<input type="hidden" name="longitude" id="longitude" value="${store.longitude}"/>
						<div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" id="enroll-btn">저&nbsp;장</button>
			              <c:if test="${store ne null }">
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
	
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
</body>
<script type="text/javascript">
$(function(){
	var saveOrDelete = 0;
	
	var add = '${store.store_Address}';
	var postcode = add.split("|")[0];
	var address = add.split("|")[1];

	$('#postcode').val(postcode);
	$('#address').val(address);
	
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
			$('#break_start option:eq(0)').prop("selected", true);
			$('#break_end option:eq(0)').prop("selected", true);
			$('#break_start').prop('disabled',true);
			$('#break_end').prop('disabled',true);
		}else{
			$(this).val("0");
			$('#break_start').prop('disabled',false);
			$('#break_end').prop('disabled',false);
		}
	});
	
	$('#change-img').click(function(){
		if ($(this).hasClass('cancel')) {
			$('.hidFile').removeClass('show');
			$(this).removeClass('cancel');
			$(this).text('사진변경');
			$('.hidFile').val('');
			$('#prev_img').val('${banner.banner_img}');
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../commons/head.jsp" />
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
	
	<main>
		<form:form modelAttribute="store" action="enroll" id="f" name="f" method="POST" enctype="multipart/form-data">
			<br><br><br> 
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Store</h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
				        <label class="sy-only">*상호명</label><br>
						<input type="text" name="store_Nm" id="storeNm" class="form-control" autofocus><br>
						<label class="sy-only">*대표사진</label><br>
						<input type="file" name="file" id="file" class="form-control" ><br>
						<label class="sy-only">*구분</label><br>
						<div id="chk-wrap">
					    	<input type="radio" name="store_Idt" class="storeIdt" value="1" class="inputName"/>&nbsp;한식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="2" class="inputName"/>&nbsp;분식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="3" class="inputName"/>&nbsp;중식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="4" class="inputName"/>&nbsp;패스트푸드&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="5" class="inputName"/>&nbsp;양식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="6" class="inputName"/>&nbsp;카페/디저트&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="7" class="inputName"/>&nbsp;일식&nbsp;&nbsp;
						    <input type="radio" name="store_Idt" class="storeIdt" value="8" class="inputName"/>&nbsp;아시안
					    </div>
					    <label class="sy-only">*대표전화</label><br>
					    <input type="text" name="store_Tel" id="storeTel" class="form-control" placeholder="'-' 없이 숫자만 입력" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"><br>
						<label class="sy-only">*위치</label><br>
						<button type="button" class="btn-btn btn" id="findPostcode" onclick="findPostcode1()" class="form-control">우편번호 찾기</button>
						<input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control" readonly>
						<input type="text" name="address" id="address" placeholder="주소" class="form-control" readonly>
						<div id="address"></div>
						<input type="text" name="address2" id="address2" placeholder="상세주소" class="form-control">
						<div id="address2"></div><br>
						<input type="hidden" name="store_Address" id="storeAddress">
						<input type="hidden" name="store_Address_Dt" id="storeAddressDt">
						<label class="sy-only">*상세설명</label><br>
						<textarea class="form-control" placeholder="200자 이내" id="storeInfo" name="store_Info"></textarea>
						<div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" id="enroll-btn">등&nbsp;록</button> 
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
	$('#enroll-btn').click(function(){
		enrollCheck();
	});
	
	$(document).on('change', "input[name='file']" ,function() {
		var chkFileName = $(this).val();
		chkFileName = chkFileName.split('.').pop().toLowerCase();
		if ($.inArray(chkFileName, ['hwp','pdf', 'xls', 'zip', 'pptx', 'xlsx','doc']) > -1) {
			alert("이미지 형식의 파일만 업로드 가능합니다.");
			$(this).val("");
		}
	});
	
	
	function enrollCheck(){
		
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
	    if($('#file').val() == null || $('#file').val() == ''){
			alert('대표사진을 선택하세요');
			$(this).focus();
			return;
		}
	    if($('.storeIdt').val() == null || $('#storeIdt').val() == ''){
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
	   	
	   $('#f').submit();
	}
});



</script>
</html>
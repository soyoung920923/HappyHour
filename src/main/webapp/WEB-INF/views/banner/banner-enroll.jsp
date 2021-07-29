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
		
		<form:form modelAttribute="banner" action="" id="f" name="f" method="POST" enctype="multipart/form-data">
			<c:if test="${banner ne null}">
				<input type="hidden" name="idx" value="${banner.idx}" />
			</c:if>
			<br><br><br> 
			<c:if test="${banner ne null}">			
				<div class="in clickInfo-par">
			    	<div class="card align-middle clickInfo">
			    		클릭수&nbsp;${banner.hit_count}
			    	</div>
			    </div>
			</c:if>
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Maketing Bnner</h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
						<label class="sy-only">*배너사진</label><br>
						<c:choose>
							<c:when test="${banner ne null}">
								<div style="margin-bottom: 1.2rem;">
									<input type="text" name="prev_img" id="prev_img" class="form-control" value="${banner.banner_img}" readonly>
									<button type="button" class="btn-btn btn" id="change-img">사진변경</button><br>
									<input type="file" name="file" id="file" class="form-control hidFile" onchange="filName(this)">
								</div>
							</c:when>
							<c:otherwise>
								<input type="file" name="file" id="file" class="form-control" ><br>
							</c:otherwise>
						</c:choose>
						<label class="sy-only">*캡션사용</label><br>
						<div id="chk-wrap">
					    	<input type="radio" name="caption_yn" class="storeIdt" value="1" class="inputName" <c:if test="${banner.caption_yn eq '1'}"> checked </c:if> />&nbsp;사용&nbsp;&nbsp;
					    	<input type="radio" name="caption_yn" class="storeIdt" value="0" class="inputName" <c:if test="${banner.caption_yn ne '1'}">checked </c:if> />&nbsp;미사용&nbsp;&nbsp;					    
					    </div>
					    <div id="yesCaption">
					    	<label class="sy-only">제목</label><br>
							<input type="text" name="banner_subject" id="banner_subject" class="form-control" value="${banner.banner_subject}" />
							<label class="sy-only">내용</label><br>
							<input type="text" name="banner_contents" id="banner_contents" class="form-control" value="${banner.banner_contents}"/>		
							<label class="sy-only">*위치</label><br>
							<div id="chk-wrap">
						    	<input type="radio" name="banner_caption" class="storeIdt banner_caption" value="0" class="inputName" <c:if test="${banner.banner_caption eq '0'}"> checked </c:if>/>&nbsp;가운데&nbsp;&nbsp;
							    <input type="radio" name="banner_caption" class="storeIdt banner_caption" value="1" class="inputName" <c:if test="${banner.banner_caption eq '1'}"> checked </c:if>/>&nbsp;왼쪽&nbsp;&nbsp;
							    <input type="radio" name="banner_caption" class="storeIdt banner_caption" value="2" class="inputName" <c:if test="${banner.banner_caption eq '2'}"> checked </c:if>/>&nbsp;오른쪽&nbsp;&nbsp;
						    </div>
					    </div>				        
					    <label class="sy-only">연결링크</label><br>
						<input type="text" name="banner_link" id="banner_link" class="form-control" value="${banner.banner_link}"><br>
						<label class="sy-only">*순서</label><br>
						<select class="form-control" name="banner_order">
							<c:forEach items="${order}" var="order">
								<option value="${order}" <c:if test="${banner.banner_order eq order}"> selected </c:if>>${order}</option>
							</c:forEach>
						</select>
						<div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" id="enroll-btn">저&nbsp;장</button>
			              <c:if test="${banner ne null}">
			              	<button type="button" class="btn-btn btn form-control" id="delete-btn">삭&nbsp;제</button>
			              </c:if>
			            </div> 
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
<style>
	#yesCaption{height: 0; overflow: hidden;}
</style>
<script type="text/javascript">
$(function(){
	
	
	var bannerOj = '${banner}';
	var isCap = $('input[name="caption_yn"]:checked').val();
	
	var saveOrDelete = 0;
	
	if (isCap == 1) {
		$('#yesCaption').animate({
			height: '+=200'
		}, 500);
	}
	
	$('#enroll-btn').click(function(){
		submitWhere(saveOrDelete);
	});
	
	$('#delete-btn').click(function(){
		var res = confirm("배너를 영구적으로 삭제하시겠습니까?");
		var idx = '${banner.idx}'
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
	
	
	
	$(document).on('change', "input[name='caption_yn']" ,function() {
		isCap = $(this).val();
		
		if (isCap == 1) {
			$('#yesCaption').animate({
				height: '+=200'
			}, 500);
		}else{
			$('#banner_subject').val("");
			$('#banner_contents').val("");
			$('.banner_caption').val("");
			$('#yesCaption').animate({
				height: '-=200'
			}, 200);
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
			isCap = $("input[name='caption_yn']:checked").val();
			
			if (bannerOj == null) {
				
			    if($('#file').val() == null || $('#file').val() == ''){
					alert('배너사진을 선택하세요');
					$(this).focus();
					return;
				}
			    
			}
			
		     
		    if (isCap == 1) {
		    	var subj = $('#banner_subject').val();
		    	var conts = $('#banner_contents').val();
		    	
				if ((subj == null && conts == null) || (subj == '' && conts == '')) {
					alert('캡션의 제목과 내용 중 한가지는 입력하여야 합니다');
					$('#banner_subject').focus();
					return;
				}else if($('.banner_caption').val() == null || $('.banner_caption').val() == ''){
					alert('캡션이 표시될 위치를 선택하세요');
					$('.banner_caption').focus();
					return;
				}
			}
		    
		    $('#f').attr('action','enroll');
		}else{
			$('#f').attr('action','deleteBanner');
		}
		
	    
	   	
	   $('#f').submit();
	}

});



</script>
</html>
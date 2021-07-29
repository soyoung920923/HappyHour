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
		<form:form modelAttribute="lineup" action="" id="f" name="f" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="store_origin" value="${store_origin}" />
			<c:if test="${lineup ne null}">
				<input type="hidden" name="idx" value="${lineup.idx}" />
			</c:if>
			<br><br><br>
				
			<div class="in clickInfo-par">
		    	<div class="card align-middle clickInfo">
		    		대기팀:&nbsp;${waiting}
		    	</div>
		    </div>
			
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Line Up!</h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
				        <%-- <label class="sy-only">*이름</label><br>
						<input type="text" name="lineup_nm" id="storeNm" class="form-control" value="${lineup.lineup_nm }"><br> --%>
						
						<!-- <label class="sy-only">*구분</label><br> -->
						<div id="chk-wrap">
					    	<%-- <input type="radio" name="lineup_yn" class="storeIdt" value="1" class="inputName" <c:if test="${lineup.lineup_yn eq '1' }"> checked </c:if>/>&nbsp;줄서기&nbsp;&nbsp;
						    <input type="radio" name="lineup_yn" class="storeIdt" value="2" class="inputName" <c:if test="${lineup.lineup_yn eq '2' }"> checked </c:if>/>&nbsp;예약&nbsp;&nbsp;
					    	 --%>
					    	<br>
					    	<input type="radio" class="btn-check" name="lineup_yn" id="success-outlined" autocomplete="off" value="1" <c:if test="${lineup.lineup_yn eq '1' }"> checked </c:if> />
							<label class="btn btn-outline-success_" for="success-outlined">줄서기</label>
							
							<input type="radio" class="btn-check" name="lineup_yn" id="danger-outlined" autocomplete="off" value="2" <c:if test="${lineup.lineup_yn eq '2' }"> checked </c:if>>
							<label class="btn btn-outline-danger" for="danger-outlined">예약</label>
					    </div>
					    <div id="yesCaption">
					    	<label class="sy-only">날짜</label><br>
							<select class="form-control" name="date" id="date">
								<option value="" disabled selected hidden>선택하세요</option>
								<c:forEach items="${dateSet}" var="date">
									<option value="${date}" <c:if test="${lineup.date eq date}"> selected </c:if>>${date }</option>
								</c:forEach>
							</select>
							<label class="sy-only">시간</label><br>
							<select class="form-control" name="time" id="time">
								<option value="" disabled selected hidden>선택하세요</option>
								<c:forEach items="${timeSet}" var="time">
									<c:if test="${time ne '-'}">
										<option value="${time}" <c:if test="${lineup.time eq time}"> selected </c:if>>${time}</option>
									</c:if>
								</c:forEach>
							</select>		
					    </div>
					    <%-- <label class="sy-only">*연락처</label><br>
					    <input type="text" name="lineup_tel" id="storeTel" class="form-control" placeholder="'-' 없이 숫자만 입력" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${store.store_Tel }"><br> --%>
						<label class="sy-only">*인원</label><br>
					    <input type="text" name="lineup_count" id="lineupCount" class="form-control" placeholder="최대 10명" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${store.store_Tel }"><br>
						
						<div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" id="enroll-btn">확&nbsp;인</button>
			              <c:if test="${lineup ne null}">
			              	<button type="button" class="btn-btn btn form-control" id="delete-btn">취&nbsp;소</button>
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
<style>
	#yesCaption{height: 0; overflow: hidden;}
</style>
<script type="text/javascript">
$(function(){
	var saveOrDelete = 0;
	
    var isCap = $('input[name="lineup_yn"]:checked').val();
	
	if (isCap == 2) {
		$('#yesCaption').animate({
			height: '+=150'
		}, 500);
	}
	
	$(document).on('change', "input[name='lineup_yn']" ,function() {
		isCap = $(this).val();
		
		if (isCap == 2) {
			$('#yesCaption').animate({
				height: '+=150'
			}, 500);
		}else{
			$('#date option:eq(0)').prop("selected", true);
			$('#time option:eq(0)').prop("selected", true);
			$('#yesCaption').animate({
				height: '-=150'
			}, 200);
		}
	});
	
	$('#lineupCount').keyup(function(){
		var cnt = $(this).val();
		if (cnt > 10) {
			alert("최대 인원은 10명입니다.");
			$(this).val("");
			$(this).focus();
		}
	})
	
	$('#enroll-btn').click(function(){
		submitWhere(saveOrDelete);
	});
	
	$('#delete-btn').click(function(){
		var res = confirm("예약을 취소하시겠습니까?");
		if (res) {
			saveOrDelete = 1;
			submitWhere(saveOrDelete);
		}else{
			
		}
	});
	
	
	function submitWhere(saveOrDelete){
		
		if (saveOrDelete == 0) {
			
		    /* if($('#storeNm').val() == null || $('#storeNm').val() == ''){
				alert('이름을 입력하세요');
				$(this).focus();
				return;
			} */
			
		    if($('input[name="lineup_yn"]').val() == null || $('input[name="lineup_yn"]').val() == ''){
				alert('구분을 입력하세요');
				$(this).focus();
				return;
			}
		    
		    if (isCap == 2) {
		    	if($('#date').val() == null || $('#date').val() == ''){
					alert('예약날짜를 선택하세요');
					$(this).focus();
					return;
				}
		    	if($('#time').val() == null || $('#time').val() == ''){
					alert('예약시간을 선택하세요');
					$(this).focus();
					return;
				}
			}
		    
		   	/* if($('#storeTel').val() == null || $('#storeTel').val() == ''){
				alert('연락처를 입력하세요');
				$(this).focus();
				return;
			} */
		   	if($('#lineupCount').val() == null || $('#lineupCount').val() == ''){
				alert('인원수를 입력하세요');
				$(this).focus();
				return;
			}
		   	
		   	
		   	$('#f').attr('action','enroll');
		}else{
			$('#f').attr('action','delete');
		}
		
		
	   	
	   $('#f').submit();
	}
	
	
});





</script>
</html>
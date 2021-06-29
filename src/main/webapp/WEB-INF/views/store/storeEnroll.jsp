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
		<form action="" id="frm" name="frm" enctype="multipart/form-data">
			<br><br><br> 
			<div class="in" style="display: inline-block; margin-left:30%;">
			    <div class="card align-middle" style="width: 40rem; border-radius: 20px;">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Store</h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
				        
				        <label for="storeNm" class="sr-only">*대표사진</label><br>
				        <input type="file" name="storeNm" id="storeNm" class="form-control"><br>
				        
					    <label for="storeNm" class="sr-only">*상호명</label><br>
					    <input type="text" name="storeNm" id="storeNm" class="form-control"><br>
					    
					    <label for="storeIdt" class="sr-only">*구분</label><br>
					    <div id="chk-wrap">
					    	<input type="radio" name="storeIdt" class="storeIdt" value="1" class="inputName"/>&nbsp;한식&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="2" class="inputName"/>&nbsp;분식&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="3" class="inputName"/>&nbsp;중식&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="4" class="inputName"/>&nbsp;패스트푸드&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="5" class="inputName"/>&nbsp;양식&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="6" class="inputName"/>&nbsp;카페/디저트&nbsp;&nbsp;
						    <input type="radio" name="storeIdt" class="storeIdt" value="7" class="inputName"/>&nbsp;일식
					    </div>
					    
					    <label for="storeTel" class="sr-only">*대표번호</label><br>
					    <input type="text" name="storeTel" id="storeTel" class="form-control"><br>
					    
					    <label for="inputAddress" class="sr-only">*주소</label><br>
         				<button type="button" class="btn-btn btn" id="findPostcode" onclick="findPostcode();" class="form-control">우편번호 찾기</button>
					    <input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control" readonly>
					    <br>            
			            <input type="hidden" name="storeAddress" id="addressState">
			            <input type="text" name="address" id="address" placeholder="주소" class="form-control" readonly>
			            <div id="address"></div>
			            <input type="hidden" name="storeAddressDt" id="address2State">
			            <input type="text" name="address2" id="address2" placeholder="상세주소" class="form-control" required autofocus>
			            <div id="address2"></div>
			            <div id="enroll-btn-wrap" style="text-align:center;">
			              <button type="button" class="btn-btn btn form-control" onclick="joinCheck()">등&nbsp;록</button> 
			            </div>       
			        </div>
			    </div>
			</div>
			<br><br><br><br>
		</form>		
	</main>
	
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
	
<style>

</style>	
<script type="text/javascript">
	$(function(){
		
	});
</script>
</body>

</html>
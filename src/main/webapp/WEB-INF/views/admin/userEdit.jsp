<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
#mypageT th{
 font-family: 'Ubuntu', sans-serif;
}
</style>

<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <jsp:include page="../commons/head.jsp" />
<body>
<header>
		<jsp:include page="../commons/header.jsp" />
</header>
<main>

<br>
<br>
<!-- 내정보 -->
<div class="container">
    <div class="m-5 p-3 text-center"
         style="border: 1px solid gray;border-radius:15px;background-color:white;" id="font2">
        <form name="meF" id="meF" action="edit" method="POST">
        <h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">MyPage</h1>
        <br>
        <div class="selectB">
        <select name="user_dt" style="align:right;">
        <option value="0" <c:if test="${user.user_dt eq 0}">selected</c:if>>미인증</option>
        <option value="1" <c:if test="${user.user_dt eq 1}">selected</c:if>>일반회원</option>
        <option value="2" <c:if test="${user.user_dt eq 2}">selected</c:if>>스토어회원</option>
        <option value="4" <c:if test="${user.user_dt eq 4}">selected</c:if>>탈퇴회원</option>
        <option value="9" <c:if test="${user.user_dt eq 9}">selected</c:if>>관리자</option>
        </select>
        </div>

        <!-- 내정보 -->

            <input type="hidden" id="origin_num" name="origin_num" value="${user.origin_num }">
            <table class="table table-hover" id="mypageT">
                <tr>
                    <th>이름</th>
                    <td><input type="text" value="${user.name}" name="name"
                               id="name" class="form-control" maxlength="11" required></td>
                    <th>아이디</th>
                    <td>${user.id }</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${user.email }
                     <input type="hidden" id="email" name="email" value="${user.email }"></td>
                    <th>연락처</th>
                    <td>
                    <input type="text" value="${user.tel }" name="tel" id="tel" class="form-control" maxlength="11" required></td>
                </tr>
                <tr> 
                   <th>우편번호</th>
                   <td><input type="text" value="${user.postcode}" name="postcode"
                               id="postcode" class="form-control" required></td>
                   <th>
                   <button type="button" class="btn form-contrlo" onclick="findPostcode()" style="vertical-align:20px;background-color:#FFAB2F;margin-bottom: 0.5rem;">우편번호 찾기</button>
                   </th>
                </tr>
                <tr>
                   <th>주소</th>
                   <td><input type="text" value="${user.address}" name="address"
                               id="address" class="form-control" required></td>
                   <th>상세주소</th>
                   <td><input type="text" value="${user.address_dt}" name="address_dt"
                               id="address_dt" class="form-control" required></td>
                </tr>
                <tr>
                   <th>동의</th>
                   <td><input type="checkbox" name="agree2" id="agree2" value="1" style="margin: auto;color:#1F2229;" checked>&nbsp;마케팅수신동의(선택)
                   <input type="hidden" name="agree2" id="agree2_hidden" value="0" style="margin: auto;color:#1F2229;"></td>
                </tr>
            </table>
            <div class="container text-right">
                <input type="hidden" id="res" name="res">
                <button class="btn" id="rewrite" name="rewrite">수정하기</button>
            </div>
        </form>
        <!-- 버튼정렬div -->
    </div>
    <!-- 내정보 div -->
</div>

</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
</body>
<style>
  .selectB select {
    width: 150px;
    height: 30px;
    padding-left: 5px;
    font-size: 15px;
    border: 1px solid gray;
    border-radius: 3px;
    float:right;
    margin-right:20px;
    margin-bottom: 0.5rem;
  }
</style>
<script type="text/javascript">

    $(function () {
        $('#rewrite').on('click', function (e) {
            e.preventDefault();
            	     
            if(!meF.name.value){
            	alert('이름을 입력하세요');
            	meF.name.focus();
            	return;
            }
            
            if(!meF.tel.value){
            	alert('연락처를 입력하세요');
            	meF.tel.focus();
            	return;
            }
            
            if(!meF.postcode.value){
            	alert('우편번호를 입력하세요');
            	meF.postcode.focus();
            	return;
            }
            
            if(!meF.address.value){
            	alert('주소를 입력하세요');
            	meF.address.focus();
            	return;
            }
            
            if(!meF.address_dt.value){
            	alert('상세주소를 입력하세요');
            	meF.address_dt.focus();
            	return;
            }
            
    		if(document.getElementById("agree2").checked){
    			document.getElementById("agree2_hidden").disabled = true ;
    		}		
    		
            meF.submit();

        })
    })
    
 function findPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("address").value = addr + extraAddr;
            
            } else {
            	document.getElementById("address").value = addr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
     
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();
        }
    }).open();
}

</script>

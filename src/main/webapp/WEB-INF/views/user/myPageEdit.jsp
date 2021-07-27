<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
         style="border: 1px solid gray; border-radius: 15px" id="font2">
        <h1 class="text-bold" id="font1">MyPage</h1>
        <br>

        <!-- 내정보 -->
        <form name="meF" id="meF" action="edit" method="POST">

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
                    <th colspan="2">비밀번호 변경</th>
                    <td colspan="2">

                        <button type="button" class="btn btn-primary" id="checkmypwd"
                                onclick="checkPwd(${user.origin_num})">비밀번호 변경하기</button> 
                                <input type="hidden" name="pwdState" id="pwdState">
                        <div id="msgPwd"></div>
                    </td>
                </tr>
                <tr>
                    <th colspan="2">비밀번호 입력</th>
                    <td colspan="2"><input type="password" name="password" id="password"
                                           class="form-control" readonly></td>
                </tr>
                <tr>
                    <th colspan="2">비밀번호 확인</th>
                    <td colspan="2"><input type="password" name="password2"
                                           id="password2" class="form-control" readonly></td>
                </tr>

            </table>
            <div class="container text-right">
                <input type="hidden" id="res" name="res">
                <button class="btn" id="rewrite" name="rewrite">수정하기</button>
                <button type="reset" class="btn" id="resetbtn">다시쓰기</button>
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
<script type="text/javascript">

    //비밀번호 변경 체크
    function checkPwd(origin_num){
        let str = '<input type="password" id="repwd" name="repwd" class="form-control" onchange="checkp(${user.origin_num},this.value)" placeholder="현재 비밀번호를 입력해주세요">';
        $('#msgPwd').html(str);
        document.meF.password.readOnly = true;
        document.meF.password2.readOnly = true;
        $('#password').val("");
        $('#password2').val("");
        
    }
    
    let cls='';
    function checkp(origin_num, repwd){
        $.ajax({
            type:'get',
            url:'pwdcheck?origin_num='+origin_num+"&password="+repwd,
            dataType:'json',
            cache:false,
        }).done(function(res){
            let n = parseInt(res.check);
            
            if(n>0){
            	cls='';
                cls='text-primary';
                $('#pwdstate').val(1);
                document.meF.password.readOnly = false;
                document.meF.password2.readOnly = false;
            }else{
            	cls='';
                cls='text-danger'
                $('#pwdstate').val("");
            }
            $('#msgPwd').removeClass();
            $('#msgPwd').text(res.okPwd).addClass(cls);


        }).fail(function(err){
            alert('error: '+err.status);

        })
    }

   
    $(function () {
        $('#rewrite').on('click', function (e) {
            e.preventDefault();
            
            if(cls == 'text-primary'){
            	if(!meF.password.value == null){
            		 alert('수정할 비밀번호를 입력해주세요');
                     meF.password.focus();
                     return;
            	}
            	if (meF.password.value != meF.password2.value) {
                    alert('비밀번호가 일치하지 않습니다.');
                    meF.password2.focus();
                    return;
                }
            	if (!meF.password2.value) {
                    alert('비밀번호를 확인 해주세요');
                    meF.password2.focus();
                    return;
                }
            
            }
            	     
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <jsp:include page="../commons/head.jsp" />
</head>
    <header>
		<jsp:include page="../commons/header.jsp" />
	</header>  
<body>
<main>
<br><br><br> 
<div class="in" style="display: inline-block; margin-left: 30%;">
    <div class="card align-middle" style="width: 40rem; border-radius: 20px;">
        <div class="card-title" style="margin-top: 30px;">
            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">SIGN UP</h2>
        </div>
        <div class="card-body">
        <form:form modelAttribute="user" name="f" action="join" method="POST" >
	        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">양식에 맞춰 입력해 주세요</h6>
	             <label for="inputName" class="sr-only">*이름</label>
	               <input type="hidden" name="namestate" id="namestate">
	               <input type="text" name="name" id="name" placeholder="이름" class="form-control" required autofocus>
	            <div id="id"></div>
	            
	         <input type="checkbox" name="user_dt" id="user_dt" value="1" style="margin: auto;color:#1F2229;" onclick="doCheck(this)" checked>&nbsp;개인
	             <input type="checkbox" name="user_dt" id="user_dt" value="2" style="margin: auto;color:#1F2229;" onclick="doCheck(this)">&nbsp;사업자<br>
	            
	         <br><label for="inputId" class="sr-only">*아이디</label>
	               <input type="hidden" name="idstate" id="idstate">
	               <input type="text" name="id" id="id"  placeholder="아이디" class="form-control" required autofocus onchange="checkId(this.value)">
	               <div id="msgId"></div>
	              <!-- 아이디 사용 가능 여부 -->
		         <span class="text-danger">
		            <form:errors path="id"/>
		         </span>
		         
		     <a style="font-size:13px;">* 비밀번호는 대소문자, 숫자, 특수문자를 세 가지 이상 조합하여 8자 이상 15자 이내로 가능합니다.</a>
		     <label for="inputPwd" class="sr-only">*비밀번호</label> 
		     <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호" required autofocus>
		     <br>
	         <label for="inputCheckPwd" class="sr-only">*비밀번호확인</label>
	               <input type="password" name="password2" id="password2" class="form-control" placeholder="비밀번호 확인" required autofocus>
		      
		     <br><label for="inputTel" class="sr-only">*연락처</label>
	               <input type="hidden" name="telstate" id="telstate">
	               <input type="text" name="tel" id="tel" maxlength="11" class="form-control" placeholder="전화번호" onchange="checkTel(this.value)">
	               <div id="msgTel"></div>
	              <!-- 전화번호 사용 가능 여부 -->
	              <span class="text-danger">
	                <form:errors path="tel"/>
	              </span>
	         <br><label for="inputEmil" class="sr-only">*이메일</label>
	                <input type="hidden" name="emailstate" id="emailstate">
	                <input type="text" name="email" id="email" placeholder="이메일" class="form-control" onchange="checkEmail(this.value)">
	                <div id="msgEmail"></div>
	                <!-- 이메일 사용 가능 여부 -->
	                <span class="text-danger">
	                <form:errors path="email"/>
	                </span>
	          <br>
	          <button type="button" class="btn form-contrlo" onclick="findPostcode()" style="vertical-align:20px;background-color:#FFAB2F;margin-bottom: 0.5rem;">우편번호 찾기</button>
	          <input type="text" name="postcode" id="postcode" placeholder="우편번호" class="form-control" readonly>
	          <label for="inputAddress" class="sr-only">*주소</label>
	               <input type="hidden" name="addressstate" id="addressstate">
	               <input type="text" name="address" id="address" placeholder="주소" class="form-control" readonly>
	            <div id="address"></div>
	          <label for="inputAddress2" class="sr-only">*상세주소</label>
	               <input type="hidden" name="address2state" id="address2state">
	               <input type="text" name="address_dt" id="address_dt" placeholder="상세주소" class="form-control" required autofocus>
	            <div id="address2"></div>
	          <br><input type="checkbox" name="agree1" id="agree1" value="1" style="margin: auto;"><a href="#agree1" style="color:#E30F0C;">&nbsp;이용약관(필수)</a>
	          <br><input type="checkbox" name="agree2" id="agree2" value="1" style="margin: auto;color:#1F2229;">&nbsp;마케팅수신동의(선택)
	          <input type="hidden" name="agree2" id="agree2_hidden" value="0" style="margin: auto;color:#1F2229;">
	          <br>
	            <div style="text-align:center;">
	              <button type="button" class="btn-btn btn" onclick="joinCheck()" style="background-color:#E30F0C;color:#F9EBE0;">회원가입</button> 
	            </div>
	      </form:form>
        </div>
    </div>
</div>
<br>
<br>
<br>
<br>
<br>

<c:import url="/user/terms"/>
<br>
<br>
</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
<script>
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

var idck = /^[A-za-z0-9]{4,12}$/g;
var emailck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var telck = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

function checkId(uid){
    let len = uid.length;
    $('#msgId').text('')
        .removeClass('text-danger')
        .removeClass('text-primary');
    if(!idck.test( $("input[name=id]").val()))
    {
        $('#msgId').text('아이디는 4~12자 이내의 영문자 또는 숫자여야 합니다. 특수문자는 _,-만 사용하실 수 있습니다.')
            .addClass('text-danger');
        $('#id').select();

        return;
    }

    $.ajax({
        type:'GET',
        url:'idcheck?id='+uid,
        dataType:'json', 
        cache:false,
    }).done(function(res){
        let n =parseInt(res.isUse);
        let cls=''
        if(n>0){
            cls='text-primary';
            $('#idstate').val(1);
        }else{
            cls='text-danger'
            $('#idstate').val("");
        }
        $('#msgId').text(res.idResult).addClass(cls)
    }).fail(function(err){
        alert('error: '+err.status);
    })

}//checkId()------------------

function checkEmail(uem){
    let len = uem.length;
    $('#msgEmail').text('')
        .removeClass('text-danger')
        .removeClass('text-primary');
    if( !emailck.test( $("input[name=email]").val()))
    {
        $('#msgEmail').text('유효하지 않은 이메일 입니다.')
            .addClass('text-danger');
        $('#email').select();

        return;
    }
    
    $.ajax({
        type:'GET',
        url:'emailcheck?email='+uem,
        dataType:'json',
        cache:false,
    }).done(function(res){
        let n =parseInt(res.isEma);
        let cls=''
        if(n>0){
            cls='text-primary';
            $('#emailstate').val(1);
        }else{
            cls='text-danger'
            $('#emailstate').val("");
        }
        $('#msgEmail').text(res.emailResult).addClass(cls)
    }).fail(function(err){
        alert('error: '+err.status);
    })

}//checkEmail()------------------


function checkTel(ute){
    let len = ute.length;
    $('#msgTel').text('')
        .removeClass('text-danger')
        .removeClass('text-primary');
    if( !telck.test( $("input[name=tel]").val()))
    {
        $('#msgTel').text('휴대폰 번호 11자리를 입력해주세요.')
            .addClass('text-danger');
        $('#tel').select();

        return;
    }
    
    $.ajax({
        type:'GET',
        url:'telcheck?tel='+ute,
        dataType:'json',
        cache:false,
    }).done(function(res){
        let n =parseInt(res.isTel);
        let cls=''
        if(n>0){
            cls='text-primary';
            $('#telstate').val(1);
        }else{
            cls='text-danger'
            $('#telstate').val("");
        }
        $('#msgTel').removeClass();
        $('#msgTel').text(res.telResult).addClass(cls)
    }).fail(function(err){
        alert('error: '+err.status);
    })

}//checkTel()------------------

function doCheck(chk){
    var obj = document.getElementsByName("user_dt");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}


function joinCheck(){
	
	    var passwordck =  /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;	

	    if(!f.name.value){
			alert('이름을 입력하세요');
			f.pwd.focus();
			return;
	   }
	   	    
	   if(!f.password.value){
			alert('비밀번호를 입력하세요');
			f.pwd.focus();
			return;
		}
	   
	   if(!passwordck.test($("input[id='password']").val())) {
		   alert('비밀번호를 형식에 맞게 입력해주세요.');
		    return false;
		}

		if(f.password.value != f.password2.value){
			alert('비밀번호가 서로 다릅니다.');
			f.pwd2.select();
			return;
           }
		
		if(!f.address_dt.value){
			alert('상세주소를 입력하세요');
			f.pwd.focus();
			return;
			}
 
		if($("input:checkbox[name='agree1']").is(":checked") == false) {
			alert("약관에 동의하지 않으면 가입하실 수 없습니다.");
			return;
			}
		if(document.getElementById("agree2").checked){
			document.getElementById("agree2_hidden").disabled = true ;
		}		
		
	    f.submit();
}
</script>

</body>
</html>
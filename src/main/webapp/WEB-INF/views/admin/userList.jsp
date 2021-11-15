<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
    <jsp:include page="../commons/head.jsp" />
</head>
<body>
	<header>
		<jsp:include page="../commons/header.jsp" />
	</header>
<main> 
<br>
<br>

<div class="container" style="margin-top: 20px">
<div class="m-5 p-3 text-center"
         style="border: 1px solid gray;border-radius:15px;background-color:white;" id="font2">
        <h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">User List</h1>
        <br>
		    <div class="row">
		      <div class="col-md-9">
					<!-- 유저 검색 창 -->
					<form name="findF" action="" class="form-inline">
					<select name="findType" id="findType" class="form-control m-3" >
					<option value="">검색 유형</option>
					<option value="1">회원이름</option>
					<option value="2">아이디</option>
					<option value="3">연락처</option>
					<option value="4">연락처</option>
					</select>
					<input type="text" name="findKeyword" id="findKeyword"
						placeholder="검색어를 입력하세요" class="form-control m-3" required>
						<button class="btn">검 색</button>
					</form>
			 </div>
	
				<table class="table table-hover" id="bbs">
						<tr style="font-weight:bold;">
							<th>회원번호</th>
							<th>이름</th>
							<th>아이디</th>
							<th>회원상태</th>
							<th>가입일</th>
							<th>관리</th>
						</tr>

						<!-- 데이터  -->
						<c:if test="${userList eq null or empty userList}">

							<tr>
								<td colspan="5">서버 오류이거나 데이터가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${userList ne null and not empty userList}">
							<c:forEach var="user" items="${userList}">
								<tr class="record">
									<td><c:out value="${user.origin_num}" /></td>
									<td><c:out value="${user.name}" /></td>
									<td><c:out value="${user.id}" /></td>
<%-- 									<td><fmt:formatDate value=""
											pattern="yyyy-MM-dd" /></td> --%>
									<td><c:if test="${user.user_dt==0}">
                                        미인증</c:if>
                                    <c:if test="${user.user_dt==1}">
                                        일반회원</c:if> 
                                    <c:if test="${user.user_dt==2}">
                                        스토어회원</c:if> 
                                    <c:if test="${user.user_dt==4}">
                                        <font color="#FF0000">탈퇴회원</font></c:if> 
                                    <c:if test="${user.user_dt==9}">
                                    <div style="font-size:20px;">
                                         <span class="badge badge-primary">관리자</span>
                                    </div>
                                    </c:if>
                                    </td> 
                                    <td><c:out value="${user.jdate}" /></td>  
									<td>
									<a href="#" onclick="userEdit('${user.origin_num}')"><font color="#4169E1"><b>수정</b></font></a>
                                    <c:if test="${user.user_dt ne '4'}">
									&nbsp;|&nbsp;<a href="javascript:userDel('${user.origin_num}')"><font color="#FF0000"><b>탈퇴</b></font></a>
                                    </c:if>                    
									</td>
									<td>
									</td>
								   </tr>
							</c:forEach>
						</c:if>

				</table>
							<div style="text-align: right; padding-right: 15px">
								<b>총 회원 ${totalCount} 명</b>
							</div>
					<div class="container" style="padding-top: 10px;" id="paging">
						${pageNavi}
				    </div>
			</div>
		</div>
	</div>

<!-- 회원 탈퇴 -->
<form name="frm" method="POST">
	<input type="hidden" name="origin_num">
</form>
<!-- 회원 수정 -->
<form name="frm2" method="GET">
</form>


</main>
	 <%-- <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
</body>
<style>
#bbs th{
 font-family: 'Ubuntu', sans-serif;
 font-size: 0.9rem;
 font-weight: bolder;
}

.page-item.active .page-link {
 color:white;
 background:#E30F0C;
 border-color:#E30F0C;
}
</style>
<script type="text/javascript">
	$(function() {
		
		$('#bottom-nav4').css('display','block');
		$('#fixed-box-top').css('bottom','5.5%');
		$('.bottom-nav-li4').removeClass('on');
		$('.bottom-nav-li4').eq(0).addClass('on');
		
		$('#findF').on('submit', function() {
			var $type = $('#findType');
			var $keyword = $('#findKeyword');
			if ($type.val() == 0) {
				alert('검색 유형을 선택하세요');
				$type.focus();
				return false;
			}
			if (!$keyword.val()) {
				alert('검색어를 입력하세요');
				$keyword.focus();
				return false;
			}
			return true;
		})
	})
	
	function userEdit(num){ 
		frm2.action="userEdit/"+num;
		frm2.submit();
	}
	
	function userDel(num){
		var yn = window.confirm(num+"번 회원정보를 삭제할까요?");
		if(yn){
			frm.origin_num.value = num;
			frm.action ='userDelete';
			frm.method = 'post';
			frm.submit();
		}
	}
	
</script>
</html>

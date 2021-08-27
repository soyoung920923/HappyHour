<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
    <jsp:include page="../commons/head.jsp" />
<body>
</head>
    <header>
		<jsp:include page="../commons/header.jsp" />
	</header>  
<c:url var="saveCommentURL" value="/admin/insertComment">
</c:url>
<c:url var="deleteCommentURL" value="/admin/deleteComment">
</c:url>
<main>
<br>
<br>
	<div class="container" style="margin-top: 30px">
	<div class="m-5 p-3 text-center"
         style="border: 1px solid gray;border-radius:15px;background-color:white;" id="font2">
    <div class="row">
			<c:if test="${board eq null }">
				<h2 class="text-danger m-5">${board.num}번 게시글이 없습니다.</h2>
			</c:if>
	  <c:if test="${board ne null}">	
				<h5 class="card-title text-left" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;"> ${board.num}</h5>
			<h3 style="text-align:center;"><b><c:out value="${board.title}"/></b></h3><br>
			<div style="text-align:right;">작성자&ensp;<c:out value="${board.name}"/>(${board.id})</div>
			<div style="text-align:right;margin-bottom: 0.5rem;">작성일&ensp;<fmt:formatDate value="${board.register_day}" pattern="yyyy-MM-dd hh:mm"/></div>
			<table class="table" id="bbs">	
				<tr>
			        <td width="30" style="text-align:left;"><b>&ensp;&ensp;&ensp;첨부파일</b></td>
					<td width="170" style="text-align:left;">
						<c:if test="${board.filename ne null}">
						<a href="#" onclick="down()">
						<c:out value="${board.origin_filename}"/>
						</a>
						<!-- 물리적 파일명을 모두 소문자로 변환 (확장자 체크를 위해) -->
						<c:set var="fname" value="${fn:toLowerCase(board.filename)}"/>
					   </c:if>
					    <c:if test="${board.filename2 ne null}">&ensp;/&ensp;
						<a href="#" onclick="down2()">
						<c:out value="${board.origin_filename2}"/>
						</a>
						<c:set var="fname" value="${fn:toLowerCase(board.filename2)}"/>
					   </c:if>
				   </td>
				<tr>
				   <td colspan="2">
				   <c:out value="${board.content}"/>
				   </td>
				</tr>
				<tr>
			</tr>
		</table>
	   </c:if>
  </div>	
		     <div style="text-align:right;">
					<form id="boardF" method="post" >
					<input type="hidden" name="num" id="num" value="<c:out value="${board.num}"/>">
							<button class="btn" onclick="goDel()" style="margin-bottom: 0.3rem;">삭제</button> 
					</form>     
			        <button class="btn" onclick="history.back()">목록</button>
			 </div>
	 </div>
</div>

	<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px; margin-left: 300px; margin-right: 300px;border: 1px solid gray;border-radius:15px;">
		<form:form name="f" id="f"  modelAttribute="commentDTO" method="POST">
		<input type="hidden" id="num" value="${board.num}"/>
			<div class="row">
				<div class="col-sm-10">
					<textarea id="ccontent" class="form-control" rows="3" placeholder="댓글을 입력해 주세요" maxlength="500" required></textarea>
				</div>
				<div class="col-sm-2">
					<input type="hidden" class="form-control" id="id" value="${loginUser.id}"/>
					<input type="hidden" class="form-control" id="name" value="${loginUser.name}"/>
					<button type="button" class="btn btn-sm" id="btnSave" style="width: 30%; margin-top: 10px"> 저장 </button>
				</div>
			</div>
		</form:form>
	</div>
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px; margin-left: 300px; margin-right: 300px;border: 1px solid gray;border-radius:15px;">
				<h6 class="border-bottom pb-2 mb-0">Comment List</h6>
				<div id="commentList"></div>
			</div> 		

   </main>
</body>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>

<form name="reF" action="reply" method="POST">
   <input type="hidden" name="num" value="${board.num}">
   <input type="hidden" name="title" value="${board.title}">

</form>

<form name="fileF" id="fileF" action="fileDown" method="post">
   <input type="hidden" name="fname" value="${board.filename}"> 
   <input type="hidden" name="origin_fname" value="${board.origin_filename}">
</form>

<form name="fileT" id="fileT" action="fileDown2" method="post">
   <input type="hidden" name="fname2" value="${board.filename2}"> 
   <input type="hidden" name="origin_fname2" value="${board.origin_filename2}">
</form>

<script type="text/javascript">

$(document).ready(function(){
	showCommentList();
});

	function down() {
	    $('#fileF').submit();
	 }
	function down2() {
	    $('#fileT').submit();
	 }
	
	function goDel() {
		
		if(loginUser !== null){
			
	    var yn = confirm('${board.num}번 글을 정말 삭제할까요?');
	    if (yn) {
	
	       $('#boardF').prop('method', 'post');
	       $('#boardF').prop('action', 'delete');
	    }
	    
		}else{
			alert("로그인 후 이용해 주세요.")
		}
	    
	}
	 
	function goRe(){
	       reF.submit();    
	}
	
  $(document).on('click', '#btnSave', function(){

		var CommentContent = $('#ccontent').val();
	
		var paramData = JSON.stringify({
			    "ccontent": CommentContent
				, "id": '${loginUser.id}'
				, "name" : '${loginUser.name}'
				, "num":'${board.num}'

		});
		
		var headers = {"Content-Type" : "application/json"
				, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			url: "${saveCommentURL}"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showCommentList();
				$('#ccontent').val('');
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	});
	
	function showCommentList(){

		var url = "${pageContext.request.contextPath}/selectCommentAll";
		var paramData = {"num" : "${board.num}"};
		var loginUserId = '${loginUser.id}';
		$.ajax({
            type: 'POST',
            url: url,
            data: paramData,
            dataType: 'json',
            success: function(result) {
               	var htmls = "";
			if(result.length < 1){
				htmls += '<br><div>등록된 댓글이 없습니다.</div>';
			} else {
	                    $(result).each(function(){
	                     htmls += '<div class="media text-muted pt-3" id="cnum' + this.cnum + '">';
	                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
	                     htmls += '<title>Placeholder</title>';
	                     htmls += '<rect width="100%" height="100%" fill="#fff48c"></rect>';
	                     htmls += '<text x="50%" fill="#fff48c" dy=".3em">32x32</text>';
	                     htmls += '</svg>';
	                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	                     htmls += '<span class="d-block">';
	                     htmls += '<strong class="text-gray-dark">' + this.id + '</strong>';
	                     htmls += '<strong class="text-gray-dark">' + '(' + this.name + ')' + '</strong>';
	                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	                     htmls += '<a href="javascript:void(0)" onclick="deleteComment(' + this.cnum + ')" >삭제</a>';
	                     htmls += '</span>';
	                     htmls += '</span>';
	                     htmls += this.ccontent;
	                     htmls += '</p>';
	                     htmls += '</div>';
	                });	
			 }
			 $("#commentList").html(htmls);
           }	 
		});	

	}
	
	function deleteComment(cnum){
		
		alert("댓글이 삭제되었습니다.");
 
		var paramData = {"cnum": cnum};

		$.ajax({
			url: "${deleteCommentURL}"
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
		
		location.reload();
	}

	
</script>



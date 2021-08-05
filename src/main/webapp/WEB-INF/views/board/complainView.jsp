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
<c:url var="saveCommentURL" value="/insertComment">
</c:url>
<c:url var="updateCommentURL" value="/updateComment">
</c:url>
<c:url var="deleteCommentURL" value="/deleteComment">
</c:url>
<main>
	<div class="container">
	  <div class="row">
			<c:if test="${board eq null }">
				<h2 class="text-danger m-5">${board.num}번 게시글이 없습니다.</h2>
			</c:if>
	  <c:if test="${board ne null}">
				<br>
				<br>
				 ${board.num}
			<table class="table table-bordered">
				<tr>
				  <td><b>제목</b></td>
				  <td colspan="5">
				  <c:out value="${board.title}"/>
				  </td>
				</tr>
				<tr>
				  <td><b>작성일</b></td>
			      <td>
				  <fmt:formatDate value="${board.register_day}" pattern="yyyy-MM-dd hh:mm"/>
				  </td>
				  <td><b>조회수</b></td>
				  <td>
				  <c:out value="${board.hits}"/>
				  </td>
				  <td><b>작성자</b></td>
				  <td>
				  <c:out value="${board.name}"/>
				  </td>
				</tr>
				<tr>
			        <td colspan="1"><b>첨부파일</b></td>
					<td class="text-left" colspan="5">
						<c:if test="${board.filename ne null}">
						<a href="#" onclick="down()">
						<c:out value="${board.origin_filename}"/>
						</a>
						<!-- 물리적 파일명을 모두 소문자로 변환 (확장자 체크를 위해) -->
						<c:set var="fname" value="${fn:toLowerCase(board.filename)}"/>
						<c:if test="${fn:endsWith(fname,'.png') 
						or fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif')}">
							<img src="${pageContext.request.contextPath}/Upload/${board.filename}" class="img-thumbnail"
			             width="100px">
						</c:if>
					   </c:if>
					   <br>
					    <c:if test="${board.filename2 ne null}">
						<a href="#" onclick="down2()">
						<c:out value="${board.origin_filename2}"/>
						</a>
						<c:set var="fname" value="${fn:toLowerCase(board.filename2)}"/>
						<c:if test="${fn:endsWith(fname,'.png') 
						or fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.gif')}">
							<img src="${pageContext.request.contextPath}/Upload/${board.filename2}" class="img-thumbnail"
			             width="100px">
						</c:if>
					   </c:if>
				   </td>
				<tr>
				   <td colspan="3">
				   <c:out value="${board.content}"/>
				   </td>
				</tr>
				<tr>
			</tr>
		</table>
		     <div class='text-right'>
		     <p>
		       <c:if test="${loginUser.id eq board.id}">
					<form id="boardF" method="post" >
					<input type="hidden" name="num" id="num" value="<c:out value="${board.num}"/>">
					     	<button class="btn" onclick="goEdit()">수정</button>
							<button class="btn" onclick="goDel()">삭제</button> 
					</form>
					        <button class="btn" onclick="history.back()">목록</button>
					        <a href="javascript:goRe()"><button class="btn">답글쓰기</button></a>       
				</c:if>	
			 </p>
			    </div>
			    <div class='text-right'>
			    <c:if test="${loginUser.id ne board.id }">
			        <button class="btn" onclick="history.back()">목록</button>
					<a href="javascript:goRe()"><button class="btn">답글쓰기</button></a>  
				</c:if>
			    </div>
	    </c:if>
	 </div>
  </div>	

	<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px; margin-left: 100px; margin-right: 100px;">
		<form:form name="f" id="f"  modelAttribute="commentDTO" method="POST">
		<input type="hidden" id="num" value="${board.num}"/>
			<div class="row">
			<c:if test="${loginUser ne null}">
				<div class="col-sm-10">
					<textarea id="ccontent" class="form-control" rows="3" placeholder="댓글을 입력해 주세요" maxlength="500" required></textarea>
				</div>
		   </c:if>
		   <c:if test="${loginUser eq null}">
			    <div class="col-sm-10">
			      <textarea id="ccontent" class="form-control" rows="3" placeholder="로그인 후 댓글 작성이 가능합니다." readonly></textarea>
				</div>
		   </c:if>
				<div class="col-sm-2">
					<input type="hidden" class="form-control" id="id" value="${loginUser.id}"/>
					<input type="hidden" class="form-control" id="name" value="${loginUser.name}"/>
					<button type="button" class="btn btn-sm" id="btnSave" style="width: 30%; margin-top: 10px"> 저장 </button>
				</div>
			</div>
		</form:form>
	</div>
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px; margin-left: 100px; margin-right: 100px;">
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
	    var yn = confirm('${board.num}번 글을 정말 삭제할까요?');
	    if (yn) {
	
	       $('#boardF').prop('method', 'post');
	       $('#boardF').prop('action', 'delete');
	    }
	    
	}
	
	function goEdit() {
	        $('#boardF').prop('method', 'post');
	        $('#boardF').prop('action', 'edit');
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
	                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
	                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
	                     htmls += '</svg>';
	                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	                     htmls += '<span class="d-block">';
	                     htmls += '<strong class="text-gray-dark">' + this.id + '</strong>';
	                     htmls += '<strong class="text-gray-dark">' + '(' + this.name + ')' + '</strong>';
	                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	                     if("${loginUser.id} == ${comment.id}"){
	                     htmls += '<a href="javascript:void(0)" onclick="editComment(' + this.cnum + ', \'' + this.id + '\', \'' + this.ccontent + '\' )" style="padding-right:5px">수정</a>';
	                     htmls += '<a href="javascript:void(0)" onclick="deleteComment(' + this.cnum + ')" >삭제</a>';
	                     }
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
	
	function editComment(cnum, id, ccontent, name){
		
		var name = '${loginUser.name}';

		var htmls = "";
		htmls += '<div class="media text-muted pt-3" id="cnum' + cnum + '">';
		htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
		htmls += '<title>Placeholder</title>';
		htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
		htmls += '</svg>';
		htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		htmls += '<span class="d-block">';
		htmls += '<strong class="text-gray-dark">' + id + '</strong>';
		htmls += '<strong class="text-gray-dark">' + '(' + name + ')' + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		htmls += '<a href="javascript:void(0)" onclick="updateComment(' + cnum + ', \'' + id + '\', \'' + name + '\' )" style="padding-right:5px">저장</a>';
		htmls += '<a href="javascript:void(0)" onClick="showCommentList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
		htmls += ccontent;
		htmls += '</textarea>';
		htmls += '</p>';
		htmls += '</div>';


		$('#cnum' + cnum).replaceWith(htmls);
		$('#cnum' + cnum + ' #editContent').focus();

	}
	
	function updateComment(cnum, id, name){

		var EditContent = $('#editContent').val();
		var paramData = JSON.stringify({"ccontent": EditContent
				, "cnum": cnum
		});

		var headers = {"Content-Type" : "application/json"
				, "X-HTTP-Method-Override" : "POST"};

		$.ajax({
			url: "${updateCommentURL}"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
                console.log(result);
                showCommentList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
		
		alert("댓글이 수정되었습니다.")
		location.reload();
		
	}
	

	
</script>










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
    <jsp:include page="../commons/head.jsp" />
<body>
<header>
		<jsp:include page="../commons/header.jsp" />
</header>
<main>
<br>
<br>
<br>
<c:set var="myctx" value="${pageContext.request.contextPath}"/>
<div class="container" style="margin-top: 30px">
	<div class="m-5 p-3 text-center"
         style="border: 1px solid gray;border-radius:15px;background-color:white;" id="font2">
        <h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">Q&A</h1>
        <br>
			<div class="row">
				<div class="col-md-9">
					<!-- 검색폼------------------------------------- -->
					<form name="findF" id="findF" action=<c:url value = "/complain"/>
						class="form-inline">
						<select name="findType" id="findType" class="form-control m-3">
							<option value="0">검색 유형</option>
							<option value="1">제 목</option>
							<option value="2">작성자</option>
							<option value="3">글내용</option>
						</select> 
						<input type="text" name="findKeyword" id="findKeyword"
							placeholder="검색어를 입력하세요" class="form-control m-3" required>
						<button class="btn">검 색</button>
					</form>
					<!-- ----------------------------- -->
				</div>
			</div>

			<table class="table table-hover" id="bbs">
				<tr style="font-weight:bold;">
					<th width="10%">글번호</th>
					<th width="40%">제 목</th>
					<th width="20%">작성자</th>
					<th width="20%">작성일</th>
					<th width="10%">조회수</th>
				</tr>
				<c:if test="${boardList eq null or empty boardList}">
					<tr>
						<td colspan="5">데이터가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${boardList ne null and not empty boardList}">
					<c:forEach var="board" items="${boardList}">
						<tr>
						    <td>
						      <c:choose>
							    <c:when test="${board.category eq 0 }">
									<div class="badge rounded-pill bg-danger" style="font-size:15px;">공지</div>&nbsp;
								</c:when>
								<c:otherwise>
									<c:out value="${board.num}" />
								</c:otherwise>
						      </c:choose>
							</td>
							<td style="text-align: left; padding-left: 10px">
							<c:forEach var="k" begin="0"  end="${board.level}">&ensp;</c:forEach>
							<a href="complainView?num=<c:out value="${board.num}"/>">
							<c:if test="${board.level>=1}">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
  						           <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
								</svg>&nbsp;
                           </c:if>
							<c:out value="${board.title}" /></a>					
							<c:if test="${board.newImg eq 1 }">
							   <span class="badge badge-warning" style="font-size:13px;">New</span>
							</c:if>
							<c:if test="${board.user_dt ne '9' }">
							<td><c:out value="${board.name}"/>(${board.id})</td>	
							</c:if>
							<c:if test="${board.user_dt eq '9' }">
							<td>			
							<div style="font-size:20px;">
			                <span class="badge badge-primary">관리자</span>
			                </div>
			                </td>	
							</c:if>
							<td><fmt:formatDate value="${board.register_day}" pattern="yyyy-MM-dd"/></td>
							<td><c:out value="${board.hits}" /></td>
						</tr>
					</c:forEach>
				</c:if>	
			  </table>
			  <div class="container" style="padding-top: 30px;" id="paging">
					${pageNavi}
			  </div>
			  <div align="right">
				  <a href="${pageContext.request.contextPath}/complainInsert"> <button class="btn">글쓰기</button></a>
			  </div>
	</div>
</div>
<br>
  

</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
</body>
<script type="text/javascript">
	$(function() {
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
</script>
</html>
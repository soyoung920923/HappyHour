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
<c:set var="myctx" value="${pageContext.request.contextPath}"/>

<div class="container" style="margin-top: 30px">
	<div class="row">

		<div class="col-sm-9 text-center">
			<h1 class="text-center m-4">건의사항</h1>
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
				<tr class="table-secondary">
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
							<td><c:out value="${board.num}" /></td>
							<td style="text-align: left; padding-left: 10px">
							<c:forEach var="k" begin="0"  end="${board.level}">&ensp;</c:forEach>
							<a href="view?num=<c:out value="${board.num}"/>">
							<c:if test="${board.level>=1}">
								<div class="badge badge-info">답변</div>&nbsp;
                           </c:if>
							<c:out	value="${board.title}" /></a>
							<c:if test="${board.origin_filename ne null}">
							   <img src="/resources/image/exist.png" width="16px">
							</c:if>
							<c:if test="${board.newImg eq 1 }">
							   <span class="badge badge-warning">New</span>
							</c:if>
							<td><c:out value="${board.name}" /></td>
							<td><fmt:formatDate value="${board.register_day}" pattern="yyyy-MM-dd"/></td>
							<td><c:out value="${board.hits}" /></td>
						</tr>
					</c:forEach>
				</c:if>	
			  </table>
				    <div align="center">
						${pageNavi}
				    </div>
			  <div align="right">
				  <a href="${pageContext.request.contextPath}/insert"> <button class="btn">글쓰기</button></a>
			  </div>

				</div>
	</div>
</div>

  

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
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
		<form:form modelAttribute="store" action="" id="f" name="f" method="POST" enctype="multipart/form-data">
			<c:if test="${store ne null}">
				<input type="hidden" name="idx" value="${store.idx}" />
			</c:if>
			<br><br>
			<c:if test="${store ne null}">			
				<%-- <div class="in clickInfo-par">
			    	<div class="card align-middle clickInfo">
			    		클릭수&nbsp;${store.hit_Count}
			    	</div>
			    </div> --%>
			    <div class="in list-in" >
				    <ul id="top-arrow-menu-ul">
						<li>
							<a href="<c:url value='/store/list?business=business'/>" class="top-arrow-menu">
								<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>&nbsp;목록
							</a>
						</li>
						<li>
							<a href="<c:url value='/store/enroll?idx=${store.idx}'/>" class="top-arrow-menu">식당정보&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="2.5rem" height="2.5rem" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
								</svg>
							</a>
						</li>
					</ul>
				</div>
			</c:if>
			<div class="in">
			    <div class="card align-middle">
			        <div class="card-title" style="margin-top: 30px;">
			            <h2 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">
			            	<c:choose>
								<c:when test="${store ne null}">
									${store.store_Nm}
								</c:when>
								<c:otherwise>
									Store
								</c:otherwise>
							</c:choose>			            
			            </h2>
			        </div>
			        <div class="card-body">
				        <h6 class="form-signin-heading" style="text-align:center;color:1F2229;">식당에 대한 통계정보를 확인해보세요.</h6>
				        <!-- <label class="sy-only">*클릭수</label><br>
						<input type="text" name="hitCount" id="hitCount" class="form-control" value="33" readOnly><br> -->
						<table class="board-table">
							<tr>
								<th colspan="6" class="board-title">
									<i class='far'>&#xf0a6;</i> 클릭수
								</th>
							</tr>
							<tr><td colspan="6" class="board-cont board-table-td">${store.hit_Count}건</td></tr>
						</table>
						<table class="board-table">
							<tr>
								<th colspan="6" class="board-title">
									<i class='far'>&#xf274;</i> 줄서기/예약 통계
								</th>
							</tr>
							<tr>								
								<td class="board-title2 board-table-td">방문</td>
								<td class="board-title2 board-table-td">노쇼</td>
								<td class="board-title2 board-table-td">취소</td>
								<td class="board-title2 board-table-td">기타</td>
								<td class="board-title2 board-table-td">총</td>
								<td class="board-title2 board-table-td">방문율</td>
							</tr>
							<c:forEach items="${resultList}" var="result" varStatus="i">
								<c:if test="${i.index eq 0}">
									<tr><td colspan="6" class="board-title1 board-table-td">이번달</td></tr>
								</c:if>
								<c:if test="${i.index eq 2}">
									<tr><td colspan="6" class="board-title1 board-table-td">지난달</td></tr>
								</c:if>
								<c:if test="${i.index eq 0 || i.index eq 2}">
									<tr><td colspan="6" class="board-title2 board-table-td">줄서기</td></tr>
								</c:if>
								<c:if test="${i.index eq 1 || i.index eq 3}">
									<tr><td colspan="6" class="board-title2 board-table-td">예약</td></tr>
								</c:if>
								<tr>									
									<td class="board-cont board-table-td">${result.visit}건</td>
									<td class="board-cont board-table-td">${result.noshow}건</td>
									<td class="board-cont board-table-td">${result.cancel}건</td>
									<td class="board-cont board-table-td">${result.etc}건</td>
									<td class="board-cont board-table-td">${result.total}건</td>
									<td class="board-cont board-table-td">${result.visitRate}%</td>
								</tr>
							</c:forEach>
						</table>										        
			        </div>
			    </div>
			</div>
			<br><br><br><br>
			
		</form:form>		
	</main>
	
	 <%-- <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
</body>
<script type="text/javascript">
$(function(){
	$('#bottom-nav3').css('display','block');
	$('#fixed-box-top').css('bottom','5.5%');
	$('.bottom-nav-li3').removeClass('on');
	$('.bottom-nav-li3').eq(2).addClass('on');
		
	
});





</script>
</html>
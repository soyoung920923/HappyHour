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
			<br><br><br>
			<form id="searchList" name="searchList">
				<input type="hidden" id="startCount" name="startCount" value="0"/>
				<input type="hidden" id="viewCount" name="viewCount" value="0"/>
				<input type="hidden" id="totalCount" name="totalCount" value="${total }"/>
				<input type="hidden" id="path" name="path" value="${path }"/>
			</form>
			<table style="margin: 0 auto;" id="store-list">
				<c:if test="${total > 0}">
					<c:forEach items="${list}" var="list">
						<tr>
							<td>
								<!-- 리스트 한 개 시작 -->
								<div class="in list-in">
								    <div class="card align-middle list-card">
								        <div class="card-body">				       
									       <ul class="list-ul">
									       	<li class="list-li-img"><div class="list-img-thum"><img alt="" src="<c:url value='/resources/upload/${list.store_Img_Oid }'/>"></div></li>
									       	<%-- <li class="list-li-img"><div class="list-img-thum"><img alt="" src="${pageContext.request.contextPath}/resources/upload/${list.store_Img_Oid }"></div></li> --%>
									       	<li class="list-li-contents">
									       		<h6 class="list-title"><span class="list-category">${list.category }</span>&nbsp;&nbsp;&nbsp;${list.store_Nm}</h6>
									       		<p class="list-cont">${list.store_Info}</p>
									       	</li>
									       	<li class="list-li-hit">
									       		<i style='font-size:1.3rem' class='fa open-utils'>&#xf141;</i><br>
									       		<i style='font-size:1.3rem' class='far'>&#xf0a6;</i> ${list.hit_Count }
									       	</li>
									       </ul> 				               
								        </div>   
								    </div>
								    <div class="utils">
								        	<div class="util">
									        	<i style='font-size:24px; color: #FFF;' class='fas'>&#xf095;</i>
								        	</div>
								        	<div class="util">
									        	<i style='font-size:24px; color: #FFF;' class='fas'>&#xf3c5;</i>
								        	</div>
								        	<div class="util">
									        	<i style='font-size:24px; color: #FFF;' class='fas'>&#xf274;</i>
								        	</div>
								        </div>
								</div>
								<!-- 리스트 한 개 끝 -->
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${total < 1}">
					<h5 style="width: 100%; text-align:center;">등록된 가게가 없습니다.</h5>
				</c:if>
			</table>
			
			<c:if test="${total > 5}">
				<div class="in list-in" id="btn-in">
					<div class="card align-middle plus-card">				
						<div class="card-body plus-card-body" id="moreList">
							<i style='font-size:1.3rem' class='fas'>&#xf078;</i>&nbsp;&nbsp;<span class="beside-icon">더보기</span>
						</div>			
					</div>
				</div>
			</c:if>
			
			
			<br><br><br><br>
			
	</main>
	
	
	<%--  <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer> --%>
	
	
	
<style>
	
	.list-in{
		margin-bottom: 0.9rem;
		position: relative;
	}
	.list-card{ 
	}
	.list-ul > li{
		
	}
	.list-li-img{
		width: 100%;
	}
	.list-li-contents{
		width: 100%;
		padding: 1.5rem 0.7rem;
		text-align: center;
	}
	.list-cont{
		margin-top: 1.2rem;
	}
	.list-li-hit{
		width: 100%;
		text-align: right;
	}
	.list-img-thum {
		width: 100%;
		height: 15rem;
		background-color: #F9EBE0;
		overflow: hidden;
	}
	.list-img-thum > img{
		width: 100%;
		height: 100%;
		object-fit:cover;
	}
	.list-category{
		/* padding: 0.4rem 2rem;
		border-radius: 2rem;
		background-color: #E30F0C;
		color: #fff; */
		padding: 0.3rem 1rem;
		border-radius: 2rem;
		border: 1px solid #E30F0C;
		color: #E30F0C;
	}
	.plus-card{
		border: 0px solid #fff;
		background-color: #E30F0C;
		text-align: center;
	}
	.plus-card-body{
		width: 100%;
		text-align: center;
		color: #fff;
		vertical-align: middle;
		cursor: pointer;
	}
	.beside-icon{
		font-weight: bold;
		font-size: 1.2rem;
	}
	#bottom-nav{
		width: 100%;
		height: 56px;
		background-color: #fff;
		border-top: 1px solid rgba(0,0,0,.125);
		text-align: center;
		white-space:nowrap;
		overflow-x:scroll;
		diplay: block;
		position: relative;
	}
	#bottom-nav::-webkit-scrollbar{
		display: none;
	}
	#bottom-nav-ul{
		padding: 0 2rem;
		margin: 0 auto;
		display: inline-block;
	}
	.bottom-nav-li{
		display: flex;
		padding: 0.9rem 2rem;
		display: inline-block;
		text-align: center;
		transition-duration: 0.5s;
	}
	.on{
		border-top: 3px solid #E30F0C;
		color: #E30F0C;
		font-weight: bold;
		transition-duration: 0.5s;
	}
	
	.on > a {color: #E30F0C;}
	.bottom-nav-arrow{
		position: fixed;
		z-index: 99999;
		bottom: 0%;
		padding: 15.5px 10px;
		background-color: #fff;
		cursor: pointer;
	}
	#arrow-left{		
		left: 0%;		
	}
	#arrow-right{
		right: 0%;
	}
	.utils{
		width: 180px;
		overflow: hidden;
		height: 50px;
		background-color: #1F2229;
		border-radius: 25px;
		text-align: center;
		position: absolute;
		bottom: -10px;
		right:-180px;
		opacity:0;
		transition-duration: 0.5s;
	}
	.util{
		display: inline-block;
		width: 40px;
		height: 50px;
		line-height: 50px;
		text-align: center;
	}
	#fixed-box{
 	width: 100%;
 	}
	@media (min-width: 768px) {
		.list-ul > li{
			display: inline-block;
			vertical-align: top;
		}
		.list-li-img{
		width: 30%;
	    }
	   .list-img-thum {
		width: 100%;
		height: 10rem;
	    }
	   .list-li-contents{
		width: 55%;
		text-align: left;
	   }
		.list-li-hit{
			width: 14%;
		}
	}
	.open-utils{cursor: pointer}
	.close-utils{cursor: pointer;}
	.utils.open{
		right: 0;
		opacity: 1;
	}
</style>	
<script type="text/javascript">
	$(function(){
		
		$('#bottom-nav').css('display','block');
		$('.bottom-nav-arrow').css('display','block');
	
		$('#moreList').click(function(){
			moreList('store-list',5);
		});
		
		function moreList(id, cnt) {
			var listLength = $('#'+id+" tr").length;
			var callLength = listLength;
			var total = $('#totalCount').val();
			
			$('#startCount').val(callLength);  	//불러올 리스트의 시작 번호
			$('#viewCount').val(cnt);			//불러올 리스트의 갯수
			
			$.ajax({
				type		: "POST",
				url			: "getMoreList",
				data		: $('#searchList').serialize(),
				dataType	: "json",
				success		: function(result){
					if (result.resultCnt > 0) {
						var resultList = result.resultList;						
						drawMoreList(resultList);
						var nowCount = $('#'+id+" tr").length;
						if (nowCount == total) {
							$('#btn-in').hide();
						}
					}
				},
				error		: function(){
					console.log("error");
				}
				
			});
		}
		
		
		function drawMoreList(resultList){
			
			var _html = "";
			for (var i = 0; i < resultList.length; i++) {
				var list = resultList[i];
				_html += "<tr><td><div class='in list-in'><div class='card align-middle list-card'><div class='card-body'><ul class='list-ul'><li class='list-li-img'><div class='list-img-thum'>";
				_html += "<img alt='' src='<c:url value='/resources/upload/"+list.store_Img_Oid+"'/>'></div></li>";
				_html += "<li class='list-li-contents'><h6 class='list-title'><span class='list-category'>"+list.category+"</span>&nbsp;&nbsp;&nbsp;"+list.store_Nm+"</h6>";
				_html += "<p class='list-cont'>"+list.store_Info+"</p></li>";
				_html += "<li class='list-li-hit'><i style='font-size:1.3rem' class='fa open-utils'>&#xf141;</i><br><i style='font-size:1.3rem' class='far'>&#xf0a6;</i> "+list.hit_Count+"</li></ul></div></div>";
				_html += "<div class='utils'><div class='util'><i style='font-size:24px; color: #FFF;' class='fas'>&#xf095;</i></div><div class='util'><i style='font-size:24px; color: #FFF;' class='fas'>&#xf3c5;</i></div><div class='util'><i style='font-size:24px; color: #FFF;' class='fas'>&#xf274;</i></div></div></div></td></tr>";		       				
			}
			$('#store-list tr:last').after(_html);
		}
		
		
		
		
		
		$('.open-utils').click(function(){			
			$(this).parents('.card').next('.utils').toggleClass('open');		
		});
		
	});
</script>
</body>

</html>
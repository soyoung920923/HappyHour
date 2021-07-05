<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true"
    pageEncoding="UTF-8"%>
<%
	response.setStatus(200);
%>
<script>
	alert('Error: ${pageContext.exception.message}')
	location.href="${pageContext.request.contextPath}/";
</script>
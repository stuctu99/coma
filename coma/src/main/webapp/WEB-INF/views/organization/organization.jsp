<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<style>
	div{
		border: 2px solid red;
	}
</style>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
	<div class="coma-container" style="text-align:center; display: math;">
		<h1>조직도</h1>
		<div class="row">
			<div class="col-1"></div>
			<div class="col5">
				<div class="row">
					<div class="col-10">
						<button type="button" class="btn btn-outline-primary">원장</button>
					</div>
					<div class="col-1"></div>
				</div>
				<div class="row">
					<div class="col-1"></div>
					<div class="col-2">
						<button type="button" class="btn btn-outline-primary">교육</button>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-outline-primary">행정</button>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-outline-primary">취업</button>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-outline-primary">회계</button>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-outline-primary">회계</button>
					</div>
					<div class="col-1"></div>
				</div>
				</div>
			</div>
			<div class="col5">
				<div class="row">
				
				</div>
			</div>
	</div>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
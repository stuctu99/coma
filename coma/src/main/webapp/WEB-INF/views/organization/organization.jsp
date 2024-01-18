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
/* 	div{
		border: 2px solid red;
	} */
	h1{
		margin:30px 0px 30px 0px;
	}
</style>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
	<div class="coma-container" style="margin-top:5px; margin-bottom: 5px; text-align:center; display: math;">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-6">
				<h1>조직도</h1>
			</div>
			<div class="col-1"></div>
			<div class="col-2">
				<h1>부서 소개</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-6" style="margin-right:20px; display: flex; justify-content: space-evenly; flex-direction: column;">
				<div style="width: 100%; height: 100%;">
					<img src="${path }/resource/img/organization/COMA_demo.png" style="width: 100%; height: 800px; border-radius: 25px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
				</div>
			</div>
			<div class="col-1" style="display: flex; justify-content: space-evenly; flex-direction: column;">
				<div>
					<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-color="primary" data-placement="right" data-content="This is a very beautiful popover, show some love.">
					 	원장
					</button>
				</div>
			</div>
			<div class="col-2">
				<div>부서 소개 글</div>
			</div>
		</div>
	</div>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
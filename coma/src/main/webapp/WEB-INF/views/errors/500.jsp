<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
<div class="coma-container" style="display: flex; margin-top: 5px; margin-bottom: 5px; flex-direction: column; height: 900px; align-items: center; justify-content: center">
	<div>
		<img src="${path }/resource/img/brand/COMA2.png">
	</div>
	<div>
		<h2>죄송합니다 잘못된 요청 입니다. 관리자에게 문의해주세요</h2>
	</div>
	<div style="margin-top:10px;">
		<button type="button" class="btn btn-primary" onclick="location.replace('${path}/')">메인 화면</button>
	</div>
</div>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
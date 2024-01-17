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
	<div class="coma-container" style="margin-top:5px; margin-bottom: 5px; text-align:center; display: math; ">
		<h1>조직도</h1>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-6" style="margin-right:20px; display: flex; justify-content: space-evenly; flex-direction: column;">
				<div style="width: 800px; height: 600px;">
					<img src="${path }/resource/upload/organization/COMA.png" style="width: 800px; height: 600px; border-radius: 25px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
				</div>
			</div>
			<div class="col-1" style="display: flex; justify-content: space-evenly; flex-direction: column;">
				<div>
					<button type="button" class="btn btn-outline-primary" onclick="fn_organiztionDept();">원장</button>
				</div>
				<div>
					<button type="button" class="btn btn-outline-primary">교육</button>
				</div>
				<div>
					<button type="button" class="btn btn-outline-primary">행정</button>
				</div>
				<div>
					<button type="button" class="btn btn-outline-primary">취업</button>
				</div>
				<div>
					<button type="button" class="btn btn-outline-primary">회계</button>
				</div>
			</div>
			<div class="col-2">
				<table class="table align-items-center">
			        <thead class="thead-light">
			            <tr>
			                <th scope="col" class="sort" data-sort="name">Name</th>
			                <th scope="col" class="sort" data-sort="budget">Job</th>
			            </tr>
			        </thead>
			        <tbody class="list">
			        	
			        </tbody>
				</table>
			</div>
		</div>
	</div>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
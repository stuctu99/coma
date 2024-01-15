<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginmember"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path }/resource/css/chat/chat.css" rel="stylesheet">
<link href="${path }/resource/css/chat/chatView.css" rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

Latest compiled JavaScript
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="/resource/js/jquery-3.7.0.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<!-- Icons -->
<link href="${path }/resource/js/plugins/nucleo/css/nucleo.css"
	rel="stylesheet" />
<link
	href="${path }/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"
	rel="stylesheet" />
<!-- CSS Files -->
<link href="${path }/resource/css/argon-dashboard.css?v=1.1.2"
	rel="stylesheet" />
<style>
div {
	/* border: 1px solid red; */
	
}
</style>
</head>
<body>
	<header>
		<div class="container text-center">
			<div class="row">
				<div class="col-1" style="padding: 0px 0px;">
					<button id="bars">&#9776</button>
				</div>
				<div class="col-11 chat-title">
					<h1>COMA MESSENGER</h1>
					<input type="hidden" id="roomNo" value="${roomNo}" /> <input
						type="hidden" id="loginMember" value="${loginmember.empId }" />
				</div>
			</div>
			<hr style="margin: 2px 0;">
			<div class="row">
				<div class="col-1">
					<button id="back" style="transform: rotate(180deg);">&#10132</button>
				</div>
				<div class="col-10">
					<h4 style="line-height: 2.0;">${room.roomName }</h4>
				</div>
				<nav id="menu">
					<ul>
						<li>
							<div class="col-12 profile">&nbsp;</div>
						</li>
					</ul>
					<div class="container profile-list" style="height: 499px;">
						<c:if test="${not empty roomMemberList}">
							<c:forEach var="emp" items="${roomMemberList }">
								<div class="row">
									<div class="col-2 profile">
										<c:if test="${emp.empGender eq 'M' }">
											<img id="profile-img"
												src="${path }/resource/img/chat/profile_m.png"
												alt="basic_profile_img" />
										</c:if>
										<c:if test="${emp.empGender eq 'F' }">
											<img id="profile-img"
												src="${path }/resource/img/chat/profile_f.png"
												alt="basic_profile_img" />
										</c:if>
									</div>

									<div class="col-9 emp-info">
										<strong><c:out value="${emp.empName}" /></strong>&nbsp;
										<c:out value="${emp.job.jobType }" />
										<c:choose>
											<c:when test="${empList.contains(emp.empId) }">
												<strong class="connectView" id="${emp.empId }" style="color: lime;">&#9900</strong>
											</c:when>
											<c:otherwise>
												<strong class="connectView" id="${emp.empId }" >&#9900</strong>
											</c:otherwise>
										</c:choose>
									</div>

								</div>
							</c:forEach>
						</c:if>
					</div>
					<div>
						<button class="btn btn-primary" id="exit-btn">채팅방 나가기</button>
					</div>
				</nav>
			</div>
			<%-- <div class="row header-menu">
				<div class="col-6 emp-list-btn">
					<img src="${path }/resource/img/chat/list-icon.png" />
				</div>
				<div class="col-6 chatting-list-btn">
					<img src="${path }/resource/img/chat/chat-icon.png" />
				</div>
			</div> --%>
			<hr>
			<hr>
		</div>
	</header>
	<section>
		<div class="container messageView${roomNo }">
			${roomMemberList }
			<c:if test="${not empty chatMsg }">
				<c:forEach var="msg" items="${chatMsg }">
					<c:if test="${msg.empId eq loginmember.empId}">
						<div class="row me">
							<span>나</span>
						</div>
						<div class="row me">
							<div class="time-container">
								<small><fmt:formatDate value="${msg.chatCreateDate}"
										pattern="HH:mm" /></small>
							</div>
							<div class="msg-container">
								<span><c:out value="${msg.chatContent }" /></span>
							</div>
						</div>
					</c:if>
					<c:if test="${msg.empId != loginmember.empId }">
						<div class="row other">
							<span>${msg.empObj.empName }</span>
						</div>
						<div class="row other">
							<div class="msg-container">
								<span><c:out value="${msg.chatContent }" /></span>
							</div>
							<div class="time-container">
								<small><fmt:formatDate value="${msg.chatCreateDate}"
										pattern="HH:mm" /></small>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
	</section>
	<footer id="chatView-footer">
		<div class="container">
			<div class="row" style="padding: 0px 10px;">
				<div class="input-group mb-3">
					<input type="text" id="msg" class="form-control"
						placeholder="메세지를 입력하세요!" aria-label="Recipient's username"
						aria-describedby="button-addon2">
					<div class="input-group-append">
						<button id="btnSend" class="btn btn-outline-primary" type="button"
							id="button-addon2" style="height: 46px;" onclick="sendMessage();"
							disabled="disabled">전송</button>
					</div>
				</div>
			</div>
			<div class="row">
				<!-- <div class="col-12">
					<hr class="footer-hr">
				</div> -->
			</div>
		</div>
	</footer>
</body>
<script src="https://kit.fontawesome.com/787f35b479.js"
	crossorigin="anonymous"></script>
<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<script
	src="${path }/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<!--   Optional JS   -->
<script src="${path }/resource/js/plugins/chart.js/dist/Chart.min.js"></script>
<script
	src="${path }/resource/js/plugins/chart.js/dist/Chart.extension.js"></script>
<!--   Argon JS   -->
<script src="${path }/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
<%-- <script src="${path }/resource/js/chat/chat.js"></script> --%>
<script>
	let bars = document.querySelector("#bars");
	let menu = document.querySelector("#menu");

	bars.addEventListener('click', function() {
		menu.classList.toggle("active");
	});

	const loginId = "${loginmember.empId}";
	const empName = "${loginmember.empName}";
</script>
<script src="${path }/resource/js/chat/chatView.js"></script>
</html>
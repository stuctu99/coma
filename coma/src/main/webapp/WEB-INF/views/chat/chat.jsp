<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ItTalk</title>
<link href="${path }/resource/css/chat/chat.css" rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="/resource/js/jquery-3.7.0.js"></script>
Latest compiled JavaScript
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<!-- Icons -->
<link href="${path }/resource/js/plugins/nucleo/css/nucleo.css" rel="stylesheet" />
<link
	href="${path }/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"
	rel="stylesheet" />
<!-- CSS Files -->
<link href="${path }/resource/css/argon-dashboard.css?v=1.1.2" rel="stylesheet" />
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
				<hr>
				<div class="col-12 chat-title">
					<h1>itTalk</h1>
				</div>
			</div>
			<hr style="margin: 2px 0;">
			<div class="row header-menu">
				<div class="col-6 emp-list-btn">
					<img src="${path }/resource/img/chat/list-icon.png" />
				</div>
				<div class="col-6 chatting-list-btn">
					<img src="${path }/resource/img/chat/chat-icon.png" />
				</div>
			</div>
			<hr>
			<hr>
		</div>
	</header>
	<section>
		<div class="container emp-list">
			<div class="row">
				<div class="col-12">
					<h2>사원 리스트</h2>
				</div>
			</div>
			<!------------------- 사원 데이터 ----------------------->
			<c:if test="${not empty emp}">
				<c:forEach var="d" items="${dept}">
						<div class="row">
							<div class="col-12 job-class">
								<strong><c:out value="${d.deptType}"/>부</strong>
							</div>
						</div>
						
					<c:forEach var="e" items="${emp}">
						<c:if test="${e.dept.deptCode eq d.deptCode}">
						<div class="row">
							<div class="col-2 job-name">
								<small><c:out value="${e.job.jobType }"/></small>
							</div>
							<div class="col-8">
								<small><c:out value="${e.empName}"/></small>
							</div>
							<div class="col-2">
								<button id="chatting-active" class="btn btn-outline-primary">채팅</button>
							</div>
						</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</c:if>
			<!---------------------------------------------------->
		</div>
		<!-- <button id="create-room" class="btn btn-outline-primary">+</button> -->
		<!-- ----------------------------------------------------------- -->

		<div class="container chatting-list" style="display: none">
			<div class="row">
				<div class="col-12">
					<h2>채팅 리스트</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-2">
					<strong>유형</strong>
				</div>
				<div class="col-8">
					<strong>제목</strong>
				</div>
				<div class="col-2">
					<input type="hidden" id="pathValue" value="${path }"/>
					<button id="create-room" type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#exampleModal">방생성</button>
				</div>
			</div>
			<div class="container content">
			
			</div>
		</div>


		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
				<form action="/messenger" method="post">
					<div class="modal-header">
						<h3 class="modal-title" id="exampleModalLabel">채팅방 생성</h3>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container">
							<div class="row">
								<div class="col-6">
									<strong>채팅방 제목</strong>								
								</div>
								<div class="col-6">
									<strong>유형</strong>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<input type="text" name="roomName"/>
								</div>
								<div class="col-6">
									<select name="roomType">
										<option value="A">공통</option>
										<option value="D1">관리부</option>
										<option value="D2">행정부</option>
										<option value="D3">회계부</option>
										<option value="D4">교육부</option>
										<option value="D5">취업부</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
								<strong>비밀번호</strong>								
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<input type="password" name="roomPassword" id="roomPassword" disabled/>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<input type="checkbox" name="roomPasswordFlag" id="roomPasswordFlag"/>
									<label for="roomPasswordFlag"><strong>비밀번호</strong></label>
								</div>
							</div>
						</div>
			
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button class="btn btn-primary">생성</button>
					</div>
					</form>
				</div>
			</div>
		</div>

		<!-- <div class="row">
			<input type="text" id="mid"/>
			<button type="button" id="btnLogin" class="btn btn-primary">로그인</button>
		</div>
		<div class="row message-container">
				<div class="col-12" id="contents">
					<h4>메세지출력</h4>
					<hr>
					
				</div>
				
		</div>
		<div class="row input-container">
			<textarea id="msg"></textarea>
			<button type="button" id="btnSend" class="btn btn-primary">전송</button>
		</div> -->
		<div class="modal fade" id="passwordScreen" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" id="passwordScreen_title">입장코드입력</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class="container">
		        	<div class="row">
		        		<div class="col-12">
		        			<input type="hidden" id="check-roomNo" value=""/>
		        			<input type="password" id="passwordCode" name="passwordCode" placeholder="입장코드를 입력하세요."/>
		        		</div>
		        	</div>
		        </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">돌아가기</button>
		        <button type="button" class="btn btn-primary" id="password-check" onclick="passwordCheck();" >입장</button>
		      </div>
		    </div>
		  </div>
		</div>
	</section>
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-12">
					
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<hr class="footer-hr">
				</div>
			</div>
		</div>
	</footer>
</body>
<script src="https://kit.fontawesome.com/787f35b479.js" crossorigin="anonymous"></script>
<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<script
	src="${path }/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<!--   Optional JS   -->
<script src="${path }/resource/js/plugins/chart.js/dist/Chart.min.js"></script>
<script src="${path }/resource/js/plugins/chart.js/dist/Chart.extension.js"></script>
<!--   Argon JS   -->
<script src="${path }/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
<script src="${path }/resource/js/chat/chat.js"></script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resource/css/chat/chat.css" rel="stylesheet">
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
<link href="/resource/js/plugins/nucleo/css/nucleo.css" rel="stylesheet" />
<link
	href="/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css"
	rel="stylesheet" />
<!-- CSS Files -->
<link href="/resource/css/argon-dashboard.css?v=1.1.2" rel="stylesheet" />
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
					<img src="/resource/img/chat/list-icon.png" />
				</div>
				<div class="col-6 chatting-list-btn">
					<img src="/resource/img/chat/chat-icon.png" />
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
					<h4>사원 리스트</h4>
				</div>
			</div>
			<!------------------- 사원 데이터 ----------------------->
			<div class="row">
				<div class="col-12 job-class">
					<c:out value="${empList}"/>
					<strong>임원진</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>원장</small>
				</div>
				<div class="col-7">
					<small>유병승</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<!---------------------------------------------------->
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>부원장</small>
				</div>
				<div class="col-7">
					<small>이규홍</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>인사부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>팀장</small>
				</div>
				<div class="col-7">
					<small>정우현</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>팀원</small>
				</div>
				<div class="col-7">
					<small>장세영</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>행정문서부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>팀장</small>
				</div>
				<div class="col-7">
					<small>이보연</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>사원</small>
				</div>
				<div class="col-7">
					<small>최종민</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>강사부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>강사팀장</small>
				</div>
				<div class="col-7">
					<small>김철수</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>강사</small>
				</div>
				<div class="col-7">
					<small>김영희</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>행정문서부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>팀장</small>
				</div>
				<div class="col-7">
					<small>이보연</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-2 job-name">
					<small>팀원</small>
				</div>
				<div class="col-7">
					<small>최종민</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-primary">채팅</button>
				</div>
			</div>
		</div>
		<!-- <button id="create-room" class="btn btn-outline-primary">+</button> -->
		<!-- ----------------------------------------------------------- -->

		<div class="container chatting-list" style="display: none">
			<div class="row">
				<div class="col-12">
					<h4>채팅 리스트</h4>
				</div>
			</div>
			<div class="row">
				<div class="col-12 chatting-room">
					<strong>임원진</strong>
				</div>
			</div>
		</div>


		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
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
									<input type="text"/>
								</div>
								<div class="col-6">
									<select name="roomType">
										<option value="All">공통</option>
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
									<input type="password" id="password" disabled/>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<input type="checkbox" id="passwordFlag"/>
									<label for="passwordFlag"><strong>비밀번호</strong></label>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button type="button" onclick="createRoom();" class="btn btn-primary">생성</button>
					</div>
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
	</section>
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-12">
					<button id="create-room" type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#exampleModal">+</button>
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
<script src="/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<script
	src="/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<!--   Optional JS   -->
<script src="/resource/js/plugins/chart.js/dist/Chart.min.js"></script>
<script src="/resource/js/plugins/chart.js/dist/Chart.extension.js"></script>
<!--   Argon JS   -->
<script src="/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
<script src="/resource/js/chat/chat.js"></script>
</html>
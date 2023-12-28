<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resource/css/chat/chat.css" rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="/resource/js/jquery-3.7.0.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
			<div class="row">
				<div class="col-12 job-class">
					<strong>임원진</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>원장</small> <small>유병승</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>부원장</small> <small>이규홍</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>인사부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>팀장</small> <small>정우현</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>팀원</small> <small>장세영</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>행정문서부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>팀장</small> <small>이보연</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>사원</small> <small>최종민</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>강사부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>강사팀장</small> <small>김철수</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>강사</small> <small>김영희</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-12 job-class">
					<strong>행정문서부</strong>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>팀장</small> <small>이보연</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-9">
					<small>사원</small> <small>최종민</small>
				</div>
				<div class="col-2" style="padding: 0px 0px;">
					<button class="btn btn-outline-primary">대화</button>
				</div>
			</div>
		</div>
		<button id="create-room" class="btn btn-outline-primary">+</button>
		<!-- ----------------------------------------------------------- -->
		
		<div class="container chatting-list" style="display:none">
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
			<button id="create-room" class="btn btn-outline-primary">+</button>
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
					<hr class="footer-hr">
					</div>
					
				</div>
			</div>
		</footer>
</body>
<script src="/resource/js/chat/chat.js"></script>
</html>
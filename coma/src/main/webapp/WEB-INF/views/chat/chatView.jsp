<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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
				<div class="col-1">
					<button id="bars">&#9776</button>
				</div>
				<div class="col-11 chat-title">
					<h1>itTalk</h1>
				</div>
			</div>
			<hr style="margin: 2px 0;">
			<div class="row">
				<div class="col-11">
				<h2>채팅방</h2>
				</div>
			
						<nav id="menu">
		        <ul>
		            <li><a href="">HOME</a></li>
		            <li><a href="">COMPANY</a></li>
		            <li><a href="">CONTACT</a></li>
		        </ul>
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
		<div class="container">
			<div class="row">
				<h1>채팅화면</h1>
			</div>
			<div class="row">
				<div id="contents"></div>
			</div>
		</div>
	</section>
	<footer id="chatView-footer">
		<div class="container">
			<div class="row" style="padding:0px 10px;">
				<div class="input-group mb-3">
			  	<input type="text" id="msg" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
				  <div class="input-group-append">
				    <button id="btnSend" class="btn btn-outline-primary" type="button" id="button-addon2" style="height:100%;">Button</button>
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
<script>

		
		/* 웹소켓 채팅 */
/* 		$(document).ready(function(){
			
			
			
		}) */
		alert("환영합니다!");
		function getId(id) {
			return document.getElementById(id);
		}

		var data = {};//전송 데이터(JSON)

		var server;
		/* var mid = getId('mid'); */
		var btnLogin = getId('btnLogin');
		var btnSend = getId('btnSend');
		var talk = getId('contents');
		var msg = getId('msg');
		$(document).ready(function() {
			server = new WebSocket("ws://" + location.host + "/chattingServer");

			server.onmessage = function(msg) {
				var data = JSON.parse(msg.data);
				var css;

				console.log(data);

				if (data.mid == "test" /* mid.value */ ) {
					css = 'class=me';
				} else {
					css = 'class=other';
				}

				var item = "<div "+css+"><span><b>"+data.mid+"</b></span>[ "+data.date+" ]<br/><span>"+data.msg+"</span></div>";

				talk.innerHTML += item;
				talk.scrollTop = talk.scrollHeight;//스크롤바 하단으로 이동
			}
		})
		

		msg.onkeyup = function(ev) {
			if (ev.keyCode == 13) {
				send();
			}
		}

		btnSend.onclick = function() {
			send();
		}

		function send() {
			if (msg.value.trim() != '') {
				data.mid = "test" /* getId('mid').value ; */
				data.msg = msg.value;
				data.date = new Date().toLocaleString();
				var temp = JSON.stringify(data);
				server.send(temp);
			}
		msg.value = '';
		}
		
		let bars = document.querySelector("#bars");
        let menu = document.querySelector("#menu");

        bars.addEventListener('click',function(){
            menu.classList.toggle("active");
        });

</script>
</html>
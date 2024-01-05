/*		 웹소켓 채팅 
		alert("환영합니다!");
		function getId(id) {
			return document.getElementById(id);
		}

		var data = {};//전송 데이터(JSON)

		var server;
		var mid = getId('mid');
		var btnLogin = getId('btnLogin');
		var btnSend = getId('btnSend');
		var talk = getId('contents');
		var msg = getId('msg');
		$(document).ready(function() {
			server = new WebSocket("ws://" + location.host + "/chatting");

			server.onmessage = function(msg) {
				var data = JSON.parse(msg.data);
				var css;

				console.log(data);

				if (data.mid == "test" mid.value ) {
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
				data.mid = "test" getId('mid').value ;
				data.msg = msg.value;
				data.date = new Date().toLocaleString();
				var temp = JSON.stringify(data);
				server.send(temp);
			}
			msg.value = '';

		}*/
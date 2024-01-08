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

		}
*/



$("#exit-btn").click(function() {
	if (confirm("채팅방을 완전히 나가겠습니까?")) {
		const roomNo = $("#roomNo").val();
		const empId = $("#loginMember").val();
		fetch("/chatting",{
			method:"DELETE",
			headers:{"Content-Type":"application/json"},
			body:JSON.stringify({"roomNo":roomNo,"empId":empId})
		})
		.then(response=>{
			if(response.status!=200){
				throw new error("관리자에게 문의하세요!!!");
			}
			return response.json();
		})
		.then(data=>{
			if(data.result=="success"){
				location.href="/messenger";
			}else{
				alert("관리자에게 문의하세요!");
			}
		})
	}
})

$("#back").click(function() {
	window.history.back();
})

const server = new WebSocket("ws://" + location.host + "/chattingServer");
const roomNo = $("#roomNo").val();
const empId = $("#loginMember").val();
const connectCheck = $("div#" + empId);
console.log(roomNo, empId);

server.onopen = (response) => {
	connectCheck.parent().css("backgroundColor", "").css("opacity", 0.8);
	connectCheck.css("color", "lime");
	console.log(empId);
	console.log(response);
	/*fetch("/chatting",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body: JSON.stringify({"roomNo":roomNo,"empId":empId})
	})
	.then(response=>{
		if(response.status!=200){
			alert("접근할 수 없습니다. 관리자에게 문의하세요. ERROR CODE : "+response.status);
		}
		return response.json();
	})
	.then(data=>{
		if(!data){
			msg = new Message("open",empId,"","",roomNo);				
			server.send(msg.convert());
		}else{
			console.log("이미존재!!");
		}
	})*/
	const msg = new Message("open", empId, "", "", roomNo);
	server.send(msg.convert());

}

server.onmessage = (response) => {
	console.log(response);
	const receiveMsg = Message.deconvert(response.data);
	console.log("asdasd" + receiveMsg);
	switch (receiveMsg.type) {
		case "open": openMessage(receiveMsg); break;
		case "msg": messagePrint(receiveMsg); break;
	}

	console.log(receiveMsg);
}
const messagePrint = (msg) => {
	const div = document.createElement("div");
	const msgDiv = document.createElement("div");
	const content = document.createElement("span");
	
	content.innerText = msg.msg;
	msgDiv.appendChild(content);
	/*msgDiv.classList.add("col-3");*/
	div.classList.add("row");

	if (msg.sender == empId) {
		//sender가 로그인한 사원
		div.classList.add("me");
	} else {
		//이외 receiver
		div.classList.add("other");
	}
	div.appendChild(msgDiv)
	document.querySelector(".messageView"+msg.room).appendChild(div);
}

const sendMessage = () => {
	const msg = document.querySelector("#msg").value;
	document.querySelector("#msg").value = "";
	server.send(new Message("msg", empId, "", msg, roomNo).convert());
}

const openMessage = (msg) => {
	const container = $("<div>").addClass("row openMsgContainer");
	const content = $("<h4>").text(`${msg.sender}님이 접속하셨습니다.`);
	container.append(content);
	console.log("asdasdasdasdasd.messageView"+msg.room);
	$(".messageView"+msg.room).append(container);
}

window.onload = () => {
	document.getElementById("msg").addEventListener("keyup", e => {
		if (e.key == 'Enter') {
			/*sendMessage();*/
			document.querySelector("#btnSend").click();
			document.querySelector("#msg").value = "";
		}
	})
}

class Message {
	constructor(type = "", sender = "", receiver = "", msg = "", room = "") {
		this.type = type;
		this.sender = sender;
		this.reciever = receiver;
		this.msg = msg;
		this.room = room;
	}
	convert() {
		return JSON.stringify(this);
	}
	static deconvert(data) {
		return JSON.parse(data);
	}
}
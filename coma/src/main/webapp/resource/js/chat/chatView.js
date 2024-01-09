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
	close();
})

$(function(){
	
	$("section>.container").scrollTop($("section>.container")[0].scrollHeight);	
})




/* 채팅구현 */

const server = new WebSocket("ws://" + location.host + "/chattingServer");
const roomNo = $("#roomNo").val();
const empId = $("#loginMember").val();
const connectCheck = $("div#" + empId);
console.log(roomNo, empId);

console.log(empName);
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
	/*constructor(type,chatNo,chatContent,chatCreateDate,empId,roomNo)*/
	const msg = new Message("open","","",new Date(Date.now()),empId,roomNo);
	server.send(msg.convert());

}

server.onmessage = (response) => {
	console.log("response응답데이터 "+response.data);
	const receiveMsg = Message.deconvert(response.data);
	console.log("asdasd" + receiveMsg.type);
	switch (receiveMsg.type) {
		case "open": openMessage(receiveMsg); break;
		case "msg": messagePrint(receiveMsg); break;
	}

	console.log(receiveMsg);
}
const messagePrint = (msg) => {
	/*
		<div class="row me">
			\\if:class=me => < timeTag:small></small>
			<msgdiv>
				<content:span></content:span>
			</msgdiv>
			\\if:class=other => < timeTag:small></small>
		</div>
	
	*/
	const div = document.createElement("div");
	const nameDiv = document.createElement("div");
	const nameSpan = document.createElement("span");
	const msgDiv = document.createElement("div");
	const content = document.createElement("span");
	const timeDiv = document.createElement("div");
	const timeTag = document.createElement("small");
	
	div.classList.add("row"); //메세지 라인 컨테이너
	timeDiv.classList.add("time-container"); //전송 시간 컨테이너
	//메세지 전송 시간 출력
	timeTag.innerText=("0"+new Date(msg.chatCreateDate).getHours()).slice(-2)+":"+("0"+new Date(msg.chatCreateDate).getMinutes()).slice(-2)+"  ";
	timeDiv.appendChild(timeTag);
	
	//메세지 컨테이너
	msgDiv.classList.add("msg-container");	
	content.innerText = msg.chatContent;
	msgDiv.appendChild(content);
	
	/*fetch("/chatting/"+msg.empId,{
		mehtod:"get",
		headers:{
			"Conatent-Type":"application/json"
		}
	})
	.then(response=>{
		if(response.status!=200){
			alert("관리자에게 문의하세요!");
		}
		return response.json();
	})
	.then(data=>{
		console.log(data);
		if (msg.empId == empId) {
			//sender가 로그인한 사원
			nameDiv.classList.add("row","me");
			nameSpan.innertext=data.empName;
			nameDiv.appendChild(nameSpan);
			div.classList.add("me");
			div.appendChild(nameDiv);
			div.appendChild(timeDiv);
			div.appendChild(msgDiv);
		} else {
			//이외 receiver
			nameDiv.classList.add("row","other");
			nameSpan.innertext=data.empName;
			nameDiv.appendChild(nameSpan);
			div.classList.add("other");
			div.appendChild(nameDiv);
			div.appendChild(msgDiv);
			div.appendChild(timeDiv);
		}	
	})*/
			if (msg.empId == empId) {
			//sender가 로그인한 사원
			/*nameDiv.classList.add("row","me");
			nameSpan.innertext=data.empName;
			nameDiv.appendChild(nameSpan);*/
			div.classList.add("me");
			/*div.appendChild(nameDiv);*/
			div.appendChild(timeDiv);
			div.appendChild(msgDiv);
		} else {
			//이외 receiver
			/*nameDiv.classList.add("row","other");
			nameSpan.innertext=data.empName;
			nameDiv.appendChild(nameSpan);*/
			div.classList.add("other");
			/*div.appendChild(nameDiv);*/
			div.appendChild(msgDiv);
			div.appendChild(timeDiv);
		}	


	
	document.querySelector(".messageView"+msg.roomNo).appendChild(div);
}

const sendMessage = () => {
	const msg = document.querySelector("#msg").value;
	document.querySelector("#msg").value = "";
	/*type,chatNo,chatContent,chatCreateDate,empId,roomNo*/
	server.send(new Message("msg","",msg,new Date(Date.now()),empId,roomNo).convert());
}

const openMessage = (msg) => {
	const container = $("<div>").addClass("row openMsgContainer");
	const content = $("<h4>").text(`${msg.empId}님이 접속하셨습니다.`);
	container.append(content);
	$(".messageView"+msg.roomNo).append(container);
}

window.onload = () => {
	const $msg = $("#msg");
	$msg.focus();	
	$msg.on("keyup", (e) => {
		const $msg = $("#msg").val()
		if (e.key == 'Enter') {
			/*sendMessage();*/
			if($msg.length>0){
				$("#btnSend").click();
				$("#msg").val("");
			}else{
				alert("채팅을 입력하세요.");
			}
		}
	})
}

class Message {
	/*constructor(type = "", sender = "", receiver = "", msg = "", room = "", time) {
		this.type = type;
		this.sender = sender;
		this.reciever = receiver;
		this.msg = msg;
		this.room = room;
		this.time = time;
	}*/
	
	constructor(type="",chatNo="",chatContent="",chatCreateDate,empId="",roomNo=""){
		this.type=type;
		this.chatNo = chatNo;
		this.chatContent=chatContent;
		this.chatCreateDate = chatCreateDate;
		this.empId= empId;
		this.roomNo = roomNo;
	}
	convert() {
		return JSON.stringify(this);
	}
	static deconvert(data) {
		return JSON.parse(data);
	}
}
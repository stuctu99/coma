$("#exit-btn").click(function() {
	if (confirm("채팅방을 완전히 나가겠습니까?")) {
		const roomNo = $("#roomNo").val();
		const empId = $("#loginMember").val();
		console.log(roomNo, empId);
		fetch("/chatting", {
			method: "DELETE",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ "roomNo": roomNo, "empId": empId })
		})
			.then(response => {
				if (response.status != 200) {
					throw new error("관리자에게 문의하세요!!!");
				}
				return response.json();
			})
			.then(data => {
				if (data.result == "success") {
					$(opener.document).find(".chatting-list-btn").click();
					close();
				} else {
					alert("관리자에게 문의하세요!");
				}
			})
	}
})

$("#back").click(function() {
	const roomNo = $("#roomNo").val();
	const empId = loginId;
	/*$connect.css("color","black");*/
	fetch("/chatting/back",{
		method:"delete",
		headers:{
			"Content-Type":"application/json"
		},
		body:JSON.stringify({
			"roomNo":roomNo,
			"empId":empId
		})
	})
	.then(response=>{
		return response.json();
	})
	.then(data=>{
		if(data.result=='success'){
			console.log("나가기 성공");
			window.close();
			$("#chatting-list-btn").click();
		}
	})
})

$(function() {
	$("section>.container").scrollTop($("section>.container")[0].scrollHeight);
})




/* 채팅구현 */
const server = new WebSocket("ws://" + location.host + "/chattingServer");
const roomNo = $("#roomNo").val();
const empId = $("#loginMember").val();
console.log(roomNo, empId);
server.onopen = (response) => {
	console.log(empId);
	console.log(response);
	
	const msg = new Message("open", "", "", new Date(Date.now()), empId, roomNo);
	server.send(msg.convert());

}

server.onmessage = (response) => {
	console.log("response응답데이터 " + response.data);
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
	console.log(msg);
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
	timeTag.innerText = ("0" + new Date(msg.chatCreateDate).getHours()).slice(-2) + ":" + ("0" + new Date(msg.chatCreateDate).getMinutes()).slice(-2) + "  ";
	timeDiv.appendChild(timeTag);

	//메세지 컨테이너
	msgDiv.classList.add("msg-container");
	content.innerText = msg.chatContent;
	msgDiv.appendChild(content);

	if (msg.empId == empId) {
		//sender가 로그인한 사원
		nameDiv.classList.add("row", "me");
		nameSpan.innerText = '나';
		console.log(nameSpan);
		nameDiv.appendChild(nameSpan);
		div.classList.add("me");
		/*div.appendChild(nameDiv);*/
		div.appendChild(timeDiv);
		div.appendChild(msgDiv);
	} else {
		//이외 receiver
		nameDiv.classList.add("row", "other");
		nameSpan.innerText = msg.empObj.empName;
		nameDiv.appendChild(nameSpan);
		div.classList.add("other");
		/*div.appendChild(nameDiv);*/
		div.appendChild(msgDiv);
		div.appendChild(timeDiv);
	}


	document.querySelector(".messageView" + msg.roomNo).appendChild(nameDiv);
	document.querySelector(".messageView" + msg.roomNo).appendChild(div);
	document.querySelector(".messageView" + msg.roomNo).scrollTop = document.querySelector(".messageView" + msg.roomNo).scrollHeight;
}

const sendMessage = () => {
	const msg = document.querySelector("#msg").value;
	document.querySelector("#msg").value = "";
	/*type,chatNo,chatContent,chatCreateDate,empId,roomNo*/
	$("#btnSend").prop("disabled", true);
	server.send(new Message("msg", "", msg, new Date(Date.now()), empId, roomNo).convert());
}

const openMessage = (msg) => {
	/* NEW_JOIN FLAG 여부에 따라 메세지 출력 여부 결정하기*/
	const $connect = $("#"+msg.empId);
	$connect.css("color","lime");
	fetch("/chatting", {
		method: "PUT",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify({
			"roomNo": msg.roomNo,
			"empId": msg.empId

		})
	})
		.then(response => {
			if (response.status != 200) {
				alert("fetch함수 실패");
			}
			return response.json();
		})
		.then(data => {
			if (data.joinEmp!=null && data.joinEmp.newJoin === 'Y') {
				const container = $("<div>").addClass("row openMsgContainer");
				const content = $("<h4>").text(`${data.joinEmp.empObj.empId}님이 접속하셨습니다.`);
				$(".messageView" + msg.roomNo).append(container);
				container.append(content);
			}
			
		})


}

window.onload = () => {
	const $msg = $("#msg");
	const $btn = $("#btnSend");
	$msg.focus();
	$msg.on("keyup", (e) => {
		$btn.prop("disabled", false);
		const $msgVal = $msg.val();
		if ($msgVal.length > 0) {
			if (e.key == 'Enter') {
				sendMessage();
				$("#msg").val("");
				$btn.prop("disabled", true);
			}else if($msgVal.length==0){
				$btn.prop("disabled", true);
				
			}
		}else{
			$btn.prop("disabled", true);
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

	constructor(type = "", chatNo = "", chatContent = "", chatCreateDate, empId = "", roomNo = "") {
		this.type = type;
		this.chatNo = chatNo;
		this.chatContent = chatContent;
		this.chatCreateDate = chatCreateDate;
		this.empId = empId;
		this.roomNo = roomNo;
	}
	convert() {
		return JSON.stringify(this);
	}
	static deconvert(data) {
		console.log("비교1"+data);
		console.log("비교2"+JSON.parse(data));
		return JSON.parse(data);
	}
}


/*
$("#bars").click(function(){
	const roomNo = $("#roomNo").val();
	memberList(roomNo);
})

const memberList = (roomNo) => {
	const $profileListDiv = $(".profile-list");
	fetch("/chatting/memberlist/"+roomNo)
	.then(response=>{
		return response.json();
	})
	.then(data=>{
		data.roomMemberList.forEach(d=>{
			console.log(d);
			const $div = $("<div>").addClass("row "+d.empId);
			const $div_col2 = $("<div>").addClass("col-2 profile");
			const $div_col8 = $("<div>").addClass("col-8 emp-info");
			const $div_col1 = $("<div>").addClass("col-1 connectView").text("&#9900");
			const $img = $("<img>").attr("id","profile-img");
			
			$div_col8.append($("<strong>").text(d.empName));
			
			if(d.emp_gender=='M'){
				$img.attr("src",location.host+"/resource/img/chat/profile_m.png");
			}else{
				$img.attr("src",location.host+"/resource/img/chat/profile_f.png");
			}
			
			$div_col2.append($img);
			
			$div.append($div_col2);
			$div.append($div_col8);
			$div.append($div_col1);
			
			$profileListDiv.append($div);
			
		})
	})
}*/
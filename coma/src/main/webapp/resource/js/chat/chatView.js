$("#exit-btn").click(function() {
	if (confirm("채팅방을 완전히 나가겠습니까?")) {
		const roomNo = $("#roomNo").val();
		const empId = $("#loginMember").val();
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
					
					alert($(".connectView").val());
					server.send(new Message("out", "", "", "", empId, roomNo).convert());
					/*$(opener.document).find(".chatting-list-btn").click();*/
					close();
					opener.location.reload();
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
	connectUpdate(roomNo,empId);
	
})

const connectUpdate = (roomNo,empId) =>{
	console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	fetch("/chatting/back", {
		method: "delete",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify({
			"roomNo": roomNo,
			"empId": empId
		})
	})
		.then(response => {
			return response.json();
		})
		.then(data => {
			if (data.result) {
				console.log("나가기 성공");
				server.send(new Message("rest", "", "", "", empId, roomNo).convert());
				
				window.close();
				$("#chatting-list-btn").click();
			}
		})
}


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
		case "rest": connectionRest(receiveMsg); break;
		case "out": closeMessage(receiveMsg); break;
	}

	console.log(receiveMsg);
}
const messagePrint = (msg) => {
	/* 꼭 알아두기 !!! */
	$(opener.location).attr("href", "javascript:updateMsg('"+msg.roomNo+"','"+msg.chatContent+"');");
	
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
		nameSpan.innerText = msg.empObj.empName+" "+msg.empObj.job.jobType;
		nameDiv.appendChild(nameSpan);
		div.classList.add("other");
		/*div.appendChild(nameDiv);*/
		div.appendChild(msgDiv);
		div.appendChild(timeDiv);
	}


	document.querySelector(".messageView" + msg.roomNo).appendChild(nameDiv);
	document.querySelector(".messageView" + msg.roomNo).appendChild(div);
	document.querySelector(".messageView" + msg.roomNo).scrollTop = document.querySelector(".messageView" + msg.roomNo).scrollHeight;
	/* 테스트 */
/*	$(opener.document).find(".updateMsg-"+msg.roomNo).remove();
	const $updateMsg = $("<span>").addClass("updateMsg-"+msg.roomNo);
	$updateMsg.text("Message : "+msg.chatContent);
	$(opener.document).find("#chattingList #"+msg.roomNo).append($updateMsg);*/
}

const sendMessage = () => {
	const msg = document.querySelector("#msg").value;
	const $btnSend=$("#btnSend");
	document.querySelector("#msg").value = "";
	/*type,chatNo,chatContent,chatCreateDate,empId,roomNo*/
	$btnSend.removeClass("btn-primary");
	$btnSend.addClass("btn-outline-primary");
	$btnSend.prop("disabled", true);
	server.send(new Message("msg", "", msg, new Date(Date.now()), empId, roomNo).convert());
}

const openMessage = (msg) => {
	/* NEW_JOIN FLAG 여부에 따라 메세지 출력 여부 결정하기*/
	const $connectFlag = $(".list-"+msg.roomNo+" #" + msg.empId);
	$connectFlag.css("color", "lime");
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
			if (data.joinEmp != null && data.joinEmp.newJoin === 'Y') {
				const container = $("<div>").addClass("row openMsgContainer");
				const content = $("<h4>").text(`${data.joinEmp.empObj.empId}님이 접속하셨습니다.`);
				$(".messageView" + msg.roomNo).append(container);
				container.append(content);
			}

		})


}

const connectionRest = (msg) => {
	console.log("나가면 여기가 실행되어야해"+msg.empId);
	const $connectFlag = $(".list-"+msg.roomNo+" #" + msg.empId);
	$connectFlag.css("color", "black");
}

const closeMessage = (msg) => {
	const container = $("<div>").addClass("row openMsgContainer");
	const content = $("<h4>").text(`${msg.empObj.empName}님이 나가셨습니다.`);
	const invite = $("<button>").addClass("btn btn-danger").text("다시초대하기");
	$(".messageView" + msg.roomNo).append(container);
	container.append(content);
	container.append($("<br>"));
	container.append(invite);
	$(opener.document).find("#chatting-active").removeClass("btn-primary").addClass("btn-outline-primary").text('대화').attr("onclick","privateChatting('"+msg.empId+"','"+loginId+"');");
	$(".emp-list-btn").click();
	$("."+msg.empId).remove();
	/*opener.location.reload();*/
	
}

window.onload = () => {
	const $msg = $("#msg");
	const $btn = $("#btnSend");
	$msg.focus();
	$msg.on("keydown", (e) => {
		$btn.prop("disabled", false);
		$btn.removeClass("btn-outline-primary");
		$btn.addClass("btn-primary");
		const $msgVal = $msg.val();
		if ($msgVal.length > 0) {
			if (e.key == 'Enter') {
				sendMessage();
				$("#msg").val("");
				$btn.removeClass("btn-primary");
				$btn.addClass("btn-outline-primary");
				$btn.prop("disabled", true);
			} else if ($msgVal.length == 0) {
				$btn.prop("disabled", true);

			}
		} else {
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
		console.log("비교1" + data);
		console.log("비교2" + JSON.parse(data));
		return JSON.parse(data);
	}
}



$("#bars").click(function(){
	const roomNo = $("#roomNo").val();
	memberList(roomNo,loginId);
})

const memberList = (roomNo) => {
	const $profileListDiv = $(".list-"+roomNo);
	$profileListDiv.html("");
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
			const $div_col1 = $("<div>").addClass("col-1 connect-"+d.empId)
			const $img = $("<img>").attr("id","profile-img");
			const $name = $("<strong>").text(d.empName+" "+d.job.jobType);
			const $connection = $("<strong>").addClass("connectView").attr("id",d.empId);
			
			$connection.html('&nbsp;&#9900');
			if(Object.keys(data.roomMemberCheck).includes(d.empId)){
				/*Map으로 넘어온 형태에 key값 포함 여부 방식 !!! 알아두기*/
				$connection.css("color","lime");
			}else{
				$connection.css("color","black");
			}
			$div_col8.append($name);
			$name.next(d.job.jobType);
			/*$div_col9.text(d.job.jobType);*/
			$div_col1.append($connection);
			
			if(d.emp_gender=='M'){
				$img.attr("src","/resource/img/chat/profile_m.png");
			}else{
				$img.attr("src","/resource/img/chat/profile_f.png");
			}
			
			$div_col2.append($img);
			
			$div.append($div_col2);
			$div.append($div_col8);
			$div.append($div_col1);
			
			$profileListDiv.append($div);
			
		})
	})
}


/* 새로고침 방지 버튼 */
function NotReload(e){
    if( (e.ctrlKey == true && (e.keyCode == 78 || e.keyCode == 82)) || (e.keyCode == 116) ) {
        e.keyCode = 0;
        e.cancelBubble = true;
        e.returnValue = false;
    } 
}
document.onkeydown = NotReload;

/*window.addEventListener('beforeunload', () => {
	const roomNo = $("#roomNo").val();
	const empId = loginId;
	console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+roomNo + "" + empId);
	connectUpdate(roomNo,empId);
})*/
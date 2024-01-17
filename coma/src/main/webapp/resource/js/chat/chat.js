/*const contextPath=location.hostname;*/

const mserver = new WebSocket("ws://" + location.host + "/messengerServer");
mserver.onopen = () => {
	const msg = new MessageHandler("exec", loginId);
	mserver.send(msg.convert());
}

mserver.onmessage = (response) => {
	console.log(response.data);
	const respMsg = MessageHandler.deconvert(response.data);
	switch (respMsg.type) {
		case "exec":
			//실행시
			openEvent(respMsg);
			break;
		case "new":
			//방생성시 실시간 동기화 이벤트
			//roomNo:생서된 방번호, msg:'new'
			newRoom(respMsg);
			break;
		case "privateNew":
			privateNewRoom(respMsg);
			break;
		case "delete":
			openEvent(respMsg);
			break;
		case "msg":
			messageUpdate(respMsg);
			break;

	}
}

class MessageHandler {
	//type : 'exec'실행  /'create' 방생성 / 'alarm' 메세지알림 / 'invite' 초대 ...
	constructor(type = "", loginId = "", targetId = "", roomNo = "", msg = "") {
		this.type = type;
		this.loginId = loginId;
		this.targetId = targetId;
		this.roomNo = roomNo;
		this.msg = msg;
	}
	convert() {
		return JSON.stringify(this);
	}
	static deconvert(msg) {
		return JSON.parse(msg);
	}

}

function openEvent(data) {
	const loginId = data.loginId;
	console.log(loginId);
	fetch("/messenger/init/" + loginId)
		.then(response => {
			console.log(response);
			if (response.status != 200) {
				alert("못잔다...");
			}
			return response.json();
		})
		.then(data => {
			data.test.forEach(d => {
				$("." + d.target).attr("onclick", "enter_chattingRoom('" + d.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary").text("대화중");
			})
		})

}

function newRoom(data) {
	console.log("새로 생성된 채팅방" + data.roomNo);
	intiCreateModalInput();
	/*$(".chatting-list-btn").click();*/
	/*fn_roomListByType("engagement");*/
	//알림 보여줄 수 있도록 구현하면 좋을 것 같다.
}

function privateNewRoom(data) {
	console.log("여긴들어오니?");
	$("." + data.targetId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary").text("대화중");
	$("." + data.loginId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary").text("대화중");
}
/*=============================================================================*/
function intiCreateModalInput() {
	$("#roomName").val("");
	$("#roomPassword").val("");
}


/* 방생성 */

const createRoom = (empId) => {
	const roomName = $("#roomName").val();
	const roomPassword = $("#roomPassword").val();
	const roomPasswordFlag = $("#roomPasswordFlag").val();
	const roomType = $("#roomType").val();

	let inviteEmp = new Array();
	let cnt = 0;
	const inviteCheckbox = $(".invite_emp");
	for (i = 0; i < inviteCheckbox.length; i++) {
		if (inviteCheckbox[i].checked == true) {
			inviteEmp[cnt] = inviteCheckbox[i].value;
			cnt++;
		}
	}

	const ChattingRoom = {
		"roomName": roomName,
		"roomPassword": roomPassword,
		"roomType": roomType,
		"roomPasswordFlag": roomPasswordFlag,
		"empId": empId,
		"targetId": ""
	}

	console.log("초대멤버배열" + inviteEmp);


	fetch("/messenger/createRoom", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(ChattingRoom)
	})
		.then(response => {
			console.log(response);
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
			if (data.result == "success") {
				console.log("방생성 성공 // 초대인원 수 :" + inviteEmp.length);

				/* 초대 멤버가 존재할 때 실행 */
				if (inviteEmp.length > 0) {
					fetch("/messenger/invite/"+data.roomNo, {
						method: "post",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(inviteEmp)
					})
						.then(response => {
							if (response.status != 200) {
								alert("접근할 수 없습니다. 관리자에게 문의하세요:");
							}
							return response.json();
						})
						.then(data => {
							if (data.result == "success") {
								const msg = new MessageHandler("new", empId, "", "", "");
								mserver.send(msg.convert());
								$("#createRoom").modal('hide');
								if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
									intiCreateModalInput();
									enter_chattingRoom(data.roomNo);
								}
							} else {
								alert("관리자에게 문의하세요:");
							}
						})
				}
			} else {
				console.log("방생성 실패");
			}
		})

}

/* 1:1 채팅 */
const privateChatting = (targetId, targetName, empId, empName) => {
	console.log(targetId, empId);
	const privateChat = {
		"roomName": targetName + ", " + empName + " 대화방",
		"roomType": "P",
		"roomPassword": "",
		"roomPasswordFlag": "N",
		"empId": loginId,
		"targetId": targetId
	}
	console.log(privateChat);
	fetch("/messenger/createRoom", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(privateChat)
	})
		.then(response => {
			console.log(response);
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
			if (data.result == "success") {
				console.log("방생성 성공");
				const msg = new MessageHandler("privateNew", empId, targetId, "", "");
				mserver.send(msg.convert());
				$("#createRoom").modal('hide');
				if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
					intiCreateModalInput();
					enter_chattingRoom(data.roomNo);
				} else {
					newRoom();
					$("." + targetId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary").text("대화중");
				}
			} else {
				console.log("방생성 실패");
			}
		})
}

// 사원 리스트 뷰 출력
const empListDisplay = (target) => {
	console.log(target);
	$(target).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(target).children().css("width", "45px").css("height", "45px");
	$(".chatting-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".chatting-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "block");
}

// 채팅방 리스트 버튼 클릭 시 사원리스트 숨기기
const empListHidden = () => {
	$(this).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(this).children().css("width", "45px").css("height", "45px");
	$(".emp-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".emp-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "none");
}
// 채팅방 리스트 버튼 클릭 시 채팅방 리스트 뷰 출력
const chatListDisplay = (target) => {
	$(target).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(target).children().css("width", "45px").css("height", "45px");
	$(".chatting-list").css("display", "block");
	$("#create-room").css("display", "block");
}

// 사원리스트 버튼 클릭 시 채팅목록 뷰 숨김
const chatListHidden = () => {
	$(".chatting-list").css("display", "none");
	$("#create-room").css("display", "none");
}

// 사원 리스트 버튼
$(".emp-list-btn").click(function() {
	target = this;
	empListDisplay(this);
	chatListHidden();
})

// 채팅 리스트 버튼 클릭 후 채팅 리스트 가져오기
$(".chatting-list-btn").click(function() {
	target = this;
	const type = $("#searchType");
	type.val("engagement").prop("selected", true);

	empListHidden();
	chatListDisplay(target);

	fn_roomListByType(type.val());

})

/* 방 (유형별) 출력 */
const fn_roomListByType = (type) => {
	console.log("방 타입 정보 : " + type);
	empListHidden();
	chatListDisplay();

	fetch("/messenger/roomlist/" + type + "/" + loginId)
		.then(response => {
			if (response != 200)
				console.log(response.ok);
			console.log(response.status);
			return response.json();
		})
		.then(data => {
			console.log(data);
			/*const $content = $(".chatting-list");*/
			const $content = $(".content");
			$content.attr("id");
			$content.html("");
			if (data != null) {
				data.roomList.forEach(d => {
					const $div = $("<div>").addClass("row");
					const $div_type = $("<div>").addClass("col-2 chatting-room").css("display", "flex").css("justify-content", "center").css("align-items", "center");
					const $div_title = $("<div>").addClass("col-7 chatting-room").css("text-align", "left");
					const $div_btn = $("<div>").addClass("col-2 chatting-room").css("padding-top", "12px");
					const $strong_type = $("<strong>");
					const $strong_title = $("<strong>").css("padding-right", "3px");
					/*const $recentMsg = $("<small>").text();*/
					const $updateMsg = $("<span>").addClass("updateMsg-" + d.roomNo);
					const $i = $("<div>").addClass("col-1 chatting-room");
					const $room_enter = $("<button>").addClass("enter-room btn btn-outline-primary").text("입장");
					const $user_count = $("<span>");
					$room_enter.attr("onclick", "enter_room('" + d.roomNo + "','" + d.roomPasswordFlag + "');").attr("id", "btn-" + d.roomNo);

					if (d.roomPasswordFlag == 'Y') {
						$i.append($("<i>").addClass("fa-solid fa-lock"));
					} else {
						$i.append($("<i>").addClass("fa-solid fa-lock-open"));
					}

					if (loginId === 'COMA_1') {
						const $input = $("<input>").attr("type", "checkbox").attr("name", "deleteRoom[]").val(d.roomNo).css("margin-right", "5px");
						$input.addClass("deleteRoom");
						$div_type.append($input);
					}

					fetch("/messenger/message/" + d.roomNo)
						.then(response => {
							return response.text();
						})
						.then(data => {
							if (data != "") {
								console.log("요이땅" + data);
								$updateMsg.text("Message : " + data);
							} else {
								$updateMsg.text();
							}
						})

					$i.css("padding-top", "14px");
					$strong_type.text(d.roomTypeObj.roomTypeName);
					$strong_title.text(d.roomName);
					$div_type.append($strong_type);
					$div_title.attr("id", d.roomNo);
					$div_title.append($strong_title);
					$div_btn.append($room_enter);
					$div.append($div_type);
					$div.append($div_title);
					$user_count.text('(' + d.memberCount + ')');
					$div_title.append($user_count);
					$div_title.append($("<br>"));
					$div_title.append($updateMsg);
					$div.append($i);
					$div.append($div_btn);
					console.log($div);
					$content.append($div);
				})

			} else {
				const $div = $("div").addClass("row");
				$div.append($("div").addClass("col-12").html("<h3>참여중인 채팅방이 없습니다.</h3>"));
				content.appned($div);
			}

			data.joinRoom.forEach(r => {
				$("#btn-" + r).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
			})

		})
}

// type별 채팅방 조회
const fn_roomType = () => {
	const type = $("#searchType").val();
	fn_roomListByType(type);
}

/* 방생성 입력 창 패스워드 활성화 */
$("#roomPasswordFlag").click(function() {
	if ($("#roomPasswordFlag").is(":checked")) {
		console.log("체크");
		$(this).val("Y");
		$("#roomPassword").prop("disabled", false);
		$("#roomPassword").focus();
	} else {
		$("#roomPassword").prop("disabled", true);
		$(this).val("N");
	}
	console.log($(this).val());
})



const passwordCheck = () => {
	const roomNo = $("#check-roomNo").val();
	const password = $("#passwordCode").val();
	const info = {
		"roomNo": roomNo,
		"password": password
	}
	console.log(roomNo);
	console.log(password);
	fetch("/messenger/passwordCheck", {
		method: "post",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(info)
	})
		.then(response => {
			console.log(response);
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
			console.log(data);
			if (data.flag) {
				$("#passwordCode").val("");
				enter_chattingRoom(data.room.roomNo);
				$("#passwordScreen").modal('hide');
			} else {
				alert("비밀번호가 틀립니다.");
				$("#passwordCode").val("");
			}
		})
}

$(document).ready(function() {
	$("#passwordCode").on("keyup", (e) => {
		if (e.key == 'Enter') {
			passwordCheck();
		}
	})

})

/* modal창 출력 시 input태그 autofocus하는 방법 */
$(function() {
	$("#passwordScreen").on("shown.bs.modal", function() {
		$("#passwordCode").focus();
	});

});

$(document).on('change', 'input[class="deleteRoom"]', function() {
	if ($(".deleteRoom:checked").length == 0) {
		$("#delete-room").css("display", "none");
	} else {
		$("#delete-room").css("display", "block");
	}
})

$(document).on('change', 'input[class="invite_emp"]', function() {
	if ($(".invite_emp:checked").length == 0) {
		$("#invite-create").css("display", "none");
	} else {
		$("#invite-create").css("display", "block");
	}
})




const fn_deleteRoom = () => {
	let delRoom = new Array();
	let cnt = 0;
	const delCheckbox = $(".deleteRoom");
	for (i = 0; i < delCheckbox.length; i++) {
		if (delCheckbox[i].checked == true) {
			delRoom[cnt] = delCheckbox[i].value;
			cnt++;
		}
	}
	if (confirm("정말로 삭제하시겠습니까?")) {
		fetch("/messenger", {
			method: "delete",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(delRoom)
		})
			.then(response => {
				if (response.status != 200) {
					alert("접근할 수 없습니다. 관리자에게 문의하세요:");
				}
				return response.json();
			})
			.then(data => {
				if (data.result === 'success') {
					alert("삭제가 완료되었습니다.");
					$("#delete-room").css("display", "none");
					const msg = new MessageHandler("delete", loginId);
					mserver.send(msg.convert());
					$(".chatting-list-btn").click();
				} else {
					alert("삭제 실패하였습니다. 관리자에게 문의하세요:");
				}
			})

	}
	console.log(delRoom);
}
/* 방입장 전 체크 */
const enter_room = (roomNo, roomPasswordFlag) => {
	if (roomPasswordFlag == 'Y') {
		console.log("방번호 체크 : " + roomNo);
		$("#check-roomNo").val(roomNo);
		$(".enter-room").attr("data-toggle", "modal").attr("data-target", "#passwordScreen");
	} else {
		console.log(roomNo);
		enter_chattingRoom(roomNo);
	}
}

/* 채팅방 입장 */
let chattingView;
const enter_chattingRoom = (roomNo) => {
	const empId = $("#empId").val();
	const joinInfo = {
		"roomNo": roomNo,
		"empId": empId
	}
	fetch("/chatting", {
		method: "post",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(joinInfo)
	})
		.then(response => {
			if (response.status != 200) {
				alert("채팅방입장불가!");
			}
			console.log(response);
			return response.json();
		})
		.then(data => {
			//ChattingJoin 객체 전달 String roomNo, String empId
			console.log(data);
			if (data) {
				const url = "/chatting/room/" + roomNo;
				const windowName = "chattingRoom " + roomNo;
				const options = "width=600, height=600, scrollbars=yes"
				$("#btn-" + roomNo).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
				$(".chatting-list-btn").click();
				window.open(url, windowName, options);

				/*if (!chattingView || chattingView.closed) {
					const url = "/chatting/room/" + roomNo;
					const windowName = "chattingRoom " + roomNo;
					const options = "width=600, height=600, scrollbars=yes"
					$("#btn-" + roomNo).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
					chattingView = window.open(url, windowName, options);
				}else{
					chattingView.focus();
				}*/

			}
		});
}


/* 공부하기 */
window.updateMsg = function(roomNo, content) {
	console.log("이걸볼건데?" + roomNo, content);
	const msg = new MessageHandler("msg", "", "", roomNo, content);
	mserver.send(msg.convert());
}

const messageUpdate = (msg) => {
	/*	$("button#btn-"+msg.roomNo).click(function(){
		})*/
	/* 뱃지 제거 테스트 코드 */
	/*	$("chattingList #"+msg.roomNo+"span:last-child").remove();*/
	console.log(msg);
	$(".updateMsg-" + msg.roomNo).remove();
	const $updateMsg = $("<span>").addClass("updateMsg-" + msg.roomNo);
	/*<span class="badge badge-fill badge-circle badge-floating badge-danger border-white">4</span>*/
	/*const $alarm = $("<span>").addClass("badge badge-fill badge-circle badge-floating badge-danger border-white");
	$alarm.text(0);*/
	$updateMsg.text("Message : " + msg.msg);
	$("#chattingList #" + msg.roomNo).append($updateMsg);
	/*$("#chattingList #"+msg.roomNo).append($alarm);*/

}


window.connectUpdate = function() {
	console.log("닫혔다아아아!!!");

}

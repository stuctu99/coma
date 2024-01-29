/* 메신저 서버 */
const mserver = new WebSocket("ws://" + location.host + path + "/messengerServer");

/* 서버 접속 */
mserver.onopen = () => {
	if(mserver.readyState===WebSocket.OPEN){
		fetch(path + "/messenger/init/" + loginId)
		.then(response => {
			if (response.status != 200) {
				alert("관리자에게 문의하세요.");
			}
			return response.json();
		})
		.then(data => {
			data.proom.forEach(d => {
				$("." + d.target).attr("onclick", "enter_chattingRoom('" + d.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary p-" + d.roomNo).text("대화중");
			})
		})
		const msg = new MessageHandler("exec", loginId);
		mserver.send(msg.convert());
	}
}

/* 서버 종료 */
mserver.close = () => {
	const msg = new Message("close", loginId);
	server.send(msg.convert());
}

/* 메신저 서버 메세지 처리 */
mserver.onmessage = (response) => {
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
			//1:1 채팅 실행 시
			privateNewRoom(respMsg);
			break;
		case "delete":
			//채팅방 삭제
			delRoom(respMsg);
			break;
		case "msg":
			//채팅방 메세지 로드
			messageUpdate(respMsg);
			break;
		case "invite":
			//채팅방 초대
			setTimeout(()=>{
				inviteAlarm(respMsg);				
			},1000);
			break;

	}
}

/* 메신저 이벤트 메세지 구현체 */
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

function delRoom(data) {
	const delRoom = data.roomNo;
	const nowPage = $("#my-status").val();
	$("#" + delRoom).parent().remove();
	$("."+nowPage).click();
}

window.fn_exitDelRoom = (roomNo, empId) => {
	$("#" + roomNo).parent().remove();
}

/* 메신저 실행 시 함수 */
function openEvent(data) {
	const loginId = data.loginId;
	/*fetch(path + "/messenger/init/" + loginId)
		.then(response => {
			if (response.status != 200) {
				alert("관리자에게 문의하세요.");
			}
			return response.json();
		})
		.then(data => {
			data.proom.forEach(d => {
				$("." + d.target).attr("onclick", "enter_chattingRoom('" + d.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary p-" + d.roomNo).text("대화중");
			})
		})*/

}

/* 새로운 방 생성 시 */
function newRoom(data) {
	//type = "", loginId = "", targetId = "", roomNo = "", msg = ""
	//방 생성 모달 초기화
	initModal();
	chatRoomContainer(data);
}

function chatRoomContainer(data) {
	const $container = $("#chattingList");
	fetch(path + "/messenger/room/" + data.roomNo)
		.then(resp => {
			if (resp.status != 200) {
				alert("관리자에게 문의하세요.");
			}
			return resp.json();
		})
		.then(d => {
			const $div = $("<div>").addClass("row");
			const $div_type = $("<div>").addClass("col-2 chatting-room").css("display", "flex").css("justify-content", "center").css("align-items", "center");
			const $div_title = $("<div>").addClass("col-7 chatting-room").css("text-align", "left");
			const $div_btn = $("<div>").addClass("col-2 chatting-room").css("padding-top", "12px");
			const $strong_type = $("<strong>");
			const $strong_title = $("<strong>").css("padding-right", "3px");
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

			$i.css("padding-top", "18px");
			$strong_type.text(d.roomTypeObj.roomTypeName);
			$strong_title.text(d.roomName);
			$div_type.append($strong_type);
			$div_title.attr("id", d.roomNo);
			$div_title.append($strong_title);
			$div_btn.append($room_enter);
			$div.append($div_type);
			$div.append($div_title);
			$user_count.text('[NEW] ').css("color", "red").css("font-weight", "bolder");
			$div_title.prepend($user_count);
			$div_title.append($("<br>"));
			$div_title.append($updateMsg);
			$div.append($i);
			$div.append($div_btn);
			$container.prepend($div);
		})


}


/* 1:1 채팅 이벤트 */
function privateNewRoom(data) {
	/*chatRoomContainer(data);*/
	$("." + data.targetId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary p-" + data.roomNo).text("대화중");
	$("." + data.loginId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary p-" + data.roomNo).text("대화중");
	/* 1:1대화방 동적 생성 */
	chatRoomContainer(data);
}
/*=============================================================================*/

/* 방생성 시 입력 체크 */
const createRoomCheck = (empId) => {
	const createTitle = $("#roomName");
	const passwordFlag = $("#roomPasswordFlag");
	const password = $("#roomPassword");
	let inviteEmp = new Array();
	let cnt = 0;
	const inviteCheckbox = $(".invite_emp");
	for (i = 0; i < inviteCheckbox.length; i++) {
		if (inviteCheckbox[i].checked == true) {
			inviteEmp[cnt] = inviteCheckbox[i].value;
			cnt++;
		}
	}


	if (createTitle.val().length > 0) {
		if (passwordFlag.val() == 'Y') {
			if (password.val().length > 0) {
				if (inviteEmp.length > 0) {
					createRoom(empId);
				} else {
					alert("초대할 사원을 선택하세요.");
				}
			} else {
				alert("패스워드를 입력하세요.")
			}
		} else {
			if (inviteEmp.length > 0) {
				createRoom(empId);
			} else {
				alert("초대할 사원을 선택하세요.");
			}
		}

	} else {
		alert("방 제목을 입력하세요.");
	}
}

/* 모달 초기화 */
function initModal() {
	const roomName = $("#roomName");
	const roomPassword = $("#roomPassword");
	const roomPasswordFlag = $("#roomPasswordFlag");
	const roomType = $("#roomType");
	const inviteCheckbox = $(".invite_emp");

	roomName.val("");
	roomPassword.val("");
	roomPasswordFlag.val("N");
	roomType.val("").val("A").prop("selected", true);
	inviteCheckbox.prop("checked", false);
}


/* 방생성 */
const createRoom = (empId) => {
	/* 방 생성 입력 정보 (모달) */
	const roomName = $("#roomName").val();
	const roomPassword = $("#roomPassword").val();
	const roomPasswordFlag = $("#roomPasswordFlag").val();
	const roomType = $("#roomType").val();

	/* 방생성 창 초대 인원 */
	let inviteEmp = new Array();
	let cnt = 0;
	const inviteCheckbox = $(".invite_emp");
	for (i = 0; i < inviteCheckbox.length; i++) {
		if (inviteCheckbox[i].checked == true) {
			inviteEmp[cnt] = inviteCheckbox[i].value;
			cnt++;
		}
	}

	/* 생성 방 정보 객체화 */
	const ChattingRoom = {
		"roomName": roomName,
		"roomPassword": roomPassword,
		"roomType": roomType,
		"roomPasswordFlag": roomPasswordFlag,
		"empId": empId,
		"targetId": ""
	}


	fetch(path + "/messenger/createRoom", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(ChattingRoom)
	})
		.then(response => {
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
			if (data.result == "success") {
				$("#createRoom").modal('hide');
				initModal();
				/* 초대 멤버가 존재할 때 실행 */

				if (inviteEmp.length > 0) {
					ChattingRoom.inviteEmp = inviteEmp;
					fetch(path + "/messenger/update/" + data.roomNo, {
						method: "PUT",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(ChattingRoom)
					})
						.then(response => {
							if (response.status != 200) {
								alert("접근할 수 없습니다. 관리자에게 문의하세요:");
							}
							return response.json();
						})
						.then(resp => {
							if (resp.result == "success") {
								/*(roomNo, sendName, targetId)*/
								inviteEmp.forEach(targetId => {
									fn_invite(data.roomNo, loginName, targetId);
								})
								if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
									initModal();
									enter_chattingRoom(data.roomNo);
								}
							} else {
								alert("관리자에게 문의하세요:");
							}
						})
				} else {
					if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
						initModal();
						enter_chattingRoom(data.roomNo);
					}
					/*const msg = new MessageHandler("new", empId, "", data.roomNo, "NEW");
					mserver.send(msg.convert());*/
				}
			} else {
				console.log("방생성 실패");
			}
		})



}

/* 1:1 채팅 */
const privateChatting = (targetId, targetName, empId, empName) => {
	const nowPage = $("#my-status").val();
	const privateChat = {
		"roomName": targetName + ", " + empName + " 대화방",
		"roomType": "P",
		"roomPassword": "",
		"roomPasswordFlag": "N",
		"empId": loginId,
		"targetId": targetId
	}
	fetch(path + "/messenger/createRoom", {
		method: "POST",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(privateChat)
	})
		.then(response => {
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
			if (data.result == "success") {
				fn_invite(data.roomNo, loginName, targetId);
				enterAlarm(data.roomNo);
				/*if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
					initModal();
					enter_chattingRoom(data.roomNo);
					const msg = new MessageHandler("privateNew", empId, targetId, data.roomNo, "");
					mserver.send(msg.convert());
				} else {
					newRoom();
					$("." + targetId).attr("onclick", "enter_chattingRoom('" + data.roomNo + "');").removeClass("btn-outline-primary").addClass("btn-primary p-" + data.roomNo).text("대화중");
				}*/
				const msg = new MessageHandler("privateNew", empId, targetId, data.roomNo, "");
				mserver.send(msg.convert());
				
				
			} else {
				console.log("방생성 실패");
			}
		})
}

// 사원 리스트 뷰 출력
const empListDisplay = (target) => {
	$(target).css("backgroundColor", "white").css("opacity", 0.9);
	$(target).children().css("width", "45px").css("height", "45px");
	$(".chatting-list-btn").css("backgroundColor", "#edebf0").css("cursor", "pointer").css("opacity", 1.0);
	$(".chatting-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "block");
}

// 채팅방 리스트 버튼 클릭 시 사원리스트 숨기기
const empListHidden = () => {
	$(this).css("backgroundColor", "white").css("opacity", 0.9);
	$(this).children().css("width", "45px").css("height", "45px");
	$(".emp-list-btn").css("backgroundColor", "#edebf0").css("cursor", "pointer").css("opacity", 1.0);
	$(".emp-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "none");
}
// 채팅방 리스트 버튼 클릭 시 채팅방 리스트 뷰 출력
const chatListDisplay = (target) => {
	$(target).css("backgroundColor", "white").css("opacity", 0.9);
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
	location.reload();
	$("#my-status").val("emp-list-btn");
	target = this;
	empListDisplay(this);
	chatListHidden();
})

// 채팅 리스트 버튼 클릭 후 채팅 리스트 가져오기
$(".chatting-list-btn").click(function() {
	$("#my-status").val("chatting-list-btn");
	target = this;
	empListHidden();
	chatListDisplay(target);

	fn_roomList();

})

/* 방 (유형별) 출력 */
const fn_roomList = () => {
	empListHidden();
	chatListDisplay();

	fetch(path + "/messenger/roomlist/" + loginId)
		.then(response => {
			if (response != 200) {

			}
			return response.json();
		})
		.then(data => {
			const $content = $(".content");
			$content.attr("id");
			$content.html("");
			if (data != null || data != '') {
				data.roomList.forEach(d => {
					const $div = $("<div>").addClass("row");
					const $div_type = $("<div>").addClass("col-2 chatting-room").css("display", "flex").css("justify-content", "center").css("align-items", "center");
					const $div_title = $("<div>").addClass("col-7 chatting-room").css("text-align", "left");
					const $div_btn = $("<div>").addClass("col-2 chatting-room").css("padding-top", "12px");
					const $strong_type = $("<strong>");
					const $strong_title = $("<strong>").css("padding-right", "3px").addClass("room-title");
					const $updateMsg = $("<span>").addClass("updateMsg updateMsg-" + d.roomNo);
					const $i = $("<div>").addClass("col-1 chatting-room");
					const $room_enter = $("<button>").addClass("enter-room btn btn-outline-primary").text("입장");
					const $user_count = $("<span>");
					$room_enter.attr("onclick", "enter_room('" + d.roomNo + "','" + d.roomPasswordFlag + "');").attr("id", "btn-" + d.roomNo);

					if (d.roomPasswordFlag == 'Y') {
						$i.append($("<i>").addClass("fa-solid fa-lock"));
					} else {
						$i.append($("<i>").addClass("fa-solid fa-lock-open"));
					}

					//권한이 관리자(J1)인 사원만 삭제기능을 가질 수 있다.
					if (autority == 'J1') {
						const $input = $("<input>").attr("type", "checkbox").attr("name", "deleteRoom[]").val(d.roomNo).css("margin-right", "5px");
						$input.addClass("deleteRoom");
						$div_type.append($input);
					}


					fetch(path + "/messenger/message/" + d.roomNo)
						.then(response => {
							return response.text();
						})
						.then(data => {
							if (d.roomPasswordFlag == 'N') {
								if (data != "") {
									$updateMsg.text(" " + data);
								}else{
									$updateMsg.text("NEW").css("color","red").css("font-weight","bold");
								}
							}
							else {
								$div_title.css("line-height", 3.0);
							}
						})

					$i.css("padding-top", "18px");
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
					$content.append($div);
				})

			} else {
				const $div = $("div").addClass("row");
				$div.append($("div").addClass("col-12").html("<h3>참여중인 채팅방이 없습니다.</h3>"));
				content.appned($div);
			}

			data.joinRoom.forEach(param => {
				$("#btn-" + param.roomNo).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
			})

		})
}


/* type별 채팅방 조회 */
const fn_roomType = () => {
	fn_roomList();
}

/* 방생성 입력 창 패스워드 활성화 */
$("#roomPasswordFlag").click(function() {
	if ($("#roomPasswordFlag").is(":checked")) {
		$(this).val("Y");
		$("#roomPassword").prop("disabled", false);
		$("#roomPassword").focus();
	} else {
		$("#roomPassword").prop("disabled", true);
		$(this).val("N");
	}
})


/* 패스워드 확인 로직 */
const passwordCheck = () => {
	const roomNo = $("#check-roomNo").val();
	const password = $("#passwordCode").val();
	const info = {
		"roomNo": roomNo,
		"password": password
	}
	fetch(path + "/messenger/passwordCheck", {
		method: "post",
		headers: {
			"Content-Type": "application/json"
		},
		body: JSON.stringify(info)
	})
		.then(response => {
			if (response.status != 200) {
				alert("잘못된접근");
			}

			return response.json();
		})
		.then(data => {
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

$("#passwordReset").click(function(){
	$("input#passwordCode").val("");
})

/* modal창 출력 시 input태그 autofocus하는 방법 */
$(function() {
	$("#passwordScreen").on("shown.bs.modal", function() {
		$("#passwordCode").focus();
	});

});

/* 동적 생성한 input type=checkbox에 change 이벤트 할당 */
$(document).on('change', 'input[class="deleteRoom"]', function() {
	if ($(".deleteRoom:checked").length == 0) {
		//체크박스 체크 갯수가 1개 이상 시 삭제버튼 출력
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



/* 방 삭제 함수 */
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
		fetch(path + "/messenger", {
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
					delRoom.forEach(r => {
						const msg = new MessageHandler("delete", loginId, "", r, "");
						mserver.send(msg.convert());
						

					})
					window.close;
				} else {
					alert("삭제 실패하였습니다. 관리자에게 문의하세요:");
				}
			})

	}
}
/* 방입장 전 체크 */
const enter_room = (roomNo, roomPasswordFlag) => {
	if (roomPasswordFlag == 'Y') {
		$("#check-roomNo").val(roomNo);
		$(".enter-room").attr("data-toggle", "modal").attr("data-target", "#passwordScreen");
	} else {
		enter_chattingRoom(roomNo);
	}
}

/* 채팅방 입장 */
let chattingView;
const enter_chattingRoom = (roomNo) => {
	const nowPage = $("#my-status").val();
	const empId = $("#empId").val();
	const joinInfo = {
		"roomNo": roomNo,
		"empId": empId
	}
	fetch(path + "/chatting", {
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
			return response.json();
		})
		.then(data => {
			//ChattingJoin 객체 전달 String roomNo, String empId
			if (data) {
				const url = path + "/chatting/room/" + roomNo;
				const windowName = "chattingRoom " + roomNo;
				const options = "width=600, height=700, scrollbars=yes"
				$("#btn-" + roomNo).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
				$("." + nowPage).click();
				chattingView = window.open(url, windowName, options);
				$("div#" + roomNo + ">span").remove();
				/*location.reload();*/
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


/* 채팅화면 방 설정에서 사원 초대 시 */
window.fn_invite = function(roomNo, sendName, targetId) {
	const msg = new MessageHandler("invite", targetId, sendName, roomNo, "");
	mserver.send(msg.convert());
}

function enterAlarm(roomNo){
	const $modal_body = $("#invite-alarm-body");
	const $div = $("<div>").addClass("roomTitle");
	const $row = $("<div>").addClass("row");
	const $col_12 = $("<div>").addClass("col-12");
	const $alarmMsg = $("<h4>").attr("id", "invite-alarm-msg");
	const $enterRoom_btn = $("#enterRoom-btn");
	$modal_body.html("");
	$enterRoom_btn.attr("onclick", "enter_chattingRoom('" + roomNo + "');");
	$alarmMsg.text("바로 입장 하시겠습니까?");
	$col_12.append($alarmMsg);
	$row.append($col_12);
	$div.append($row);
	$modal_body.append($div);
	$("#invite-alarm").modal();
	chatRoomContainer(data);
}


/* 초대 받은 인원에게 알림창 출력 */
function inviteAlarm(data) {
	const $modal_body = $("#invite-alarm-body");
	const $div = $("<div>").addClass("roomTitle");
	const $row = $("<div>").addClass("row");
	const $col_12 = $("<div>").addClass("col-12");
	const $alarmMsg = $("<h4>").attr("id", "invite-alarm-msg");
	const $enterRoom_btn = $("#enterRoom-btn");
	$modal_body.html("");
	$enterRoom_btn.attr("onclick", "enter_chattingRoom('" + data.roomNo + "');");
	$alarmMsg.text(data.targetId + "님이 초대하셨습니다. 바로 입장하시겠습니까?");
	$col_12.append($alarmMsg);
	$row.append($col_12);
	$div.append($row);
	$modal_body.append($div);
	$("#invite-alarm").modal();
	chatRoomContainer(data);

}

/* 초대 메세지에서 입장 클릭 시 모달 숨김 */
$("#enterRoom-btn").click(function() {
	$("#invite-alarm").modal('hide');
})

const pageLoad = () => {
	const nowPage = $("#my-status").val();
	$("."+nowPage).click();
}



/* 공부하기, 채팅방에서 작성한 채팅 메세지 채팅창에 실시간 출력 */
window.updateMsg = function(roomNo, content) {
	fetch(path + "/messenger/room/" + roomNo)
		.then(response => {
			if (response.status != 200) {
				alert("메세지 조회 과정에서 에러가 발생하였습니다. 관리자에게 문의하세요.");
			}
			return response.json();
		})
		.then(data => {
			if (data.roomPasswordFlag == 'N') {
				const msg = new MessageHandler("msg", "", "", roomNo, content);
				mserver.send(msg.convert());
			}

		})
}

/* updateMsg 실행 후 서버에서 접속 세션에 메세지 동기화 */
const messageUpdate = (msg) => {
	const room = $("#"+msg.roomNo).parent();
	$("#chattingList").prepend(room.clone());	
	room.remove();
	$(".updateMsg-" + msg.roomNo).remove();
	const $updateMsg = $("<span>").addClass("updateMsg updateMsg-" + msg.roomNo);
	$updateMsg.text(" " + msg.msg);
	$("#chattingList #" + msg.roomNo).append($updateMsg);
}
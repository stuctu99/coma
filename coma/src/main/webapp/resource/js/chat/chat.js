/*const contextPath=location.hostname;*/

$(".emp-list-btn").click(function() {
	target = this;
	empListDisplay(this);
	chatListHidden();
})

const empListDisplay = (target) => {
	console.log(target);
	$(target).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(target).children().css("width", "45px").css("height", "45px");
	$(".chatting-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".chatting-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "block");
}

const empListHidden = () => {
	$(this).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(this).children().css("width", "45px").css("height", "45px");
	$(".emp-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".emp-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "none");
}

const chatListDisplay = (target) => {
	$(target).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(target).children().css("width", "45px").css("height", "45px");
	$(".chatting-list").css("display", "block");
	$("#create-room").css("display", "block");
}

const chatListHidden = () => {
	$(".chatting-list").css("display", "none");
	$("#create-room").css("display", "none");
}

$(".chatting-list-btn").click(function() {
	target = this;
	const type = $("#searchType");
	type.val("ALL").prop("selected", true);

	empListHidden();
	chatListDisplay(target);

	fn_roomListByType(type.val());
})

const fn_roomType = () => {
	const type = $("#searchType").val();
	fn_roomListByType(type);
}


/* 방 유형별 출력 */
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
			$content.html("");
			if (data != null) {
				data.roomList.forEach(d => {
					const $div = $("<div>").addClass("row");
					const $div_type = $("<div>").addClass("col-2 chatting-room").css("display", "flex").css("justify-content", "center").css("align-items", "center");
					const $div_title = $("<div>").addClass("col-7 chatting-room").css("text-align", "left");
					const $div_btn = $("<div>").addClass("col-2 chatting-room").css("padding-top", "12px");
					const $strong_type = $("<strong>");
					const $strong_title = $("<strong>").css("padding-right", "3px");
					/*const $recentMsg = $("<div>").addClass("col-3 chatting-room");*/
					const $recentMsg = $("<small>").text();
					const $i = $("<div>").addClass("col-1 chatting-room");
					const $room_enter = $("<button>").addClass("enter-room btn btn-outline-primary").text("입장");
					/*const $img = $("<img>").attr("src","/resource/img/chat/user.png").attr("id","joinList");*/
					const $user_count = $("<span>");
					$room_enter.attr("onclick", "enter_room('" + d.roomNo + "','" + d.roomPasswordFlag + "');").attr("id", d.roomNo);

					if (d.roomPasswordFlag == 'Y') {
						$i.append($("<i>").addClass("fa-solid fa-lock"));
					} else {
						$i.append($("<i>").addClass("fa-solid fa-lock-open"));
					}

					$i.css("padding-top", "14px");

					$strong_type.text(d.roomTypeObj.roomTypeName);
					$strong_title.text(d.roomName);
					if (loginId === 'COMA_1') {
						const $input = $("<input>").attr("type", "checkbox").attr("name", "deleteRoom[]").val(d.roomNo).css("margin-right", "5px");
						$input.addClass("deleteRoom");
						$div_type.append($input);
					}
					$div_type.append($strong_type);
					$div_title.append($strong_title);
					/*$div_title.append($i);*/
					$div_btn.append($room_enter);
					/*$div_btn.append($input);*/
					$div.append($div_type);
					$div.append($div_title);
					$user_count.text('(' + d.memberCount + ')');
					$div_title.append($user_count);
					$div_title.append($("<br>"));
					$div_title.append($recentMsg);
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
				$("#" + r).text("참여중").removeClass('btn-outline-primary').addClass('btn-primary');
			})

		})
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
/* 1:1 채팅 */
/*const privateChatting = (targetId) => {
	console.log(targetId);
	const privateChat = {
		"roomName": targetId,
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
				messengerAction("create");
				console.log("방생성 성공");
				$("#createRoom").modal('hide');
				if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
					enter_chattingRoom(data.roomNo);
				} else {
					location.href = "/messenger";
				}
			} else {
				console.log("방생성 실패");
			}
		})
}*/

/* 방생성 */
const createRoom = (empId) => {
	console.log($(".deleteCheckbox").val());
	const roomName = $("#roomName").val();
	const roomPassword = $("#roomPassword").val();
	const roomPasswordFlag = $("#roomPasswordFlag").val();
	const roomType = $("#roomType").val();
	console.log("방생성 ID : " + empId);
	console.log(roomPasswordFlag);
	const ChattingRoom = {
		"roomName": roomName,
		"roomPassword": roomPassword,
		"roomType": roomType,
		"roomPasswordFlag": roomPasswordFlag,
		"empId": empId
	}
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
				messengerAction("create");
				console.log("방생성 성공");
				$("#exampleModal").modal('hide');
				if (confirm("채팅방으로 바로 입장하시겠습니까?")) {
					enter_chattingRoom(data.roomNo);
				} else {
					location.href = "/messenger";
				}
			} else {
				console.log("방생성 실패");
			}
		})

}

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
	$(".deleteCheckbox").change(function() {
		alert("제발!!!");
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
				/*location.href="/chatting/room/"+roomNo;*/
				open("/chatting/room/" + roomNo, "_blank", "width=600px; height=600px;");
			}
		})
}
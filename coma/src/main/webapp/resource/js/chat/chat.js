/*const contextPath=location.hostname;*/
/*$(".menu").hover(function(){
	$(this).css("backgroundColor","#edebf0").css("cursor","pointer").css("opacity",0.9);
	$(this).children().css("width","45px").css("height","45px");
	},function(){
	$(this).css("backgroundColor","white").css("cursor","pointer").css("opacity",1.0);
	$(this).children().css("width","40px").css("height","40px");
});
*/
$(".emp-list-btn").click(function() {
	$(this).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(this).children().css("width", "45px").css("height", "45px");
	$(".chatting-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".chatting-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "block");
	$(".chatting-list").css("display", "none");
	$("#create-room").css("display", "none");
})
/*	< div class="row" >
		<div class="col-12">
			<h4>채팅 리스트</h4>
		</div>
			</div >
	<div class="row">
		<div class="col-12 chatting-room">
			<strong>임원진</strong>
		</div>
	</div>*/
	
$(".chatting-list-btn").click(function() {
	$(this).css("backgroundColor", "#edebf0").css("opacity", 0.9);
	$(this).children().css("width", "45px").css("height", "45px");
	$(".emp-list-btn").css("backgroundColor", "white").css("cursor", "pointer").css("opacity", 1.0);
	$(".emp-list-btn").children().css("width", "40px").css("height", "40px");
	$(".emp-list").css("display", "none");
	$(".chatting-list").css("display", "block");
	$("#create-room").css("display", "block");
	fetch("/messenger/roomlist")
	.then(response=>{
		if(!response.ok) throw new error("불러오기 실패!!");
		console.log(response.ok);
		console.log(response.status);
		return response.json();
	})
	.then(data=>{
		console.log(data);
			/*const $content = $(".chatting-list");*/
			const $content = $(".content");
			$content.html("");
		data.forEach(d=>{
			const $div = $("<div>").addClass("row");
			const $div_type = $("<div>").addClass("col-2 chatting-room");
			const $div_title = $("<div>").addClass("col-7 chatting-room").css("text-align","left");
			const $div_btn = $("<div>").addClass("col-2 chatting-room").css("padding-top","2px");
			const $input = $("<input>").attr("name","roomNo").attr("type","hidden").val(d.roomNo);
			const $strong_type = $("<strong>");
			const $strong_title = $("<strong>").css("padding-right","3px");
			/*const $recentMsg = $("<div>").addClass("col-3 chatting-room");*/
			const $recentMsg = $("<small>").text("테스트");
			const $i = $("<div>").addClass("col-1 chatting-room");
			const $room_enter = $("<button>").addClass("enter-room btn btn-outline-primary").text("입장");
			if(d.roomPasswordFlag=='Y'){
				$room_enter.attr("data-toggle","modal").attr("data-target","#passwordScreen");
				$("#check-roomNo").val(d.roomNo);
			}else{
				$room_enter.attr("onclick","enter_room('"+d.roomNo+"');");
			}
			
			if(d.roomPasswordFlag=='Y'){
				 $i.append($("<i>").addClass("fa-solid fa-lock"));
			}else{
				$i.append($("<i>").addClass("fa-solid fa-lock-open"));
			}
		/*	console.log(d.roomType.roomTypeName);
			switch(d.roomType.roomTypeName){
				case 'A' : $strong_type.text('공용'); break;
				case 'D1' : $strong_type.text('관리부'); break;
				case 'D2' : $strong_type.text('행정부'); break;
				case 'D3' : $strong_type.text('회계부'); break;
				case 'D4' : $strong_type.text('교육부'); break;
				case 'D5' : $strong_type.text('취업부'); break;
				
			}*/
			
			$strong_type.text(d.roomType.roomTypeName);
			$strong_title.text(d.roomName);
			$div_type.append($strong_type);
			$div_title.append($strong_title);
			/*$div_title.append($i);*/
			$div_btn.append($room_enter);
			/*$div_btn.append($input);*/
			$div.append($div_type);
			$div.append($div_title);
			$div_title.append($("<br>"));
			$div_title.append($recentMsg);
			$div.append($i);
			$div.append($div_btn);
			console.log($div);
			$content.append($div);		
		})

	})
})

/* 방생성 입력 창 패스워드 활성화 */

$("roomPasswordFlag").click(function() {
	console.log(this);
	if ($("#roomPasswordFlag").is(":checked")) {
		console.log("체크");
		$("#roomPassword").prop("disabled", false);
		$("#roomPassword").focus();
	} else {
		$("#roomPassword").prop("disabled", true);
	}
})

/* 방생성 */
const createRoom = () => {
	console.log("active");
}
/*
const passwordCheck = () =>{
	const roomNo = $("#check-roomNo").val();
	const password = $("#passwordCode").val();
	const info = {
		"roomNo" : roomNo,
		"password" : password
	}
	
	console.log(password);
	fetch("/messenger/passwordCheck",{
		method : "post",
		header : {
			"Content-Type" : "application/json",
		},
		body : JSON.stringify(info)
	})
	.then(response=>{
		if(response.status!=200){
			alert("잘못된접근");
		}
		
		return response.json();
	})
	.then(data=>{
		if(!data){
			alert("비밀번호가 틀립니다.");
		}else{
			enter_room(roomNo);
		}
	})
}
*/

/* 방입장 */
const enter_room = (roomNo) => {
	const pathValue = $("#pathValue").val();
	console.log(roomNo);
	/*location.href=pathValue+"/messenger/room/";*/
}




/* 웹소켓 채팅 */
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

btnLogin.onclick = function() {
	server = new WebSocket("ws://" + location.host + "/chatting");

	server.onmessage = function(msg) {
		var data = JSON.parse(msg.data);
		var css;

		console.log(data);

		if (data.mid == mid.value) {
			css = 'class=me';
		} else {
			css = 'class=other';
		}

		var item = `<div ${css} >
		                <span><b>${data.mid}</b></span> [ ${data.date} ]<br/>
                      <span>${data.msg}</span>
						</div>`;

		talk.innerHTML += item;
		talk.scrollTop = talk.scrollHeight;//스크롤바 하단으로 이동
	}
}

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
		data.mid = getId('mid').value;
		data.msg = msg.value;
		data.date = new Date().toLocaleString();
		var temp = JSON.stringify(data);
		server.send(temp);
	}
	msg.value = '';

}
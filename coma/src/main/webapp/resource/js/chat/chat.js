/*$(".menu").hover(function(){
	$(this).css("backgroundColor","#edebf0").css("cursor","pointer").css("opacity",0.9);
	$(this).children().css("width","45px").css("height","45px");
	},function(){
	$(this).css("backgroundColor","white").css("cursor","pointer").css("opacity",1.0);
	$(this).children().css("width","40px").css("height","40px");
});
*/
$(".emp-list-btn").click(function(){
	$(this).css("backgroundColor","#edebf0").css("cursor","pointer").css("opacity",0.9);
	$(this).children().css("width","45px").css("height","45px");
	$(".chatting-list-btn").css("backgroundColor","white").css("cursor","pointer").css("opacity",1.0);
	$(".chatting-list-btn").children().css("width","40px").css("height","40px");
	$(".emp-list").css("display","block");
	$(".chatting-list").css("display","none");
	$("#create-room").css("display","none");
})

$(".chatting-list-btn").click(function(){
	$(this).css("backgroundColor","#edebf0").css("cursor","pointer").css("opacity",0.9);
	$(this).children().css("width","45px").css("height","45px");
	$(".emp-list-btn").css("backgroundColor","white").css("cursor","pointer").css("opacity",1.0);
	$(".emp-list-btn").children().css("width","40px").css("height","40px");
	$(".emp-list").css("display","none");
	$(".chatting-list").css("display","block");
	$("#create-room").css("display","block");
})

/* 방생성 입력 창 패스워드 활성화 */

$("#passwordFlag").click(function(){
	console.log(this);
	if($("#passwordFlag").is(":checked")){
		console.log("체크");
		$("#password").prop("disabled",false);
		$("#password").focus();
	}else{
		$("#password").prop("disabled",true);
	}
})

/* 방생성 */
const createRoom = () =>{
	console.log("active");
}



/* 웹소켓 채팅 */
function getId(id){
	return document.getElementById(id);
}

var data = {};//전송 데이터(JSON)

var server ;
var mid = getId('mid');
var btnLogin = getId('btnLogin');
var btnSend = getId('btnSend');
var talk = getId('contents');
var msg = getId('msg');

btnLogin.onclick = function(){
	server = new WebSocket("ws://" + location.host + "/chat");
	
	server.onmessage = function(msg){
		var data = JSON.parse(msg.data);
		var css;
	
		console.log(data);
		
		if(data.mid == mid.value){
			css = 'class=me';
		}else{
			css = 'class=other';
		}
		
		var item = `<div ${css} >
		                <span><b>${data.mid}</b></span> [ ${data.date} ]<br/>
                      <span>${data.msg}</span>
						</div>`;
					
		talk.innerHTML += item;
		talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
	}
}

msg.onkeyup = function(ev){
	if(ev.keyCode == 13){
		send();
	}
}

btnSend.onclick = function(){
	send();
}

function send(){
	if(msg.value.trim() != ''){
		data.mid = getId('mid').value;
		data.msg = msg.value;
		data.date = new Date().toLocaleString();
		var temp = JSON.stringify(data);
		server.send(temp);
	}
	msg.value ='';
	
}
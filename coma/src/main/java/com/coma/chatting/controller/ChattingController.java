package com.coma.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chatting")
public class ChattingController {
	
	@GetMapping("/room/{roomNo}")
	public String chattingStart(@PathVariable String roomNo) {
		//채팅 방 정보 + 로그인 세션 아이디 DB저장하기
		System.out.println(roomNo);
		return "/chat/chatView";
	}
	
}

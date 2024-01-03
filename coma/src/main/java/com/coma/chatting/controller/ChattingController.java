package com.coma.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ChattingRoom")
public class ChattingController {
	
	@GetMapping("/room/{roomNo}")
	public String chattingStart(@PathVariable String roomNo) {
		System.out.println(roomNo);
		return "/chat/chatView";
	}
	
}

package com.coma.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chatting")
public class ChattingController {
	
	@GetMapping
	public String chatting(Model model) {
		
		return "chat/chat"; 
	}
	
	
}

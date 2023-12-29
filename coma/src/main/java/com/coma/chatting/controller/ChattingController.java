package com.coma.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.ChattingRoom;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chatting")
@RequiredArgsConstructor
public class ChattingController {
	private final ChattingService service;
	
	@GetMapping
	public String chatting(Model model) {
		return "chat/chat"; 
	}
	
	@PostMapping
	public String createRoom(@ModelAttribute ChattingRoom room) {
		if(room.getRoomPasswordFlag()!=null) {
			room.setRoomPasswordFlag("Y");
		}else {
			room.setRoomPasswordFlag("N");
		}
		System.out.println(room);
		int result = service.insertChattingRoom(room);
		return "chat/chat";
	}
	
	
}

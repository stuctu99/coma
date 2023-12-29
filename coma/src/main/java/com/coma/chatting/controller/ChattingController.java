package com.coma.chatting.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chatting")
@RequiredArgsConstructor
public class ChattingController {
	private final ChattingService service;
	
	@GetMapping
	public String chatting(Model model) {
		List<Emp> empList = service.selectEmpAll();
		model.addAttribute(empList);
		for(Emp e : empList) {
			System.out.println(e);
		}
		return "chat/chat"; 
	}
	
	
}

package com.coma.emp.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.coma.board.service.BoardService;
import com.coma.model.dto.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class EmployeeController {
	
	private final BoardService service;
	
//	@PostMapping("/loginsuccess")
//	public String successLogin(Principal data) {
////		log.debug("{}",data);
//		System.out.println(data);
//		return "redirect:/";
//	}
	
	@PostMapping("/loginsuccess")
	public String successLogin(Principal data) {
		log.debug("{}",data);
		System.out.println(data);
		
		
		
		return "redirect:/";
	}
	
	
	@GetMapping("/")
	public ModelAndView selectMainNotice(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "5") int numPerpage,
										@RequestParam(defaultValue="0") int boardType) {
		
		List<Board> boards = service.selectBoardByType(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
        List<Board> mainNotice = boards.stream().limit(5).collect(Collectors.toList());
		
		return new ModelAndView("index").addObject("mainNotice", mainNotice);
	}
}

package com.coma.emp.controller;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.coma.board.service.BoardService;
import com.coma.commute.service.CommuteService;
import com.coma.model.dto.Board;
import com.coma.model.dto.Commute;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class EmployeeController {
	
	private final BoardService service;
	private final CommuteService commuteService;
	
//	@PostMapping("/loginsuccess")
//	public String successLogin(Principal data) {
////		log.debug("{}",data);
//		System.out.println(data);
//		return "redirect:/";
//	}
	
	@PostMapping("/loginsuccess")
	public String successLogin(Principal data) {
		log.debug("{}",data);

		
		return "redirect:/";
	}
	
	
	@GetMapping("/")
	public ModelAndView selectMainNotice(@RequestParam(defaultValue="0") int boardType,String empId) {
		
		List<Board> boards = service.selectBoardByType(boardType);
        List<Board> mainNotice = boards.stream().limit(5).collect(Collectors.toList());
        System.out.println(empId);
        Commute myCommute = commuteService.selectCommute(empId);
        
		return new ModelAndView("index").addObject("mainNotice", mainNotice).addObject(myCommute);
	}
}

package com.coma.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.model.dto.Emp;
import com.coma.mypage.model.service.MypageService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/mypage")
@Controller
@RequiredArgsConstructor
public class MypageController {
	
	private final MypageService service;
	
	@GetMapping("/mypageDetails")
	public void test(Model m) {
	    Emp emp = service.selelctDto("COMA_1");
	    m.addAttribute("emp", emp);
	    System.out.println(emp);
	    

	}

	
}

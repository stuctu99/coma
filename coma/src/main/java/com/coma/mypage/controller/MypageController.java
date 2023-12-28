package com.coma.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/mypage")
@Controller
public class MypageController {

	
	@GetMapping("/mypageDetails")
	public void test() {}
	
}

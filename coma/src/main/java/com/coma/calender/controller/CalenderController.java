package com.coma.calender.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CalenderController {
	
	@RequestMapping("/calender")
	public String calender() {
		return "/calender/calender";
	}
}

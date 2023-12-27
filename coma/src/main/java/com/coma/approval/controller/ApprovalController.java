package com.coma.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApprovalController {

	
	@GetMapping("/approval/writedoc")
	public String test() {
		return "/approval/writedoc";
	}
	
}

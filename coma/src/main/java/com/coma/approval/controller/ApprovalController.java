package com.coma.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApprovalController {

	
	@GetMapping("/approval/writedoc")
	public String writeDoc() {
		return "/approval/writedoc";
	}
	
	@GetMapping("/approval/sign")
	public String sign() {
		return "/approval/sign";
	}
	
}

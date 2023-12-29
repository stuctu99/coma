package com.coma.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@GetMapping("/adminEmp")
	public void adminEmp() {}
	
	@GetMapping("/adminStudent")
	public void adminStudent() {}
}

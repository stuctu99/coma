package com.coma.emp.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmployeeController {

	@PostMapping("/loginsuccess")
	public String successLogin(Principal data) {
		log.debug("{}",data);

	
		return "redirect:/";
	}
}

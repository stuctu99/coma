package com.coma.student.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.student.service.StudentService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/student")
@Controller
@RequiredArgsConstructor
public class StudentController {
	private final StudentService service;
	
	@GetMapping("/student")
	public void studentMainPage() {
		
	}
}

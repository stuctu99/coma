package com.coma.student.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public void selectStudentByEmpId(Principal pri, Model m) {
		String loginId=pri.getName();
		List<Map> students=service.selectStudentByEmpId(loginId);
		m.addAttribute("students",students);
	}
	
}

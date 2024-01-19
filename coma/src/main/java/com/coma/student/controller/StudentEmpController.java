package com.coma.student.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.student.service.StudentEmpService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/student")
@Controller
@RequiredArgsConstructor
public class StudentEmpController {

	private final StudentEmpService service;
	// 경현
		@GetMapping("/studentEmp")
		public void selectStudentEmpByEmpId(Principal pri, Model m, Model m2) {
			String loginId=pri.getName();
		
			List<Map> students=service.selectStudentEmpByEmpId(loginId);
			List<Map> empCount=service.selectStudentEmpCount(loginId);
		
			m.addAttribute("students",students);
			m2.addAttribute("empCount",empCount);
		}
		@PostMapping("/insertStudentEmp")
		public String insertStudentEmp(String [] employment) {
			
			int result = service.insertStudentByEmployment(employment);
			return "redirect:/student/studentEmp";
		}
		@PostMapping("/infoStudentEmp")
		public @ResponseBody List<Map> infoStudentEmp(@RequestBody Map<String, Object> stuNo){
			List<Map> stuInfo = service.infoStudentEmp(stuNo);
			return stuInfo;
		}
}

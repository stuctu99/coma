package com.coma.student.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("/infoStudent")
	public @ResponseBody List<Map> selectStudentByInfo(@RequestBody Map<String, Object> stuNo){
		System.out.println(stuNo);
		List<Map> stuInfo=service.selectStudentByInfo(stuNo);
		return stuInfo;
	}
	
	@PostMapping("/insertStudent")
	public String insertStudentByAttend(String[] attendance) {
		int result=service.insertStudentByAttend(attendance);
		return "redirect:/student/student";
		
	}
	// 경현
	@GetMapping("/studentEmp")
	public void selectStudentEmpByEmpId(Principal pri, Model m) {
		String loginId=pri.getName();
		List<Map> students=service.selectStudentEmpByEmpId(loginId);
		m.addAttribute("students",students);
	}
	@PostMapping("/insertStudentEmp")
	public String insertStudentEmp(String [] employment) {
		System.out.println("이걸찾으시오"+Arrays.toString(employment));
		int result = service.insertStudentByEmployment(employment);
		return "redirect:/student/studentEmp";
	}
	@PostMapping("/infoStudentEmp")
	public @ResponseBody List<Map> infoStudentEmp(@RequestBody Map<String, Object> stuNo){
		List<Map> stuInfo = service.infoStudentEmp(stuNo);
		return stuInfo;
	}
}

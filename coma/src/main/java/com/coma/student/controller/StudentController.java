package com.coma.student.controller;

import java.security.Principal;
import java.time.LocalDate;
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
	
	//강사 담당 학생 전체 출력
	@GetMapping("/student")
	public void selectStudentByEmpId(Principal pri, Model m) {
		String loginId=pri.getName();
		List<Map> students=service.selectStudentByEmpId(loginId);
		m.addAttribute("students",students);
		
		LocalDate currentDate = LocalDate.now();

	}
	
	//담당 학생 정보 출력
	@PostMapping("/infoStudent")
	public @ResponseBody List<Map> selectStudentByInfo(@RequestBody Map<String, Object> stuNo){
		System.out.println(stuNo);
		List<Map> stuInfo=service.selectStudentByInfo(stuNo);
		return stuInfo;
	}
	
	//학생 출석 등록
	@PostMapping("/insertStudent")
	public String insertStudentByAttend(String[] attendance) {
		int result=service.insertStudentByAttend(attendance);
		return "redirect:/student/student";
		
	}
	
	//학생 특이사항 작성
	@PostMapping("/studentSignificant")
	public @ResponseBody int studentSignificantBystuNo(@RequestBody Map<String, Object> significantData) {
		System.out.println(significantData);
		int result=service.studentSignificantBystuNo(significantData);
		return result;
	}

	
}

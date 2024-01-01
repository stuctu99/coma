package com.coma.admin.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.admin.service.AdminService;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

import lombok.RequiredArgsConstructor;

@RequestMapping("/admin")
@RequiredArgsConstructor
@Controller
public class AdminController {
	private final AdminService service;
	
	//사원관련 컨트롤러
	@GetMapping("/adminEmp")
	public void selectEmpAll(Model m) {
		List<Emp> emps=service.selectEmpAll();
		m.addAttribute("emps",emps);
	}
	
	@GetMapping("/insertEmp")
	public String insertEmp(String userName) {
		int result=service.insertEmp(userName);
		return "/adminEmp";
	}
	
	@GetMapping("/deleteEmp")
	public String deleteEmp(String userName) {
		int result=service.deleteEmp(userName);
		return "/adminEmp";
	}
	
	@GetMapping("/searchEmp")
	public List<Emp> searchEmp(@RequestBody HashMap<String, Object> searchMap) {
		List<Emp> emps=service.searchEmp(searchMap);
		return emps;
	}
	
	//학생관련 컨트롤러
	@GetMapping("/adminStudent")
	public void adminStudent(Model m) {
		List<Student> students=service.selectStudent();
		m.addAttribute("students",students);
	}
	
	@GetMapping("/searchStudent")
	public List<Student> searchStudent(@RequestBody HashMap<String, Object> searchMap){
		List<Student> students=service.searchStudent(searchMap);
		return students;
	}

}

package com.coma.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.admin.service.AdminService;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
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
	public void searchEmp(String searchData, String textValue) {
		Map<String, Object> searchMap=new HashMap<String, Object>();
		searchMap.put("searchData", searchData);
		searchMap.put("textValue", textValue);
		List<Emp> emps=service.searchEmp(searchMap);
	}
	
	//학생관련 컨트롤러
	@GetMapping("/adminStudent")
	public void adminStudent(Model m) {
		List<Student> students=service.selectStudent();
		m.addAttribute("students",students);
	}
	
	@GetMapping("/searchStudent")
	public List<Student> searchStudent(){
		
	}
}

package com.coma.admin.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.admin.service.AdminService;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	private final AdminService service;
	//private final BCryptPasswordEncoder passwordEncoder;
	
	//사원관련 컨트롤러
	@GetMapping("/adminEmp")
	public void selectEmpAll(Model m) {
		List<Emp> emps=service.selectEmpAll();
		List<Dept> depts=service.selectDept();
		m.addAttribute("emps",emps);
		m.addAttribute("depts",depts);
	}
	
	@PostMapping("/insertEmp")
	public @ResponseBody List<Emp> insertEmp(@RequestBody HashMap<String, Object> empName) {
		//String password=passwordEncoder.encode("1234");
		//empName.put("password", password);
		System.out.println(empName);
		service.insertEmp(empName);
		List<Emp> emps=service.selectEmpAll();
		return emps;
		
	}
	
	@PostMapping("/deleteEmp")
	public @ResponseBody List<Emp> deleteEmp(@RequestBody HashMap<String, Object> empId) {
		service.deleteEmp(empId);
		List<Emp> emps=service.selectEmpAll();
		return emps;
	}
	
	@PostMapping("/searchEmp")
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
	
	@PostMapping("/searchStudent")
	public List<Student> searchStudent(@RequestBody HashMap<String, Object> searchMap){
		List<Student> students=service.searchStudent(searchMap);
		return students;
	}

}

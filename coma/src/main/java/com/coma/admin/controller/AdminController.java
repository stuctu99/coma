package com.coma.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.admin.service.AdminService;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@RequestMapping("/admin")
@Controller
@RequiredArgsConstructor
public class AdminController {
	private final AdminService service;
	
	@GetMapping("/adminStudent")
	public void adminStudent() {}
	
	@GetMapping("/adminEmp")
	public void selectEmpAll(Model m) {
		List<Emp> emps=service.selectEmpAll();
		m.addAttribute("emps",emps);
	}
}

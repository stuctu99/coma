package com.coma.emp.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.coma.emp.service.EmpService;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/emps")
public class EmpController {
	
	private final EmpService service;
	
	@GetMapping
	public ResponseEntity<List<Emp>> selectEmpAll(){
		List<Emp> list = service.selectEmpAll();
		
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Emp> selectEmpById(@PathVariable String empId){
		Emp e = service.selectEmpById(empId);
		return ResponseEntity.status(HttpStatus.OK).body(e);
	}
	
	
	
}

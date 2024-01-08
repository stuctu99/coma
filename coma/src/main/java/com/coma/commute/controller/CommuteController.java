package com.coma.commute.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.commute.service.CommuteService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@RequestMapping("/commute")
@Controller
@RequiredArgsConstructor
@Slf4j
public class CommuteController {
	
	private final CommuteService service;
	private final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	
	@PostMapping("/insertCommute")
	@ResponseBody
	public int insertCommute(@RequestBody HashMap<String, Object> empId) {
		System.out.println(empId);
	    int result = service.insertCommute(empId);
	    System.out.println("결과"+result);
	    return result;
	}

	
	
	
	
}

package com.coma.commute.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("/insertCommute")
	public void insertCommute() {
		logger.debug("들어왔다");
		//return "insertCommuteView";
	}
	
	
	
	
}

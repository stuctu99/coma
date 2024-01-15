package com.coma.apprdoc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.apprdoc.service.ApprdocService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/apprdoc")
public class ApprdocController {
	
	private final ApprdocService service;
	
	
	@GetMapping("/docList")
	public void selectDocList() {
		
	}
	
	
}

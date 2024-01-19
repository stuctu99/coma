package com.coma.organization.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coma.organization.service.OrganizationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/organization")
@RequiredArgsConstructor
public class OrganizationController {
	private final OrganizationService service;
	
	@GetMapping("/organization")
	public void organization() {
		
	}
}

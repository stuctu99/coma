package com.coma.commute.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.coma.emp.service.EmpServiceImpl;
import com.coma.model.dto.Emp;
import com.coma.mypage.model.service.MypageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/mypage")
@Controller
@RequiredArgsConstructor
public class CommuteController {
	@Autowired
	private final MypageService service;
	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	private final EmpServiceImpl  empService;
	private final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	
	
}

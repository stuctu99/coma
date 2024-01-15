package com.coma.apprdoc.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.coma.apprdoc.service.ApprdocService;
import com.coma.model.dto.ApprovalDoc;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/apprdoc")
public class ApprdocController {
	
	private final ApprdocService service;
	
	//문서 리스트출력
	@GetMapping("/proceedList")
	public void selectProceedList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "10") int numPerpage,
							  @RequestParam(required = false, defaultValue="대기") String docProgress, Model m) {
			List<ApprovalDoc> appr = new ArrayList<>();
			
			appr = service.selectProceedList(Map.of("cPage", cPage, "numPerpage", numPerpage),docProgress);
			
			m.addAttribute("proceed", appr);
		
	}
	
	//문서함 리스트출력 메소드
	@GetMapping("/docList")
	public void selectDocList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "10") int numPerpage,
							  @RequestParam(required = false, defaultValue="완료") String docProgress, Model m) {
			List<ApprovalDoc> doc = new ArrayList<>();
			
			doc = service.selectProceedList(Map.of("cPage", cPage, "numPerpage", numPerpage),docProgress);
			
			m.addAttribute("doc", doc);
			
		
	}
	
	
}

package com.coma.apprdoc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.apprdoc.service.ApprdocService;
import com.coma.common.pagefactory.PageFactory;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/apprdoc")
public class ApprdocController {
	
	private final ApprdocService service;
	private final PageFactory pageFactory;
	
	@GetMapping("/allList")
	public void	selectAllList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
			  @RequestParam(required = false, defaultValue="대기") String docProgress, Model m) {
			
			List<ApprovalDoc> appr = new ArrayList<>();
			String progress = null;
			
			//전체문서수
			int allCount = service.selectApprCount(null);
			m.addAttribute("allCount", allCount);
			
			//진행중인 문서(대기,진행)
			progress = "진행";
			int startCount = service.selectApprCount(progress);
			m.addAttribute("startCount", startCount);
			
			//완료문서(완료,반려)
			progress = "완료";
			int endCount = service.selectApprCount(progress);
			m.addAttribute("endCount", endCount);
			
			//문서리스트
			appr = service.selectProceedList(Map.of("cPage", cPage, "numPerpage", numPerpage),docProgress);
			
			m.addAttribute("proceed", appr);
			m.addAttribute("pageBar", pageFactory.getPage(cPage, numPerpage, numPerpage, docProgress));
		
	}
	
	
	//문서 리스트출력
	@GetMapping("/proceedList")
	public void selectProceedList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
							  @RequestParam(required = false, defaultValue="대기") String docProgress, Model m) {
			List<ApprovalDoc> appr = new ArrayList<>();
			String progress = null;
			Map<String, Object> pgMap = new HashMap<>();
			
			//전체문서수
			int allCount = service.selectApprCount(progress);
			m.addAttribute("allCount", allCount);
			
			//진행중인 문서(대기,진행)
			progress = "진행";
			int startCount = service.selectApprCount(progress);
			m.addAttribute("startCount", startCount);
			
			//완료문서(완료,반려)
			progress = "완료";
			int endCount = service.selectApprCount(progress);
			m.addAttribute("endCount", endCount);
			
			//문서리스트
			appr = service.selectProceedList(Map.of("cPage", cPage, "numPerpage", numPerpage),docProgress);
			
			
			m.addAttribute("proceed", appr);
			m.addAttribute("pageBar", pageFactory.getPage(cPage, numPerpage, numPerpage, docProgress));
		
	}
	
	//문서함 리스트출력 메소드
	@GetMapping("/docList")
	public void selectDocList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
							  @RequestParam(required = false, defaultValue="완료") String docProgress, Model m) {
			List<ApprovalDoc> doc = new ArrayList<>();
			String progress = null;
			Map<String, Object> pgMap = new HashMap<>();
			
			
			doc = service.selectProceedList(Map.of("cPage", cPage, "numPerpage", numPerpage),docProgress);
			
			
			//전체문서수
			int allCount = service.selectApprCount(null);
			m.addAttribute("allCount", allCount);
			
			//진행중인 문서(대기,진행)
			progress = "진행";
			int startCount = service.selectApprCount(progress);
			m.addAttribute("startCount", startCount);
			
			//완료문서(완료,반려)
			progress = "완료";
			int endCount = service.selectApprCount(progress);
			m.addAttribute("endCount", endCount);
			
			
			m.addAttribute("doc", doc);
			
		
	}
	
	//문서검색 메소드
	@PostMapping("/search")
	@ResponseBody
	public ResponseEntity<List<ApprovalDoc>> searchDoc(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
														String keyword, Model m){
		
		Map<String, Object> doc = new HashMap<>();
		doc.put("keyword", keyword);
		doc.put("cPage", cPage);
		doc.put("numPerpage", numPerpage);
		
		List<ApprovalDoc> searchdoc= service.searchDoc(doc);
//		int totalData = service.getSearchResultCount(board);
		
		
		return ResponseEntity.ok(searchdoc);
		
	}
	
	
}

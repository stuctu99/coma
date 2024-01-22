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
			  @RequestParam(required = false, defaultValue="대기") String docProgress, String empId,Model m) {
			
//			List<ApprovalDoc> appr = new ArrayList<>();
			List<ApprovalDoc> myAppr = new ArrayList<>();
			List<ApprovalDoc> myStartAppr = new ArrayList<>();
			
			String progress = null;
			Map<String, Object> pgMap = new HashMap<>();
			Map<String, Object> myMap = new HashMap<>();
			
			myMap.put("empId", empId);
			myMap.put("progress", docProgress);
			
			pgMap.put("empId", empId);
			
			// 진행 중인 문서(대기,진행)
		    progress = "진행";
		    pgMap.put("progress", progress);
		    int startCount = service.selectApprCount(pgMap);
		    m.addAttribute("startCount", startCount);

		    // 완료 문서(완료,반려)
		    progress = "완료";
		    pgMap.put("progress", progress);
		    int endCount = service.selectApprCount(pgMap);
		    m.addAttribute("endCount", endCount);
		    
		    // 전체 문서 수
		    pgMap.put("progress", null); // null일 때 전체 문서를 카운트하기 위해
		    int allCount = service.selectApprCount(pgMap);
		    m.addAttribute("allCount", allCount);
			
			//문서리스트
			myAppr = service.selectMyList(Map.of("cPage", cPage, "numPerpage", numPerpage), myMap);
			
			
			m.addAttribute("proceed", myAppr);
			m.addAttribute("pageBar", pageFactory.getPage(cPage, numPerpage, numPerpage, docProgress));
		
	}
	
	
	//문서 리스트출력
	@GetMapping("/proceedList")
	public void selectProceedList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
							  @RequestParam(required = false, defaultValue="대기") String docProgress, String empId, Model m) {
			
			List<ApprovalDoc> myAppr = new ArrayList<>();
			String progress = null;
			Map<String, Object> pgMap = new HashMap<>();
			Map<String, Object> myMap = new HashMap<>();
			
			myMap.put("empId", empId);
			myMap.put("progress", "진행");
			
			pgMap.put("empId", empId);
			
			// 진행 중인 문서(대기,진행)
		    progress = "진행";
		    pgMap.put("progress", progress);
		    int startCount = service.selectApprCount(pgMap);
		    m.addAttribute("startCount", startCount);
		    pgMap.remove("progress");

		    // 완료 문서(완료,반려)
		    progress = "완료";
		    pgMap.put("progress", progress);
		    int endCount = service.selectApprCount(pgMap);
		    m.addAttribute("endCount", endCount);
		    pgMap.remove("progress");

		    // 전체 문서 수
		    pgMap.put("progress", null); // null일 때 전체 문서를 카운트하기 위해
		    int allCount = service.selectApprCount(pgMap);
		    m.addAttribute("allCount", allCount);
			
			myAppr = service.selectMyList(Map.of("cPage", cPage, "numPerpage", numPerpage),myMap);
			
			m.addAttribute("proceed", myAppr);
			m.addAttribute("pageBar", pageFactory.getPage(cPage, numPerpage, numPerpage, docProgress));
	}
	
	//문서함 리스트출력 메소드
	@GetMapping("/docList")
	public void selectDocList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "50") int numPerpage,
							  @RequestParam(required = false, defaultValue="완료") String docProgress, String empId,Model m) {
			
			List<ApprovalDoc> myAppr = new ArrayList<>();
			String progress = null;
			Map<String, Object> pgMap = new HashMap<>();
			Map<String, Object> myMap = new HashMap<>();
			
			myMap.put("empId", empId);
			myMap.put("progress", "완료");
			
			
			pgMap.put("empId", empId);
			
			// 진행 중인 문서(대기,진행)
		    progress = "진행";
		    pgMap.put("progress", progress);
		    int startCount = service.selectApprCount(pgMap);
		    m.addAttribute("startCount", startCount);
		    pgMap.remove("progress");
	
		    // 완료 문서(완료,반려)
		    progress = "완료";
		    pgMap.put("progress", progress);
		    int endCount = service.selectApprCount(pgMap);
		    m.addAttribute("endCount", endCount);
		    pgMap.remove("progress");
	
		    // 전체 문서 수
		    pgMap.put("progress", null); // null일 때 전체 문서를 카운트하기 위해
		    int allCount = service.selectApprCount(pgMap);
		    m.addAttribute("allCount", allCount);
			
			myAppr = service.selectMyList(Map.of("cPage", cPage, "numPerpage", numPerpage),myMap);
			
			m.addAttribute("doc", myAppr);
			m.addAttribute("pageBar", pageFactory.getPage(cPage, numPerpage, numPerpage, docProgress));
			
		
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

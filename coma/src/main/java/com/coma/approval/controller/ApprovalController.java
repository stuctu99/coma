package com.coma.approval.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.coma.approval.model.service.ApprovalService;
import com.coma.model.dto.ApprovalAttachment;
import com.coma.model.dto.ApprovalCash;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalEtc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.ApprovalRequest;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Referrer;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
public class ApprovalController {

	private final ApprovalService service;
	
	@GetMapping("/writedoc")
	public String writeDoc() {
		return "/approval/writedoc";
	}
	
	@GetMapping("/viewdoc")
	public String viewDoc() {
		return "/approval/viewdoc";
	}
	
	@GetMapping("/sign")
	public String sign() {
		return "/approval/sign";
	}
	
	@PostMapping
	public String insertApproval(MultipartFile upFile, String docNo, ApprovalDoc doc, ApprovalAttachment attach, 
									Approver approver, Referrer ref, ApprovalLeave leave, ApprovalCash cash,
									ApprovalRequest req, ApprovalEtc etc) {
		
		Map data = new HashMap<>();
		data.put("docNo",docNo);
		data.put("doc",doc);
		
		data.put("attach",attach);
		
		data.put("approver",approver);
		data.put("ref",ref);
		
		data.put("leave",leave);
		data.put("cash",cash);
		data.put("req",req);
		data.put("etc",etc);
		
		int result = service.insertApproval(data);
		
		return "redirect:/approval";
	}
}

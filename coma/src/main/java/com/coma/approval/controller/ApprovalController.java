package com.coma.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.coma.approval.model.service.ApprovalService;
import com.coma.model.dto.ApprovalAttachment;
import com.coma.model.dto.Emp;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
public class ApprovalController {

	private final ApprovalService service;
	private final Gson gson;
	
	@GetMapping("/approver")
	@ResponseBody
	public List<Emp> writeDoc(String data, Model model, String approver, HttpServletResponse response) throws IOException {
		
		System.out.println(data);
		List<Emp> emp = service.selectEmpByData(data);
		
		return emp;
	}
	
	@GetMapping("/test")
	@ResponseBody
	public String test(String data) {
		return data+ "왔어 왔어";
	}
	
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
	public String insertApproval(MultipartFile[] upFile, String title, HttpSession session) {
		
		System.out.println(upFile);
		
		String path = session.getServletContext().getRealPath("/resources/upload/approval");
		
		List<ApprovalAttachment> files = new ArrayList<>();
		
		if(upFile!=null) {
			for(MultipartFile mf:upFile) {
				if(mf.isEmpty()) {
					String oriName = mf.getOriginalFilename();
					String ext = oriName.substring(oriName.lastIndexOf("."));
					Date today = new Date(System.currentTimeMillis());
					int randomNum = (int)(Math.random()*10000)+1;
					String rename = "appr_" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(today)+"_"+randomNum;
					
					try {
						mf.transferTo(new File(path, rename));
						ApprovalAttachment file = ApprovalAttachment.builder()
												.attachOriName(oriName)
												.attachReName(rename)
												.build();
						files.add(file);
					}catch(IOException e) {
						e.printStackTrace();
					}
				}
			}	
		}
		
		//doc dto에 필드로 List 추가했을 경우-> 
//		doc.setFiles(files);
		 
		
		
//		//Map으로 할 경우->
//		Map data = new HashMap<>();
//		data.put("docNo",docNo);
////		data.put("doc",doc);
//		
//		data.put("files", files);
//		
//		data.put("approver",approver);
//		data.put("ref",ref);
//		
//		data.put("leave",leave);
//		data.put("cash",cash);
//		data.put("req",req);
//		data.put("etc",etc);
		
//		int result = service.insertApproval(data);
		
//		List<Emp> testEmp =  service.selectEmpListAll();
		
		return "redirect:/approval";
	}
}

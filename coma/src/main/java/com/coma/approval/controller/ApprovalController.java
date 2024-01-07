package com.coma.approval.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.coma.approval.model.service.ApprovalService;
import com.coma.model.dto.ApprovalAttachment;
import com.coma.model.dto.ApprovalCash;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalEtc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.ApprovalRequest;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/approval")
@RequiredArgsConstructor
@Slf4j
public class ApprovalController {

	private final ApprovalService service;

//	@Autowired
//	private ApprovalDoc doc;
	

	//---------------------- 결재자/참조자 검색 -------------------------------
	
	@GetMapping("/apprline")
	@ResponseBody
	public List<Emp> searchApprLine(String data, Model model, String approver, HttpServletResponse response) throws IOException {
		
		List<Emp> emp = service.selectEmpByData(data);
		
		return emp;
	}
	
	//---------------------------------------------------------------------
	
	@GetMapping("/test")
	@ResponseBody
	public String test(String data) {
		return data+ "왔어 왔어";
	}
	
	@GetMapping("/writedoc")
	public String writeDoc() {
		return "approval/writedoc";
	}
	
	@GetMapping("/viewdoc")
	public String viewDoc() {
		return "approval/viewdoc";
	}
	
	@GetMapping("/sign")
	public String sign() {
		return "approval/sign";
	}
	
	
	//----------------------String -> LocalDate 변경 메소드-------------------------------
	
	public LocalDate formatDate(String beforeDate) {
		
		
		if(beforeDate == null || beforeDate.isEmpty()) {
			System.err.println("날짜 비어있음");
			return null;
		}
		
			SimpleDateFormat leaveStartFormat = new SimpleDateFormat("MM/dd/yyyy");
			
			String formattedDateString=""; //초기화 
			
			try {
				
				//beforeDate 문자열을 SimpleDateFormat을 이용하여 Date 객체로 파싱. ("MM/dd/yyyy")을 받음.
				Date date = leaveStartFormat.parse(beforeDate);
		
				
				// Date 객체를 다시 문자열로 포맷팅
				SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy/MM/dd");
				// 변환된 문자열 formattedDateString에 저장
				formattedDateString = outputDateFormat.format(date);
				
				
			}catch(ParseException e) {
				e.printStackTrace();
			}
			
				//DateTieFormatter와 LocalDate.parse를 이용해 "yyyy/MM/dd"형식의 문자열을 LocalDate 객체로 변환.
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		        LocalDate localDate = LocalDate.parse(formattedDateString, formatter);

		        System.out.println(localDate);
	
		        return localDate;
	}
	
	//-------------------------------------------------------------
	
	//---------------------- insert -------------------------------
	
	@PostMapping("/insertdoc")
	public String insertApproval(MultipartFile[] upFile, HttpSession session,
								String loginMember,
								String docType, String title,
								@RequestParam(name="appr_result[]", required=false) List<String> apprResults,
								@RequestParam(name="ref_result[]", required=false) List<String> refResults,
								String editorContent,
								String leaveType, String leaveStart, String leaveEnd,
								Integer expense, String cashDate, String reqDate, String etcDate) {
		

		
		String path = session.getServletContext().getRealPath("/resource/upload/approval");
		
		// 경로를 문자열에서 Path 객체로 변환(문자열보다 권장됨)
		Path folderPath = Paths.get(path);

		// 해당 경로에 폴더가 없으면 생성
		if (!Files.exists(folderPath)) {
		    try {
		        Files.createDirectories(folderPath);
		        System.out.println("폴더 생성: " + folderPath);
		    } catch (Exception e) {
		        System.err.println("폴더 생성 중 오류 발생: " + e.getMessage());
		    }
		}

		//-------- ApprovalDoc doc 에 나머지 객체/리스트들을 필드로 추가.
		
		ApprovalDoc doc = null;
	
		ApprovalLeave leave = null;
		ApprovalCash cash = null;
		ApprovalRequest req = null;
		ApprovalEtc etc = null;
		
		List<ApprovalAttachment> files = new ArrayList<>();
		
		List<Approver> approver = new ArrayList<>();
		List<Referrer> ref = new ArrayList<>();
		
		//--------
		
		
		//공통사항 객체
	
				doc = ApprovalDoc.builder()
					.docType(docType)
					.docTitle(title)
					.empId(loginMember)
					.build();	
			
		
		//휴가신청서 객체
		if(formatDate(leaveStart)!=null && formatDate(leaveEnd) != null) {
			
				leave = ApprovalLeave.builder()
							.leaveType(leaveType)
			                .leaveStart(java.sql.Date.valueOf(formatDate(leaveStart)))
			                .leaveEnd(java.sql.Date.valueOf(formatDate(leaveEnd)))
			                .leaveDetail(editorContent)
			                .build();
		        
		}
		
	
		
		//지출결의서 객체 
		if(formatDate(cashDate)!=null) {
	
				cash = ApprovalCash.builder()
							.cashExpense(expense)
							.cashDate(java.sql.Date.valueOf(formatDate(cashDate)))
							.cashDetail(editorContent)
							.build();
		}
		
		//품의서 객체 
		if(formatDate(reqDate)!=null) {
			
				req = ApprovalRequest.builder()
							.reqDetail(editorContent)
							.reqDate(java.sql.Date.valueOf(formatDate(reqDate)))
							.build();
		}
		
		//기타 문서 객체
		if(formatDate(reqDate)!=null) {
			
				etc = ApprovalEtc.builder()
							.etcDetail(editorContent)
							.etcDate(java.sql.Date.valueOf(formatDate(etcDate)))
							.build();
		}
		
		//첨부파일 저장 로직, 객체 리스트
		
		if(upFile!=null) {
			for(MultipartFile mf:upFile) {
				if(!mf.isEmpty()) {
					String oriName = mf.getOriginalFilename();
					String ext = oriName.substring(oriName.lastIndexOf("."));
					Date today = new Date(System.currentTimeMillis());
					int randomNum = (int)(Math.random()*10000)+1;
					String rename = "appr_" + new SimpleDateFormat("yyyyMMddHHmmssSSS")
									.format(today)+"_"+randomNum+ext;
					
					
					try {
						mf.transferTo(new File(path, rename));
						
						//첨부파일 객체 리스트 
						files.add(		
								ApprovalAttachment.builder()
										.attachOriName(oriName)
										.attachReName(rename)
										.build()
								);
					}catch(IOException e) {
						e.printStackTrace();
					}
				}
			}	
		}

		
		//결재자 객체 리스트
		
		for(int i=0; i<apprResults.size(); i++) { //apprResults = 프론트에서 넘어온 String[]
			
			String result = apprResults.get(i); // result = 결재자 한 명의 정보

			String[] splitResult = result.split(" "); //띄어쓰기 기준으로 정보 분리.
		
			approver.add(
					Approver.builder() //결재자 한 명
						.empId(splitResult[0]) //해당 결재자의 id
						.apprOrder(i) //apprResults 배열 내 순서(결재 순번)
						.build()
					);
			
		}
		
		//참조자 객체 리스트
		for(int i=0; i< refResults.size(); i++) { 
					
					String result = refResults.get(i); 
		
					String[] splitResult = result.split(" "); 
				
					ref.add(
							Referrer.builder() 
								.empId(splitResult[0]) //해당 참조자의 id
								.build()
							);
					
				}
		
		
		doc.setLeave(leave);
		doc.setCash(cash);
		doc.setReq(req);
		doc.setEtc(etc);
		doc.setFiles(files);
		doc.setApprover(approver);
		doc.setRef(ref);
		
		
		service.insertApproval(doc);
		
		
		 

		
		return "redirect:/approval/writedoc";
	}
//---------------------------------------------------------------------
	
}


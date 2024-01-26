package com.coma.approval.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.coma.approval.model.service.ApprovalService;
import com.coma.approval.pdf.PdfGenerator;
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

//   @Autowired
//   private ApprovalDoc doc;
   

   //---------------------- 결재자/참조자 검색 -------------------------------
   
   @GetMapping("/apprline")
   @ResponseBody
   public List<Emp> searchApprLine(String data, Model model, String approver, HttpServletResponse response) throws IOException {
      
      List<Emp> emp = service.selectEmpByData(data);
      
      return emp;
   }
   
   //---------------------------------------------------------------------
   
//   @GetMapping("/test")
//   @ResponseBody
//   public String test(String data) {
//      return data+ "왔어 왔어";
//   }
   
   @GetMapping("/writedoc")
   public String writeDoc() {
      return "approval/writedoc";
   }
   
   @GetMapping("/sign")
   public String sign() {
      return "approval/sign";
   }
   
   
   //----------------------String -> sqlDate 변경 메소드-------------------------------
   
   public java.sql.Date formatDate(String beforeDate) { // 프론트에서 MM/dd/yyyy형식으로 넘어옴.
      
         SimpleDateFormat leaveStartFormat = new SimpleDateFormat("MM/dd/yyyy");
         
         try {
            System.out.println("formatDate메소드 내 확인"+beforeDate);
            //beforeDate 문자열을 SimpleDateFormat을 이용하여 Date 객체로 파싱. ("MM/dd/yyyy")을 받음.
            Date date = leaveStartFormat.parse(beforeDate);
      
            //java.sql.Date는 내부적으로 날짜를 yyyy-MM-dd 형식으로 가지고있음.
            //yyyy-MM-dd 형식으로 반환.
            return new java.sql.Date(date.getTime());

            
         }catch(ParseException e) {
            e.printStackTrace();
            return null;
         }
         

   }
   
   //-------------------------------------------------------------
   
   //---------------------- insert -------------------------------
   
   @PostMapping("/insertdoc")
   public String insertApproval(MultipartFile[] upFile, HttpSession session,
                        String empId,
                        String docType, String title,
                        @RequestParam(name="appr_result[]", required=false) List<String> apprResults,
                        @RequestParam(name="ref_result[]", required=false) List<String> refResults,
                        String editorContent,
                        String leaveType, String leaveStart, String leaveEnd,
                        Integer expense, String cashDate, String reqDate, String etcDate,
                        Model model) {
      
      
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
      


      
      //공통사항 객체

        doc = ApprovalDoc.builder()
           .docType(docType)
           .docTitle(title)
           .empId(empId)
           .docDetail(editorContent)
           .build();   
         
      
      //휴가신청서 객체
       if(leaveStart!=null && !leaveStart.equals("") &&
                  leaveEnd!=null && !leaveEnd.equals("")) {
         
            leave = ApprovalLeave.builder()
                     .leaveType(leaveType)
                         .leaveStart(formatDate(leaveStart))
                         .leaveEnd(formatDate(leaveEnd))
                         .build();
              
      }
      
   
      
      //지출결의서 객체 
      if(cashDate!=null && !cashDate.equals("")) {
   
            cash = ApprovalCash.builder()
                     .cashExpense(expense)
                     .cashDate(formatDate(cashDate))
                     .build();
      }
      
      //품의서 객체 
      
      if(reqDate!=null && !reqDate.equals("")) {
         
            req = ApprovalRequest.builder()
                     .reqDate(formatDate(reqDate))
                     .build();
      }
      
      //기타 문서 객체
      if(etcDate!=null && !etcDate.equals("")) {
         
            etc = ApprovalEtc.builder()
                     .etcDate(formatDate(etcDate))
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

         
         if(splitResult[0]!=null && !splitResult[0].equals("")) {

            approver.add(
                  Approver.builder() //결재자 한 명
                     .empId(splitResult[0]) //해당 결재자의 id
                     .apprOrder(i) //apprResults 배열 내 순서(결재 순번)
                     .build()
                  );
         }
         
      }
      
      //참조자 객체 리스트
      for(int i=0; i< refResults.size(); i++) { 
               
               String result = refResults.get(i); 
      
               String[] splitResult = result.split(" "); 
         if(splitResult[0]!=null && !splitResult[0].equals("")) {
      
            ref.add(
                     Referrer.builder() 
                        .empId(splitResult[0]) //해당 참조자의 id
                        .build()
                     );
         }      
            }
      
      
      doc.setLeave(leave);
      doc.setCash(cash);
      doc.setReq(req);
      doc.setEtc(etc);
      doc.setFiles(files);
      doc.setApprover(approver);
      doc.setRef(ref);
   
      String msg, loc;
      try {
         int result = service.insertApproval(doc);   

         msg="문서 등록 성공";
         loc="apprdoc/allList?empId="+empId; // 결재 문서함 페이지로 이동
      }catch(RuntimeException e){
         msg="문서 등록 실패";
         loc="approval/writedoc";
         for(ApprovalAttachment a : files) {
            File delFile = new File(path, a.getAttachReName());
            delFile.delete();
         }
      }

      model.addAttribute("msg",msg);
      model.addAttribute("loc",loc);
      
      
      return "common/msg";
   }
//---------------------------------------------------------------------
   
   
//--------------------------- 문서 상세보기 ------------------------------
   @GetMapping("/viewdoc")
   public String viewDoc(String docNo, Model model) {
	   
	 Map<String, String> data = new HashMap<String, String>();
	
	 data.put("docNo", docNo); 
	
	 //문서 타입 가져오기
	 String docType = service.selectDocType(docNo);
	 data.put("docType", docType); 
	 
	 //문서 번호, 문서 타입으로로 해당 문서 정보 가져오기
	 ApprovalDoc doc = service.selectAppDoc(data); 

	 	model.addAttribute("doc",doc);
	 
	 	
	 	
	 //Date 시간 잘라내고 날짜만 가져오기	
	 String fullDate = doc.getDocDate()+" ";
     String onlyDate = fullDate.substring(0,10); //시간 잘라내기
	 
     	model.addAttribute("onlyDate", onlyDate);
	 
     //문서 종류 한글로 변환
	 String typeKor = "";
	 
	 switch(doc.getDocType()) {
		case "leave" : typeKor = "휴가 신청서"; break;
		case "cash" : typeKor = "지출 결의서"; break;
		case "req" : typeKor = "품의서"; break;
		case "etc" : typeKor = "기타 문서"; break;
	 }
	 
	 	model.addAttribute("typeKor", typeKor);
	
	 	
	 //기안자 정보 가져오기	
	 Emp writer = service.selectEmpById(doc.getEmpId());
	 	
	 	model.addAttribute("writer", writer);
	 
	 	
	 //결재자 정보 가져오기
	 List<Approver> apprList = service.selectApprByDocNo(docNo);
	
	 List<Emp> apprInfoList = new ArrayList<>();
	 
	 for(Approver a : apprList) {
		 String apprId = a.getEmpId();
		 
		 Emp apprInfo = service.selectEmpById(apprId);
		 apprInfoList.add(apprInfo);
	 }
	 
	 model.addAttribute("apprInfoList", apprInfoList);
     
	 //참조자 정보 가져오기
	 List<Referrer> refList = service.selectRefByDocNo(docNo);
	 
	 List<Emp> refInfoList = new ArrayList<>();
	 
	 for(Referrer r : refList) {
		 String refId = r.getEmpId();
		 
		 Emp refInfo = service.selectEmpById(refId);
		 refInfoList.add(refInfo);
	 }
	 
	 model.addAttribute("refInfoList",refInfoList);
	 
	 
	 // Myturn 'Y'인 결재자 승인 버튼
	 Approver apprMyturn = service.selectApprMyturn(docNo);
	 if(apprMyturn!=null) {
		 model.addAttribute("myTurnEmpId", apprMyturn.getEmpId());
		 model.addAttribute("myTurnOrder", apprMyturn.getApprOrder());
	 }else {
		 System.out.println("apprMyturn = null");
		 
	 }
	 
	 return "approval/viewdoc";
   }
   
//---------------------------- PDF -------------------------------------------
   
   
   
   @Autowired
   private PdfGenerator pdfGen;

   @GetMapping("/downloadPdf")
   public void generatePdf(HttpSession session, HttpServletResponse response, String docNo, 
		   						String docType, String empId, @RequestParam String[] apprIdArr) {

	   
	   Emp writer = service.selectEmpById(empId);
	   
	   //-----해당 문서 정보
	   
	   Map<String, String> data = new HashMap<String, String>();
	   data.put("docNo", docNo); 
	   data.put("docType", docType); 
	   
	   ApprovalDoc doc = service.selectAppDoc(data); 

	   
	   //--------------

	   String fontPath = session.getServletContext().getRealPath("/resource/fonts/NotoSansKR-VariableFont_wght.ttf");

	  
	   Map<String, String> data2 = new HashMap<String, String>();
	   data2.put("docNo", docNo); 
	     	   
	  String[] signArr = new String[apprIdArr.length];
	  int i=0;
	  for(String apprId : apprIdArr) {
	
		  data2.put("empId", apprId); 
		  String status = service.getStatusByIdAndDocNo(data2); //해당 결재자의 결재 상태
  
		  if(status!=null) {
			  String sign = service.getSignByApprId(apprId); //결재 완료일 경우 사인 가져옴
			  
			  signArr[i] = sign;
		  }
		  i++;
		  
	  }
	   
	   
	   //String imgPath = session.getServletContext().getRealPath("/resource/upload/approval/image (6).png");
	   String imgPath = session.getServletContext().getRealPath("/resource/upload/sign/");

	   
	   //pdfGen이 service 역할
	   pdfGen.generatePdf(doc, response, fontPath, writer, imgPath, signArr);
	      
	   //return "approval/viewdoc"; ㄴㄴ
	   //return을 하면 outputStream이 또 호출됨
	   
   }
   
//------------------------------- 서명 추가 --------------------------------------
 
   @GetMapping("/addsign")
   public String approver() {
      return "approval/addsign";
   }
   
   @GetMapping("/signCanvas")
   public String newSign() {
      return "approval/signCanvas";
   }
   

   @PostMapping("/getSignImg")
   public String getSignImg(@RequestParam MultipartFile imgFile, HttpSession session, String empId, Model model)
   											throws IOException{
	   Map<String, String> data = new HashMap<String, String>();
	   
	   
	   String path = session.getServletContext().getRealPath("/resource/upload/sign");
	   
	   if(imgFile!=null) {
	               String oriName = imgFile.getOriginalFilename();
	               String ext = oriName.substring(oriName.lastIndexOf("."));
	               Date today = new Date(System.currentTimeMillis());
	               String rename = "sign_" + empId + ext;
	              // 서명 다시 등록할 경우 파일 덮어쓰기됨.
	               
	               data.put("sign", rename); 
	               data.put("empId", empId); 
	               
	               try {
	            	   imgFile.transferTo(new File(path, rename));
	                  
	               }catch(IOException e) {
	                  e.printStackTrace();
	               }
	            }
	   
	   
		   // sign 파일 이름 DB에 추가
		 service.updateSign(data);
	  

	   
		   String msg="서명 등록 완료";
	       String loc="approval/addsign";
		   
	       model.addAttribute("msg",msg);
	       model.addAttribute("loc",loc);
	       
		   return "common/msg";
	   	
   }
   
   
   //---------------------------- 결재 승인 -------------------------------------
   
   @PostMapping("/reject")
   public String reject(String docNo, String thisOrder, Model model, String empId) { //empId = 문서 기안자
	  
	   Map<String, String> data = new HashMap<String, String>();
	   data.put("docNo", docNo);
	   data.put("progress", "반려");
	   data.put("thisOrder", thisOrder);
		
	   int result1 = service.updateEndDate(data); //진행상태 반려로 변경
	   
	   int result2 = service.updateAllMyturn(data);
	   
	  
	   String msg="반려 처리 완료";
       String loc="apprdoc/allList?empId="+empId;
	   
       model.addAttribute("msg",msg);
       model.addAttribute("loc",loc);
       
	   return "common/msg";
   }
   
 
   
   @PostMapping("/approve")
   public String approve(String docNo, String thisOrder, String nextOrder, Model model, String docType, String empId) {
	   //empId = 문서 기안자
	   
		   Map<String, String> data = new HashMap<String, String>();
			
		   data.put("docNo", docNo);
		   data.put("thisOrder", thisOrder);
		   data.put("nextOrder", nextOrder);
		   data.put("status", "완료");
		   
		   int result1 =service.updateThisOrder(data);
		   
		   int result2 = service.updateNextOrder(data);
		   
		   String msg="승인 완료";
	       String loc="apprdoc/allList?empId="+empId;
	       model.addAttribute("msg",msg);
	       model.addAttribute("loc",loc);

	       // Myturn 'Y'인 결재자가 없으면 완료 처리
		   Approver apprMyturn = service.selectApprMyturn(docNo);
		   
		   if(apprMyturn==null) {
			   data.put("progress", "완료");
			   service.updateEndDate(data); 
			   
			   //휴가신청서일 경우 계산
			   if(docType.equals("leave")) {   
				   //잔여 휴가 15 - 휴가일수 (반차는 0.5일)

				   ApprovalLeave leave = service.selectLeaveDoc(docNo);
					  
				   if(leave.getLeaveType().equals("연차")) {
					   Date startDate = leave.getLeaveStart();
					   Date endDate =leave.getLeaveEnd();
					   
					   long diffSec = (endDate.getTime()-startDate.getTime());
					   
					   long diffDays = diffSec / (24*60*60)/1000 +1; //휴가 일수
					   
					   Map<String, String> dataL = new HashMap<String, String>();
					   dataL.put("empId", empId);
					   dataL.put("diffDays", String.valueOf(diffDays));
					   
					   int result = service.updateVacation(dataL);
					   
				   }else {
					   int result = service.updateVacationHalf(empId);
				   }
				   
			   }
			   
		   
		   }
			   
		   
		   
	      return "common/msg";
   }
   
   //------------------- 파일 다운로드 ---------------------------
   
   @GetMapping("/fileDownload/{file}")
   public void fileDownload(@PathVariable String file, HttpServletResponse response,  HttpSession session) throws IOException{
	 
	   String path = session.getServletContext().getRealPath("/resource/upload/approval");

	   File f = new File(path, file);
	   
	// file 다운로드 설정
       response.setContentType("application/download");
       response.setContentLength((int)f.length());
       response.setHeader("Content-disposition", "attachment;filename=\"" + file + "\"");
     
       // response 객체를 통해서 서버로부터 파일 다운로드
       OutputStream os = response.getOutputStream();
     
       // 파일 입력 객체 생성
       FileInputStream fis = new FileInputStream(f);
       FileCopyUtils.copy(fis, os);
       fis.close();
       os.close();
       
   }
   

   	
}

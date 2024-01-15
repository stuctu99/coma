package com.coma.approval.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
           .build();   
         
      
      //휴가신청서 객체
       if(leaveStart!=null && !leaveStart.equals("") &&
                  leaveEnd!=null && !leaveEnd.equals("")) {
         
            leave = ApprovalLeave.builder()
                     .leaveType(leaveType)
                         .leaveStart(formatDate(leaveStart))
                         .leaveEnd(formatDate(leaveEnd))
                         .leaveDetail(editorContent)
                         .build();
              
      }
      
   
      
      //지출결의서 객체 
      if(cashDate!=null && !cashDate.equals("")) {
   
            cash = ApprovalCash.builder()
                     .cashExpense(expense)
                     .cashDate(formatDate(cashDate))
                     .cashDetail(editorContent)
                     .build();
      }
      
      //품의서 객체 
      
      if(reqDate!=null && !reqDate.equals("")) {
         
            req = ApprovalRequest.builder()
                     .reqDetail(editorContent)
                     .reqDate(formatDate(reqDate))
                     .build();
      }
      
      //기타 문서 객체
      if(etcDate!=null && !etcDate.equals("")) {
         
            etc = ApprovalEtc.builder()
                     .etcDetail(editorContent)
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
      
      System.out.println("controller doc객체 확인"+doc);
      
      String msg, loc;
      try {
         int result = service.insertApproval(doc);   

         msg="문서 등록 성공";
         loc="approval/writedoc"; // 결재 문서함 주소로 수정 
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
   public String viewDoc(String docNo) {
	   
	 ApprovalDoc doc = service.selectAppDoc(docNo); 
	 
	 System.out.println("테스트: ***************:"+doc);
	 
      return "approval/viewdoc";
   }
   
   
//---------------------------------------------------------------------
   
   
}
package com.coma.approval.pdf;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.coma.approval.model.service.ApprovalService;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PdfGenerator {

	@Autowired
	private PdfType pdfType;
	
	@Autowired
	private ApprovalService service;

//	
//	public PdfGenerator(ApprovalService service) {
//		this.service = service;
//	}
	
	public void generatePdf(ApprovalDoc doc, HttpServletResponse response, String fontPath, Emp writerInfo, 
								String imgPath, String[] signArr) { 
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			Document document = new Document();
			
			PdfWriter writer = PdfWriter.getInstance(document, baos); //document를 baos에 보냄
			
			document.open();
			
			
			
		     //############################## 
			 Image[] images = new Image[signArr.length];
			//서명 
			if(signArr!=null) { //매개변수로 넘어온 signArr가 null이 아니면
				 int i=0;
				for(String s : signArr) {
					
					if(s!=null) {
						images[i] = Image.getInstance(imgPath+s);
						i++;
					}
				}
				
			}
	          
	          //################################
			
			
			BaseFont objBaseFont = BaseFont.createFont(fontPath,BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font font = new Font(objBaseFont, 12);
			
			float marginLeft = 36;
			float marginRight = 36;
			document.setMargins(marginLeft, marginRight, 0, 0);
	    
		  // ---------------------------- 문서 종류 ------------------------------
		
			String docType = "";
			switch(doc.getDocType()) {
				case "leave": docType = "휴가 신청서"; break;
				case "cash" : docType = "지출 결의서";  break;
				case "req" : docType = "품의서"; break;
				case "etc" : docType = "기타 문서"; break;
			}
			
			
			font.setSize(32);
			document.add(new Paragraph(docType,font));
			font.setSize(12);
			
			Paragraph emptySpace = new Paragraph(" ");
			
		  // ------------------------------ 결재자 ------------------------------
			// table #1
	         document.add(generateTable(doc, font, document, writer, images)); 
	         document.add(emptySpace);
	         
	      // ------------------------------ 참조자 -------------------------------
	        // table #2 
	         document.add(generateTable2(doc, font, document, writer));
	         document.add(emptySpace);
	       
	      // ------------------------------ 공통사항 -----------------------------------   

	         // table #3 (부서, 직급)
	         document.add(pdfType.generateTable3(doc, font, document, writer,"부서",writerInfo.getDept().getDeptType(),"직급",writerInfo.getJob().getJobType()));
	         
	         // table #3 (성명)
	         document.add(pdfType.generateTable3(doc, font, document, writer,"성명", writerInfo.getEmpName(),"",""));
	         
	         // table #4 (제목)
	         document.add(pdfType.generateTable4(doc, font, document, writer, "제목", doc.getDocTitle()));
	         
	         
	      // -----------------------------   휴가신청서 -----------------------------   
	         if(doc.getDocType().equals("leave")) { 
	         
		         // table #4 (구분)
		         document.add(pdfType.generateTable4(doc, font, document, writer, "구분", doc.getLeave().getLeaveType()));
		         
		         // table #4 (휴가기간)
		         document.add(pdfType.generateTable4(doc, font, document, writer, "휴가 기간", doc.getLeave().getLeaveStart() +
		        		 														(doc.getLeave().getLeaveEnd()!=null?"  ~  "+ doc.getLeave().getLeaveEnd():"")));
		         document.add(emptySpace);

		         // -----------------------------  지출 결의서 -----------------------------     
	         }else if(doc.getDocType().equals("cash")) {
	        	 
	        	 // table #1
	        	document.add(pdfType.generateTable4(doc, font, document, writer, "비용", doc.getCash().getCashExpense()+" ￦"));
	     
	        	// table #2
	        	document.add(pdfType.generateTable4(doc, font, document, writer, "지출 날짜", doc.getCash().getCashDate()+" "));
	        	document.add(emptySpace);
	        	
	        	
	         
	        	 // -----------------------------  품의서 -----------------------------     
	         }else if(doc.getDocType().equals("req")) {
	        	 
	        	 // table #1
//	        	
	        	document.add(pdfType.generateTable4(doc, font, document, writer, "기안 날짜", doc.getReq().getReqDate()+" "));
	        	
	        	document.add(emptySpace);
	        
	        	 // -----------------------------  기타 문서 -----------------------------     
	         }else if(doc.getDocType().equals("etc")) {
	        	 
	        	 // table #1
		        	document.add(pdfType.generateTable4(doc, font, document, writer, "기안 날짜", doc.getEtc().getEtcDate()+" "));
		        	document.add(emptySpace);
	         }
	 	  
	         
	         
	     // -----------------------------  상세 내용 -----------------------------     
	 	        
	         // table #6 (상세내용)
	         document.add(generateTable6(doc, font, document, writer));
	         document.add(emptySpace);
	   
		 // -----------------------------  footer -----------------------------     
	 	         
	         
	         // 끝 문구
	         Paragraph endLine = new Paragraph("위와 같이 휴가를 신청합니다.",font);
	         endLine.setAlignment(Paragraph.ALIGN_CENTER);
	         document.add(endLine);
	         document.add(emptySpace);
	         
	         // 날짜
	         
	         String fullDate = doc.getDocDate()+" ";
	         String docDate = fullDate.substring(0,10); //시간 잘라내기
	         
	         Paragraph date = new Paragraph(docDate,font);
	         date.setAlignment(Paragraph.ALIGN_CENTER);
	         document.add(date);
	         document.add(emptySpace);
	         
	         // 신청인
	         Paragraph docWriter = new Paragraph("신청인 " +writerInfo.getEmpName(),font);
	         docWriter.setAlignment(Paragraph.ALIGN_RIGHT);
	         document.add(docWriter);
	         document.add(emptySpace);
	         
	         document.close();

			
			//다운로드할 파일 이름 설정
			String fileName = doc.getDocNo()+".pdf";
		
			
			// HTTP 응답 헤더 설정
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
			response.setContentLength(baos.size());
			
			// PDF 데이터를 사용자에게 전송
			ServletOutputStream outputStream = response.getOutputStream();
			baos.writeTo(outputStream); //baos를 원격으로 클라이언트한테 보냄
			outputStream.flush();
			
		
		
		}catch (DocumentException | IOException e) {
            e.printStackTrace();
     
		}
		finally { //output
        	
        	try {
				baos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }

	

	}
	
	//------------------------- 결재선 테이블 -------------------------
	   private PdfPTable generateTable(ApprovalDoc doc, Font font, Document document, PdfWriter writer, Image[] images) {
	      
	      
	      PdfPTable table1 = new PdfPTable(6);
	      
	      table1.setTotalWidth(450f);
	      table1.setLockedWidth(true);
	      
	      //row #1
	      
          //------hidden
	      
          PdfPCell t1_hiddenCell1;
          PdfPCell t1_hiddenCell2;
          PdfPCell t1_hiddenCell3;
          
          PdfPCell t1_cell1;
          PdfPCell t1_cell2;
          PdfPCell t1_cell3;
        
          List<Approver> apprList = service.selectApprByDocNo(doc.getDocNo()); 
          
          int i=0;
          String[] jobDept = new String[3];
          String[] appName = new String[3];
          
          
          for(Approver appr : apprList) {

        	  String apprId = appr.getEmpId();
        	  Emp appEmp = service.selectEmpById(apprId); //appEMp null
        	  
        	  jobDept[i] = appEmp.getDept().getDeptType() + " "+ appEmp.getJob().getJobType();
        	  appName[i] = appEmp.getEmpName();
        	   i++;
          } //apprList for문 끝
	          //--------- hidden 첫 번째 줄 
	          t1_hiddenCell1 = new PdfPCell(new Phrase(" ", font));
	          t1_hiddenCell1.setColspan(3);
	          t1_hiddenCell1.setBorder(Rectangle.NO_BORDER);
	          table1.addCell(t1_hiddenCell1);
          
	          // 직책 부서 - 첫 번째 줄
	          for(int j=0; j<appName.length; j++) {
		          t1_cell1 = new PdfPCell(new Phrase(jobDept[j], font));
		          t1_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
		          t1_cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
		          table1.addCell(t1_cell1);
//		          table1.completeRow();
	          }
	          
	          
	          //--------- hidden 두 번째 줄
	          t1_hiddenCell2 = new PdfPCell(new Phrase(" ", font));
	          t1_hiddenCell2.setFixedHeight(50f);
	          t1_hiddenCell2.setColspan(3);
	          t1_hiddenCell2.setBorder(Rectangle.NO_BORDER);
	          table1.addCell(t1_hiddenCell2);

	     
	          
	          
	          //서명
	      
		          for(Image image : images) {
		          
		        	  if(image!=null) {
			        	  t1_cell2 = new PdfPCell(image);
			        	  t1_cell2.setFixedHeight(50f);
			        	  t1_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
			        	  t1_cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);
			        	  table1.addCell(t1_cell2);
		        	  }
			  
		          }
		          
		         table1.completeRow();
	       
	          
	          //--------- hidden 세 번째 줄
	          t1_hiddenCell3 = new PdfPCell(new Phrase(" ", font));
	          t1_hiddenCell3.setColspan(3);
	          t1_hiddenCell3.setBorder(Rectangle.NO_BORDER);
	          table1.addCell(t1_hiddenCell3);
	          
	          //결재자 이름
	          for(int j=0; j<appName.length; j++) {

	        	  t1_cell3 = new PdfPCell(new Phrase(appName[j], font));
	        	  t1_cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
	        	  t1_cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);
	        	  table1.addCell(t1_cell3);
	        	  
	          }
	       

       //------------------------- 결재자 테이블 -------------------------	  


	      return table1;
	   }

	   //------------------------- 참조자 테이블 -------------------------	   
	   private PdfPTable generateTable2(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	        
	            PdfPTable table2 = new PdfPTable(6);
	            
	            table2.setTotalWidth(450f);
	            table2.setLockedWidth(true);
	            
	            // 참조자 label
	            
	            PdfPCell t2_label = new PdfPCell(
	            						new Phrase("참조자",font));
	            t2_label.setHorizontalAlignment(Element.ALIGN_CENTER);
	            t2_label.setVerticalAlignment(Element.ALIGN_MIDDLE);
	            t2_label.setFixedHeight(25f);
	            table2.addCell(t2_label);
	            
	            
	            // 참조자 이름
	            String refer = "";

	            List<Referrer> refList = service.selectRefByDocNo(doc.getDocNo()); //참조자 리스트
	            
	            for(Referrer r : refList){ //참조자 한 명씩 빼오기
	            	String refId = r.getEmpId(); //참조자 id
	            	Emp emp = service.selectEmpById(refId);
	            	refer += emp.getDept().getDeptType()+ " "+emp.getJob().getJobType() 
							+" " + emp.getEmpName() + ", ";
	            }
	            
	            PdfPCell t2_ref = new PdfPCell(
	            						new Phrase(refer.replaceAll(", $", ""), font));
	            t2_ref.setColspan(5);
	            t2_ref.setVerticalAlignment(Element.ALIGN_MIDDLE);
	            table2.addCell(t2_ref);

	            
	            return table2;
	         }
	   
	   
	 


    //------------------------- 상세 내용 테이블 -------------------------	 
	private PdfPTable generateTable6(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		PdfPTable table6 = new PdfPTable(1);
		
		table6.setTotalWidth(450f);
		table6.setLockedWidth(true);
		
		// 상세 내용 label
		PdfPCell t6_label = new PdfPCell(new Phrase("상세 내용", font));
		t6_label.setHorizontalAlignment(Element.ALIGN_CENTER);
		t6_label.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table6.addCell(t6_label);
		
		// 상세 내용 content
		PdfPCell t6_cells = new PdfPCell(new Phrase(doc.getDocDetail(),font));
		t6_cells.setFixedHeight(200f);
		t6_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
		t6_cells.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table6.addCell(t6_cells);
		
		return table6;
	}
			
}

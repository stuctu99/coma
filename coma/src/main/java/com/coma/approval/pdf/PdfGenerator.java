package com.coma.approval.pdf;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;

import com.coma.model.dto.ApprovalDoc;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
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

	public void generateAppr(ApprovalDoc doc, HttpServletResponse response, String fontPath) { 
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			Document document = new Document();
			
			PdfWriter writer = PdfWriter.getInstance(document, baos); //document를 baos에 보냄
			
			document.open();
			
			BaseFont objBaseFont = BaseFont.createFont(fontPath,BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font font = new Font(objBaseFont, 12);
			
			float marginLeft = 36;
			float marginRight = 36;
			document.setMargins(marginLeft, marginRight, 0, 0);
			
			font.setSize(32);
			document.add(new Paragraph("휴가신청서",font));
			font.setSize(12);
			
			Paragraph emptySpace = new Paragraph(" ");
			
			  // table #1
	         document.add(generateTable(doc, font, document, writer)); 
	         document.add(emptySpace);
	         
	         // table #2
	         document.add(generateTable2(doc, font, document, writer));
	         document.add(emptySpace);
	        
	         // table #3 (휴가신청서1)
	         document.add(generateTable3(doc, font, document, writer,"부서","직급"));
	         
	         // table #4 (휴가신청서1-1)
	         document.add(generateTable3(doc, font, document, writer,"성명", " "));
	  
	         // table #5 (휴가신청서2)
	         document.add(generateTable4(doc, font, document, writer, "구분", " "));
	         
	      // table #5 (휴가신청서2-1)
	         document.add(generateTable4(doc, font, document, writer, "휴가 기간", " "));
	         document.add(emptySpace);

	         // table #6 (상세내용)
	         document.add(generateTable6(doc, font, document, writer));
	         document.add(emptySpace);
	         
	         // 끝 문구
	         Paragraph endLine = new Paragraph("위와 같이 휴가를 신청합니다.",font);
	         endLine.setAlignment(Paragraph.ALIGN_CENTER);
	         document.add(endLine);
	         document.add(emptySpace);
	         
	         // 날짜
	         Paragraph date = new Paragraph("2024년 1월 11일",font);
	         date.setAlignment(Paragraph.ALIGN_CENTER);
	         document.add(date);
	         document.add(emptySpace);
	         
	      // 신청인
	         Paragraph docWriter = new Paragraph("신청인 이보연",font);
	         docWriter.setAlignment(Paragraph.ALIGN_RIGHT);
	         document.add(docWriter);
	         document.add(emptySpace);
	         
	         document.close();

			
			//다운로드할 파일 이름 설정
			String fileName = "approval.document.pdf";
		
			// HTTP 응답 헤더 설정
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename" + fileName);
			response.setContentLength(baos.size());
			
			// PDF 데이터를 사용자에게 전송
			ServletOutputStream outputStream = response.getOutputStream();
			baos.writeTo(outputStream); //baos를 원격으로 클라이언트한테 보냄
			outputStream.flush();
		
		
		}catch (DocumentException | IOException e) {
            e.printStackTrace();
     
		}
//		finally { //output
//        	
//        	try {
//				baos.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//        }

	

	}
	
	//------------------------- 결재선 테이블 -------------------------
	   private PdfPTable generateTable(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	      
	      PdfPTable table1 = new PdfPTable(6);
	      
	      table1.setTotalWidth(450f);
	      table1.setLockedWidth(true);
	      
	      //row #1
	      
          //-------hidden
	      
          PdfPCell t1_hiddenCell1 = new PdfPCell();
          PdfPCell t1_hiddenCell2 = new PdfPCell();
          PdfPCell t1_hiddenCell3 = new PdfPCell();
        
          //첫 번째 줄
          t1_hiddenCell1 = new PdfPCell(new Phrase(" ", font));
          t1_hiddenCell1.setColspan(3);
          t1_hiddenCell1.setBorder(Rectangle.NO_BORDER);
          table1.addCell(t1_hiddenCell1);
          table1.completeRow();
          
          //두 번째 줄
          t1_hiddenCell2.setFixedHeight(50f);
          t1_hiddenCell2.setColspan(3);
          t1_hiddenCell2.setBorder(Rectangle.NO_BORDER);
          table1.addCell(t1_hiddenCell2);
          table1.completeRow();
          
          //세 번째 줄
          t1_hiddenCell3 = new PdfPCell(new Phrase(" ", font));
          t1_hiddenCell3.setColspan(3);
          t1_hiddenCell3.setBorder(Rectangle.NO_BORDER);
          table1.addCell(t1_hiddenCell3);
          table1.completeRow();
	      

	      
	      return table1;
	   }

	   //------------------------- 참조자 테이블 -------------------------	   
	   private PdfPTable generateTable2(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	        
	            PdfPTable table2 = new PdfPTable(6);
	            
	            table2.setTotalWidth(450f);
	            table2.setLockedWidth(true);
	            
	            // 참조자 label
	            
	            PdfPCell t2_label = new PdfPCell();
	            t2_label = new PdfPCell(new Phrase("참조자",font));
	            t2_label.setHorizontalAlignment(Element.ALIGN_CENTER);
	            
	            table2.addCell(t2_label);
	            
	            
	            // 참조자 이름
	            PdfPCell t2_ref = new PdfPCell();
	            t2_ref.setColspan(5);
	            table2.addCell(t2_ref);

	            
	            return table2;
	         }
	   
	   
	   //------------------------- 휴가신청 테이블 -------------------------	 
	   private PdfPTable generateTable3(ApprovalDoc doc, Font font, Document document, PdfWriter writer,
			   							String label1, String label2) {


          PdfPTable table3 = new PdfPTable(6);
          
          table3.setTotalWidth(450f);
          table3.setLockedWidth(true);
          
          // label #1
   
          PdfPCell t3_cells1 = new PdfPCell();
          t3_cells1 = new PdfPCell(new Phrase(label1,font));
          t3_cells1.setHorizontalAlignment(Element.ALIGN_CENTER);
          t3_cells1.setVerticalAlignment(Element.ALIGN_MIDDLE);
          
          table3.addCell(t3_cells1);
          
          
          // 데이터 #1
          PdfPCell t3_cells2 = new PdfPCell();
          t3_cells2 = new PdfPCell(new Phrase(label2,font));
          t3_cells2.setHorizontalAlignment(Element.ALIGN_CENTER);
          t3_cells2.setVerticalAlignment(Element.ALIGN_MIDDLE);
          t3_cells2.setColspan(2);
          t3_cells2.setFixedHeight(40f);
          table3.addCell(t3_cells2);
	                
          // lable #2
          PdfPCell t3_cells3 = new PdfPCell();
          t3_cells3 = new PdfPCell(new Phrase("이름",font));
          t3_cells3.setHorizontalAlignment(Element.ALIGN_CENTER);
          t3_cells3.setVerticalAlignment(Element.ALIGN_MIDDLE);
          
          table3.addCell(t3_cells3);
          
          // 데이터 #2
          PdfPCell t3_cells4 = new PdfPCell();
          t3_cells4 = new PdfPCell(new Phrase("테스트2",font));
          t3_cells4.setHorizontalAlignment(Element.ALIGN_CENTER);
          t3_cells4.setVerticalAlignment(Element.ALIGN_MIDDLE);
          t3_cells4.setColspan(2);
          table3.addCell(t3_cells4);
	      
	      
	      return table3;
	   }
	   

	   private PdfPTable generateTable4(ApprovalDoc doc, Font font, Document document, PdfWriter writer,
			   							String label1, String label2) {
		   
		  PdfPTable table4 = new PdfPTable(6);
	          
          table4.setTotalWidth(450f);
          table4.setLockedWidth(true);
		   
          PdfPCell t4_cells1 = new PdfPCell();
          t4_cells1 = new PdfPCell(new Phrase(label1,font));
          t4_cells1.setHorizontalAlignment(Element.ALIGN_CENTER);
          t4_cells1.setVerticalAlignment(Element.ALIGN_MIDDLE);
          t4_cells1.setFixedHeight(40f);
          table4.addCell(t4_cells1);
          
          PdfPCell t4_cells2 = new PdfPCell();
          t4_cells2 = new PdfPCell(new Phrase(label2,font));
          t4_cells2.setHorizontalAlignment(Element.ALIGN_CENTER);
          t4_cells2.setVerticalAlignment(Element.ALIGN_MIDDLE);
          t4_cells2.setFixedHeight(40f);
          t4_cells2.setColspan(5);    
          table4.addCell(t4_cells2);
          
		   return table4;
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
		PdfPCell t6_cells = new PdfPCell(new Phrase(doc.getLeave().getLeaveDetail(),font));
		t6_cells.setFixedHeight(200f);
		t6_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
		t6_cells.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table6.addCell(t6_cells);
		
		return table6;
	}
			
}

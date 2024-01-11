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
			
			Font fontTitle = new Font(objBaseFont, 24);
			document.add(new Paragraph("휴가신청서",fontTitle));
					
			  // table #1
	         document.add(generateTable(doc, font, document, writer)); 
	         
	         document.add(new Paragraph(" "));
	         
	         document.add(generateTable2(doc, font, document, writer));
	         
	         document.add(new Paragraph(" "));
	         
	         document.add(generateTable3(doc, font, document, writer));
	         
	         document.add(new Paragraph(" "));
	         
	         document.add( generateTable4(doc, font, document, writer));
	         
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
	

	   private PdfPTable generateTable(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	      
	//------------------------- 결재선 테이블 -------------------------
	   //  t2_label.setBorder(Rectangle.NO_BORDER);
		   
	      PdfPTable table1 = new PdfPTable(6);
	      
	      table1.setTotalWidth(400f);
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

	   //------------------------- 결재선 테이블 -------------------------	   
	   private PdfPTable generateTable2(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	        
	            PdfPTable table2 = new PdfPTable(5);
	            
	            table2.setTotalWidth(400f);
	            table2.setLockedWidth(true);
	            
	            // 참조자 label
	            
	            PdfPCell t2_label = new PdfPCell();
	            t2_label = new PdfPCell(new Phrase("참조자",font));
	            t2_label.setHorizontalAlignment(Element.ALIGN_CENTER);
	            
	            table2.addCell(t2_label);
	            
	            
	            // 참조자 이름
	            PdfPCell t2_ref = new PdfPCell();
	            t2_ref.setColspan(4);
	            table2.addCell(t2_ref);

	            
	            return table2;
	         }
	   
	   
	   //공통사항 테이블
	   private PdfPTable generateTable3(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
	      
	      PdfPTable table3 = new PdfPTable(1);
	      
	      table3.setTotalWidth(500f);
	      
	      PdfPCell t3_cells = new PdfPCell();
	      t3_cells = new PdfPCell(new Phrase("테스트",font));
	      t3_cells.setFixedHeight(200f);
	      t3_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
	      table3.addCell(t3_cells);
	      
	      
	      
	      return table3;
	   }



	//상세 내용 테이블
	private PdfPTable generateTable4(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		PdfPTable table4 = new PdfPTable(1);
		
		table4.setTotalWidth(150f);
		
		// 상세 내용 label
		PdfPCell t4_label = new PdfPCell(new Phrase("상세 내용", font));
		t4_label.setHorizontalAlignment(Element.ALIGN_CENTER);
		t4_label.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table4.addCell(t4_label);
		
		// 상세 내용 content
		PdfPCell t4_cells = new PdfPCell(new Phrase("테스트",font));
		t4_cells.setFixedHeight(300f);
		t4_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
		t4_cells.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table4.addCell(t4_cells);
		
		return table4;
	}
			
}

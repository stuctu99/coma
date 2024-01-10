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
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PdfGenerator {

	public void generateAppr(ApprovalDoc doc, HttpServletResponse response, String fontPath) { 

		try {
			
			Document document = new Document();
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			PdfWriter writer = PdfWriter.getInstance(document, baos);
			
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
			
			document.add(new Paragraph("테스트",font));
			
			document.add(generateTable2(doc, font, document, writer));
			
			document.add(new Paragraph("테스트",font));
			
			document.add(generateTable3(doc, font, document, writer));
			
			document.add(new Paragraph("테스트",font));
			
			document.add(generateTable4(doc, font, document, writer));
			
			document.close();
			
			//다운로드할 파일 이름 설정
			String fileName = "approval.document.pdf";
		
			// HTTP 응답 헤더 설정
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename" + fileName);
			response.setContentLength(baos.size());
			
			// PDF 데이터를 사용자에게 전송
			ServletOutputStream outputStream = response.getOutputStream();
			baos.writeTo(outputStream);
			outputStream.flush();
		
		}catch (DocumentException | IOException e) {
            e.printStackTrace();
        }

	

	}
	
	private PdfPTable generateTable(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		
//------------------------- 결재선 테이블 -------------------------
	
		PdfPTable table1 = new PdfPTable(3);
		
		table1.setTotalWidth(200f);
		table1.setLockedWidth(true);
		
		
		//row #1
		PdfPCell[] t1_cells = new PdfPCell[3];
		
	
		for(int i=0; i < t1_cells.length; i++) {
			t1_cells[i] = new PdfPCell(new Phrase((i + 1) + "번 셀", font));
			t1_cells[i].setHorizontalAlignment(Element.ALIGN_CENTER);
			table1.addCell(t1_cells[i]);
		}
		
		table1.completeRow();
		
		
		//row #2
		PdfPCell[] t1_cells2 = new PdfPCell[3];

		for(int i=0; i < t1_cells2.length; i++) {
			t1_cells2[i] = new PdfPCell(new Phrase((i + 1) + "번 셀", font));
			t1_cells2[i].setFixedHeight(50f);
			t1_cells2[i].setHorizontalAlignment(Element.ALIGN_CENTER);
			t1_cells2[i].setVerticalAlignment(Element.ALIGN_MIDDLE);
			table1.addCell(t1_cells2[i]);
		}
		
		table1.completeRow();
		
		//row #3
		PdfPCell[] t1_cells3 = new PdfPCell[3];
		

		for(int i=0; i < t1_cells3.length; i++) {
			t1_cells3[i] = new PdfPCell(new Phrase((i + 1) + "번 셀", font));
			t1_cells3[i].setHorizontalAlignment(Element.ALIGN_CENTER);
			table1.addCell(t1_cells3[i]);
		}
		
		table1.completeRow();

		
		return table1;
	}

	
	private PdfPTable generateTable2(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		
		//------------------------- 결재선 테이블 -------------------------
			
				PdfPTable table2 = new PdfPTable(4);
				
				table2.setTotalWidth(250f);
				table2.setLockedWidth(true);
				
				// 참조자 label
				
				PdfPCell t2_label = new PdfPCell(new Phrase("참조자",font));
				t2_label.setHorizontalAlignment(Element.ALIGN_CENTER);
				table2.addCell(t2_label);
				
				
				// 참조자 이름
				PdfPCell t2_ref = new PdfPCell();
				t2_ref.setColspan(3);
				table2.addCell(t2_ref);

				
				return table2;
			}

			
private PdfPTable generateTable3(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		PdfPTable table3 = new PdfPTable(1);
		
		table3.setTotalWidth(500f);
		
		PdfPCell t3_cells = new PdfPCell(new Phrase("테스트",font));
		t3_cells.setFixedHeight(100f);
		t3_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
		t3_cells.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table3.addCell(t3_cells);
		
		
		
		return table3;
	}



	private PdfPTable generateTable4(ApprovalDoc doc, Font font, Document document, PdfWriter writer ) {
		
		PdfPTable table4 = new PdfPTable(1);
		
		table4.setTotalWidth(500f);
		
		// 상세 내용 label
		PdfPCell t4_label = new PdfPCell(new Phrase("상세 내용", font));
		t4_label.setHorizontalAlignment(Element.ALIGN_CENTER);
		t4_label.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table4.addCell(t4_label);
		
		// 상세 내용 content
		PdfPCell t4_cells = new PdfPCell(new Phrase("테스트",font));
		t4_cells.setFixedHeight(400f);
		t4_cells.setHorizontalAlignment(Element.ALIGN_CENTER);
		t4_cells.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table4.addCell(t4_cells);
		
		return table4;
	}
			
}

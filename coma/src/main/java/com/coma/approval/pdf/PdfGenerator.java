package com.coma.approval.pdf;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Component;

import com.coma.model.dto.ApprovalDoc;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
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
			PdfWriter.getInstance(document, baos);
			
			document.open();
			
			BaseFont objBaseFont = BaseFont.createFont(fontPath,BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font font = new Font(objBaseFont, 12);
			
			document.add(generateTable(doc, font)); 
			
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
	
	private PdfPTable generateTable(ApprovalDoc doc, Font font) {
		PdfPTable table = new PdfPTable(2);
		
		PdfPCell cell;
		
		cell = new PdfPCell(new Phrase("테스트~", font)); //얘는 인코딩 됨
		cell.setColspan(2);
		table.addCell(cell);
		
		table.addCell("문서 번호"); //얘는 인코딩 안됨
		table.addCell("DOC_248 테스트");

		cell = new PdfPCell(new Phrase("테스트2",font));
		cell.setColspan(2);
		table.addCell(cell);
		
		return table;
	}
}

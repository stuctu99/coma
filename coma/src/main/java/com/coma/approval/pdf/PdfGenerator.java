package com.coma.approval.pdf;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import org.springframework.stereotype.Component;

import com.coma.model.dto.ApprovalDoc;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Component
public class PdfGenerator {

	public void generateAppr(ApprovalDoc doc, String filePath) {
		Document document = new Document();
		
		try {
			PdfWriter.getInstance(document, new FileOutputStream(filePath));

			document.open();
			
			document.add(generateTable(doc)); 
			
			document.close();
			
			
		}catch(FileNotFoundException | DocumentException e) {
			e.printStackTrace();
		}
	}
	
	private PdfPTable generateTable(ApprovalDoc doc) {
		PdfPTable table = new PdfPTable(2);
		
		PdfPCell cell;
		
		cell = new PdfPCell(new Phrase("테스트~"));
		cell.setColspan(2);
		table.addCell(cell);
		
		table.addCell("문서 번호");
		table.addCell("DOC_248");

		cell = new PdfPCell(new Phrase("테스트2"));
		cell.setColspan(2);
		table.addCell(cell);
		
		return table;
	}
}

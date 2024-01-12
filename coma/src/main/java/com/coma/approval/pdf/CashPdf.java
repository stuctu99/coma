package com.coma.approval.pdf;

import org.springframework.stereotype.Component;

import com.coma.model.dto.ApprovalDoc;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Component
public class CashPdf {

	 public PdfPTable generateTable1(ApprovalDoc doc, Font font, Document document, PdfWriter writer, String label, String data) {
		 
		  PdfPTable cashTbl1 = new PdfPTable(6);
		  
		  cashTbl1.setTotalWidth(450f);
		  cashTbl1.setLockedWidth(true);
		  

	       // label #1
	       
	       PdfPCell cash_cell1 = new PdfPCell();
	       cash_cell1 = new PdfPCell(new Phrase(label,font));
	       cash_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
	       cash_cell1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	       
	       cashTbl1.addCell(cash_cell1);
		  
	       // 데이터 #1
	       PdfPCell cash_cell2 = new PdfPCell();
	       cash_cell2 = new PdfPCell(new Phrase(data,font));
	       cash_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
	       cash_cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	       cash_cell2.setColspan(5);
	       cash_cell2.setFixedHeight(40f);
	       cashTbl1.addCell(cash_cell2);
	       
		  
		  return cashTbl1;
	 }
	
}

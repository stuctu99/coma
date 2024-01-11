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
public class LeavePdf{

	  //------------------------- 휴가신청 테이블 -------------------------	 
	   public PdfPTable generateTable3(ApprovalDoc doc, Font font, Document document, PdfWriter writer,
			   							String label1, String data1, String label2, String data2) {


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
       t3_cells2 = new PdfPCell(new Phrase(data1,font));
       t3_cells2.setHorizontalAlignment(Element.ALIGN_CENTER);
       t3_cells2.setVerticalAlignment(Element.ALIGN_MIDDLE);
       t3_cells2.setColspan(2);
       t3_cells2.setFixedHeight(40f);
       table3.addCell(t3_cells2);
	                
       // lable #2
       PdfPCell t3_cells3 = new PdfPCell();
       t3_cells3 = new PdfPCell(new Phrase(label2,font));
       t3_cells3.setHorizontalAlignment(Element.ALIGN_CENTER);
       t3_cells3.setVerticalAlignment(Element.ALIGN_MIDDLE);
       
       table3.addCell(t3_cells3);
       
       // 데이터 #2
       PdfPCell t3_cells4 = new PdfPCell();
       t3_cells4 = new PdfPCell(new Phrase(data2,font));
       t3_cells4.setHorizontalAlignment(Element.ALIGN_CENTER);
       t3_cells4.setVerticalAlignment(Element.ALIGN_MIDDLE);
       t3_cells4.setColspan(2);
       table3.addCell(t3_cells4);
	      
	      
	      return table3;
	   }
	   

	   public PdfPTable generateTable4(ApprovalDoc doc, Font font, Document document, PdfWriter writer,
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
		   
	
}

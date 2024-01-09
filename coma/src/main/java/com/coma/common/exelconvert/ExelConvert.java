package com.coma.common.exelconvert;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.coma.model.dto.Emp;

public class ExelConvert extends AbstractXlsView{
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Emp> empList=(List<Emp>)model.get("empList");
		
		final Sheet sheet1=workbook.createSheet();
		addheader(sheet1,List.of("이름","아이디","성별","생년월일","주소","연락처","입사일","부서","직책"));
		empList.forEach(e->{addContent(sheet1,e);});
		
	}
	
	private void addheader(Sheet sheet, List<String> headerdata) {
		Row header=sheet.createRow(0);
		for(int i=0;i<headerdata.size();i++) {
			header.createCell(i).setCellValue(headerdata.get(i));
		}
	}
	
	private void addContent(Sheet sheet, Emp emp) {
		Row row=sheet.createRow(sheet.getLastRowNum()+1);
		row.createCell(0).setCellValue(emp.getEmpName());
		row.createCell(1).setCellValue(emp.getEmpId());
		row.createCell(2).setCellValue(emp.getEmpGender());
		row.createCell(3).setCellValue(emp.getEmpBrithDate());
		row.createCell(4).setCellValue(emp.getEmpAddr());
		row.createCell(5).setCellValue(emp.getEmpPhone());
		row.createCell(6).setCellValue(emp.getEmpHireDate());
		row.createCell(7).setCellValue(emp.getDept().getDeptType());
		row.createCell(8).setCellValue(emp.getJob().getJobType());
	}
	
}

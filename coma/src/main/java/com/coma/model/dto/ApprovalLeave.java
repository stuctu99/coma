package com.coma.model.dto;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalLeave {

	private String leaveNo;
	private String leaveType;
	private Date leaveStart;
	private Date leaveEnd;
	private String leaveHalf;
	private String leaveDetail;
	private String docNo;
	
	
	   // 문자열을 java.util.Date로 변환하는 메소드 추가
//    public static Date convertStringToSqlDate(String dateString) throws ParseException {
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        java.util.Date utilDate = dateFormat.parse(dateString);
//        return new Date(utilDate.getTime());
//    }
	
}



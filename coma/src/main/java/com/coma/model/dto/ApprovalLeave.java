package com.coma.model.dto;

import java.sql.Date;

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
	private String docNo;

}



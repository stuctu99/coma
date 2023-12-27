package com.coma.approval.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalEtc {

	private String etcNo;
	private String etcDetail;
	private Date etcDate;
	private String docNo;
	
}

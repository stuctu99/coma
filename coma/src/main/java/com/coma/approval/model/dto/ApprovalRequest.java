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
public class ApprovalRequest {

	private String reqNo;
	private String reqDetail;
	private Date reqDate;
	private String docNo;
}

package com.coma.model.dto;

import java.security.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalDoc {

	private String docNo;
	private String docType;
	private String docTitle;
	private Timestamp docDate;
	private Timestamp docCorrectDate;
	private String docProgress;
	private String empId;
}

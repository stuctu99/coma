package com.coma.approval.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalAttachment {

	private String attachNo;
	private String attachOriName;
	private String attachReName;
	private String docNo;
	
}

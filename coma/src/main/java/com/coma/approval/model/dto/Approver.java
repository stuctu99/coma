package com.coma.approval.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Approver {

	private String approverNo;
	private String docNo;
	private String empId;
	private String apprStatus;
	private int apprOrder;
	
}

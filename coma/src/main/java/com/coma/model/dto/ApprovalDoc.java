package com.coma.model.dto;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
//@Component
public class ApprovalDoc {

	private String docNo;
	private String docType;
	private String docTitle;
	private Timestamp docDate;
	private Timestamp docCorrectDate;
	private String docProgress;
	private String empId;
	private String docDetail;
	private int docDiff;
	private ApprovalLeave leave;
	private ApprovalCash cash;
	private ApprovalRequest req;
	private ApprovalEtc etc;
	
	private List<ApprovalAttachment> files;
	
	private List<Approver> approver;
	private List<Referrer> ref;
	

}

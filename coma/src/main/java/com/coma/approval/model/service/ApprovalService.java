package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

public interface ApprovalService {

	
	List<Emp> selectEmpByData(String data);
	
	int insertApproval(ApprovalDoc all);
	
	ApprovalDoc selectAppDoc(Map<String, String> data);
	
	Emp selectEmpById(String empId);

	//ApprovalDoc selectRefByDocNo(String docNo);

	List<Approver> selectApprByDocNo(String docNo);
	
	List<Referrer> selectRefByDocNo(String docNo);
	
	int updateSign(Map<String, String> data);
	
	String getSignByApprId(String arrpId);

	String getStatusByIdAndDocNo(Map<String, String> data2);

	String selectApprStatus(Map<String, String> data3);
	
	Approver selectApprMyturn(String docNo);
	
	int updateThisOrder(Map<String, String> data);
	
	int updateNextOrder(Map<String, String> data);
	
	int updateEndDate(Map<String, String> data);
	
	ApprovalLeave selectLeaveDoc(String docNo);
	
	int updateVacationHalf(String empId);
	
	int updateVacation(Map<String, String> dataL);
	
	String selectWriterByDocNo(String docNo);
	
	int updateProgress(Map<String, String> data);
	
	int updateAllMyturn(Map<String, String> data);
	
	String selectDocType(String docNo);
}

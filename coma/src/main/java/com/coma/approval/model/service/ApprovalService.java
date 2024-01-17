package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

import jakarta.servlet.http.HttpServletResponse;

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
	
	int updateThisOrder(String thisOrder);
	
	int updateNextOrder(String nextOrder);
}

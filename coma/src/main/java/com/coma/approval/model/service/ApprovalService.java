package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Emp;

public interface ApprovalService {

	
	List<Emp> selectEmpByData(String data);
	
	int insertApproval(ApprovalDoc all);
	
	ApprovalDoc selectAppDoc(Map<String, String> data);
	
	void generatePdf(ApprovalDoc doc, String filePath);
	
}

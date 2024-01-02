package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.Emp;

public interface ApprovalService {

	List<Emp> selectEmpListAll();
	
	int insertApproval(Map data);
}

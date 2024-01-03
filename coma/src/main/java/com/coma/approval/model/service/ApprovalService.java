package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.Emp;

public interface ApprovalService {

//	List<Emp> selectEmpListAll();
	
	List<Emp> selectEmpByData(String data);
	
	int insertApproval(Map data);
}

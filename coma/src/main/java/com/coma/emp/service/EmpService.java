package com.coma.emp.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.Emp;

public interface EmpService {
	
	List<Emp> selectEmpAll();
	
	Emp selectEmpById(String empId);

	List<Map> selectEmpId();
}

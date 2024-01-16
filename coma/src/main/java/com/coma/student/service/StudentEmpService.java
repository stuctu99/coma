package com.coma.student.service;

import java.util.List;
import java.util.Map;

public interface StudentEmpService {
	// 경현
	List<Map> selectStudentEmpByEmpId(String loginId);
	List<Map> selectStudentEmpCount(String loginId);
	List<Map> infoStudentEmp(Map<String, Object> stuNo);
	
	int insertStudentByEmployment(String[] employment);
	
}

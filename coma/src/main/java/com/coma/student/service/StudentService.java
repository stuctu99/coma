package com.coma.student.service;

import java.util.List;
import java.util.Map;

public interface StudentService {
	
	List<Map> selectStudentByEmpId(String loginId);
	List<Map> selectStudentByInfo(Map<String, Object> stuNo);
	int insertStudentByAttend(String[] attendance);
	int studentSignificantBystuNo(Map<String, Object> significantData);
	

}

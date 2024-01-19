package com.coma.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface StudentEmpDao {
	//경현
		List<Map> selectStudentEmpByEmpId(SqlSession session, String loginId);
		List<Map> selectStudentEmpCount(SqlSession session, String loginId);
		List<Map> infoStudentEmp(SqlSession session, Map<String, Object> stuNo);
		int insertStudentByEmployment(SqlSession session, String employment);
		
}

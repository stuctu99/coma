package com.coma.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface StudentDao {

	List<Map> selectStudentByEmpId(SqlSession session, String loginId);
	List<Map> selectStudentByInfo(SqlSession session, Map<String, Object> stuNo);
	int insertStudentByAttend(SqlSession session, String attendance);
	
	
}

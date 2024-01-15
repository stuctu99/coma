package com.coma.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDao {
	
	public List<Map> selectStudentByEmpId(SqlSession session, String loginId){
		return session.selectList("student.selectStudentByEmpId",loginId);
	}
	
	public List<Map> selectStudentByInfo(SqlSession session, Map<String, Object> stuNo){
		return session.selectList("student.selectStudentByInfo", stuNo);
	}
}

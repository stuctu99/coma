
package com.coma.student.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDaoImpl implements StudentDao{
	
	public List<Map> selectStudentByEmpId(SqlSession session, String loginId){
		return session.selectList("student.selectStudentByEmpId",loginId);
	}
	
	public List<Map> selectStudentByInfo(SqlSession session, Map<String, Object> stuNo){
		return session.selectList("student.selectStudentByInfo", stuNo);
	}
	
	public int insertStudentByAttend(SqlSession session, String attendance) {
		return session.insert("studentCommute.insertStudentByAttend",attendance);
	}

	//경현
	@Override
	public List<Map> selectStudentEmpByEmpId(SqlSession session, String loginId) {	
		return session.selectList("student.selectStudentEmpByEmpId",loginId);
	}

	@Override
	public int insertStudentByEmployment(SqlSession session, String employment) {
		return session.update("student.insertStudentByEmployment",employment);
	}

	@Override
	public List<Map> infoStudentEmp(SqlSession session, Map<String, Object> stuNo) {
		return session.selectList("student.infoStudentEmp",stuNo);
	}
	
}


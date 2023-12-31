package com.coma.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

@Repository
public class AdminDao {
	
	//사원관련 Dao
	public List<Emp> selectEmpAll(SqlSession session){
		return session.selectList("emp.selectEmpAll");
	}
	
	public int insertEmp(SqlSession session, String userName) {
		return session.insert("emp.insertEmp", userName);
	}
	
	public int deleteEmp(SqlSession session, String userName) {
		return session.update("emp.deleteEmp", userName);
	}
	
	public List<Emp> searchEmp(SqlSession session, Map<String, Object> searchMap){
		return session.selectList("emp.searchData", searchMap);
	}
	
	//학생관련 Dao
	public List<Student> selectStudent(SqlSession session){
		return session.selectList("student.selectStudent");
	}
}

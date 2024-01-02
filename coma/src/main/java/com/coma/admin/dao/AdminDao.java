package com.coma.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

@Repository
public class AdminDao {
	
	//사원관련 Dao
	public List<Emp> selectEmpAll(SqlSession session){
		return session.selectList("emp.selectEmpAll");
	}
	
	public List<Dept> selectDept(SqlSession session) {
		return session.selectList("emp.selectDept");
	}
	
	public int insertEmp(SqlSession session, HashMap<String, Object> empName) {
		return session.insert("emp.insertEmp", empName);
	}
	
	public int deleteEmp(SqlSession session, @RequestBody HashMap<String, Object> empId) {
		return session.update("emp.deleteEmp", empId);
	}
	
	public List<Emp> searchEmp(SqlSession session, Map<String, Object> searchMap){
		return session.selectList("emp.searchData", searchMap);
	}
	
	//학생관련 Dao
	public List<Student> selectStudent(SqlSession session){
		return session.selectList("student.selectStudent");
	}
	public List<Student> searchStudent(SqlSession session, Map<String, Object> searchMap){
		return session.selectList("student.searchStudent",searchMap);
	}
}

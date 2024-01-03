package com.coma.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

@Repository
public class AdminDao {
	
	//사원관련 Dao
	public List<Emp> selectEmpAll(SqlSession session, Map<String, Integer> page){
		int cPage=(Integer)page.get("cPage");
		int numPerpage=(Integer)page.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("emp.selectEmpAll",null,rb);
	}
	
	public int countEmp(SqlSession session) {
		return session.selectOne("emp.countEmp");
	}
	
	public List<Map> countEmpByDept(SqlSession session) {
		return session.selectList("emp.countEmpByDept");
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
	
	public List<Map> studentCountByEmpId(SqlSession session){
		return session.selectList("student.studentCountByEmpId");
	}
}

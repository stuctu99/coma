package com.coma.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.admin.dao.AdminDao;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {
	private final AdminDao dao;
	private final SqlSession session;
	
	//사원관련 서비스
	public List<Emp> selectEmpAll(Map<String, Integer> page){
		return dao.selectEmpAll(session, page);
	}
	
	public int countEmp() {
		return dao.countEmp(session);
	}
	
	public List<Map> countEmpByDept() {
		return dao.countEmpByDept(session);
	}
	
	public int insertEmp(HashMap<String, Object> empName) {
		return dao.insertEmp(session, empName);
	}
	
	public int deleteEmp(@RequestBody HashMap<String, Object> empId) {
		return dao.deleteEmp(session, empId);
	}
	
	public List<Emp> searchEmp(Map<String, Object> searchMap){
		return dao.searchEmp(session, searchMap);
	}
	
	//학생관련 서비스
	public List<Student> selectStudent(){
		return dao.selectStudent(session);
	}
	
	public List<Student> searchStudent(HashMap<String, Object> searchMap){
		return dao.searchStudent(session, searchMap);
	}
	
	public List<Map> studentCountByEmpId(){
		return dao.studentCountByEmpId(session);
	}

}

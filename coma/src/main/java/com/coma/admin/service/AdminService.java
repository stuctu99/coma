package com.coma.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

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
	public List<Emp> selectEmpAll(){
		return dao.selectEmpAll(session);
	}
	
	public int insertEmp(String userName) {
		return dao.insertEmp(session, userName);
	}
	
	public int deleteEmp(String userName) {
		return dao.deleteEmp(session, userName);
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

}

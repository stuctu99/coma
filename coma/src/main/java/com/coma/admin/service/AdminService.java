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
	public List<Emp> selectEmpAllByCurrent(Map<String, Integer> page){
		return dao.selectEmpAllByCurrent(session, page);
	}
	
	public int countEmp() {
		return dao.countEmp(session);
	}
	
	public int countStudentByCom() {
		return dao.countStudentByCom(session);
	}
	
	public int countStudentByEmp() {
		return dao.countStudentByEmp(session);
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
	
	public int countEmpByData(Map<String, Object> searchMap) {
		return dao.countEmpByData(session, searchMap);
	}
	
	//학생관련 서비스
	public List<Student> selectStudent(Map<String, Integer> page){
		return dao.selectStudent(session, page);
	}
	
	public int countStudent() {
		return dao.countStudent(session);
	}
	
	public List<Student> searchStudent(HashMap<String, Object> searchMap){
		return dao.searchStudent(session, searchMap);
	}
	
	public int countStudentByData(HashMap<String, Object> searchMap) {
		return dao.countStudentByData(session, searchMap);
	}
	
	public List<Map> studentCountByEmpId(){
		return dao.studentCountByEmpId(session);
	}
	
	//chart.js 메소드
	public List<Map> charEmpData() {
		return dao.charEmpData(session);
	}
	public List<Map> charStudentData() {
		return dao.charStudentData(session);
	}

}

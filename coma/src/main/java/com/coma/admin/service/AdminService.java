package com.coma.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.admin.dao.AdminDao;
import com.coma.model.dto.Commute;
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
	
//	public List<Map> selectEmpAllByCommute(){
//		return dao.selectEmpAllByCommute(session);
//	}
	
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
	
	public int insertEmp(HashMap<String, Object> empData) {
		return dao.insertEmp(session, empData);
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
	
	public List<Emp> downloadEmpExcel(){
		return dao.downloadEmpExcel(session);
	}
	
	//chart.js 메소드
	public List<Map> charEmpData() {
		return dao.charEmpData(session);
	}
	
	//학생관련 서비스
	public List<Map> selectStudent(Map<String, Integer> page){
		return dao.selectStudent(session, page);
	}
	
	public int countStudent() {
		return dao.countStudent(session);
	}
	
	public List<Map> searchStudent(HashMap<String, Object> searchMap){
		return dao.searchStudent(session, searchMap);
	}
	
	public int countStudentByData(HashMap<String, Object> searchMap) {
		return dao.countStudentByData(session, searchMap);
	}
	
	public List<Map> studentCountByEmpId(){
		return dao.studentCountByEmpId(session);
	}
	
	//학생 수료 자동화 기능
	public List studentByCom() {	//수료 가능한 학생 추리기
		return dao.studentByCom(session);
	}
	
	public int updateStudentByCom(List student) {	//수료 가능한 학생 수료자로 업데이트
		return dao.updateStudentByCom(session, student);
	}
	
	//chart.js 메소드
	public List<Map> charStudentByAtten() {
		return dao.charStudentByAtten(session);
	}
	public List<Map> charStudentByEmp() {
		return dao.charStudentByEmp(session);
	}
	public List<Map> charStudentByCom() {
		return dao.charStudentByCom(session);
	}

}

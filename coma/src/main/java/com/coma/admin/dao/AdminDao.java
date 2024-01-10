package com.coma.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

@Repository
public class AdminDao {
	
	//사원관련 Dao
	public List<Emp> selectEmpAllByCurrent(SqlSession session, Map<String, Integer> page){
		int cPage=(Integer)page.get("cPage");
		int numPerpage=(Integer)page.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("emp.selectEmpAllByCurrent",null,rb);
	}
	
//	public List<Map> selectEmpAllByCommute(SqlSession session){
//		return session.selectList("commute.selectEmpAllByCommute");
//	}
	
	public List<Map> countEmpByDept(SqlSession session) {
		return session.selectList("emp.countEmpByDept");
	}
	
	public int countEmp(SqlSession session) {
		return session.selectOne("emp.countEmp");
	}
	
	public int insertEmp(SqlSession session, HashMap<String, Object> empData) {
		return session.insert("emp.insertEmp", empData);
	}
	
	public int deleteEmp(SqlSession session, @RequestBody HashMap<String, Object> empId) {
		return session.update("emp.deleteEmp", empId);
	}
	
	public List<Emp> searchEmp(SqlSession session, Map<String, Object> searchMap){
		System.out.println(searchMap);
		return session.selectList("emp.searchEmp", searchMap);
	}
	
	public int countEmpByData(SqlSession session, Map<String, Object> searchMap) {
		return session.selectOne("emp.countEmpByData",searchMap);
	}
	
	//chart.js 메소드
	public List<Map> charEmpData(SqlSession session) {
		return session.selectList("coummute.charEmpData");
	}	
	
	
	//학생관련 Dao
	public List<Map> selectStudent(SqlSession session, Map<String, Integer> page){
		int cPage=(Integer)page.get("cPage");
		int numPerpage=(Integer)page.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("student.selectStudent",null,rb);
	}
	
	public int countStudent(SqlSession session) {
		return session.selectOne("student.countStudent");
	}
	
	public List<Map> searchStudent(SqlSession session, Map<String, Object> searchMap){
		int cPage=(int)searchMap.get("cPage");
		int numPerpage=(Integer)searchMap.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("student.searchStudent",searchMap,rb);
	}
	
	public int countStudentByData(SqlSession session, Map<String, Object> searchMap) {
		return session.selectOne("student.countStudentByData",searchMap);
	}
	
	public List<Map> studentCountByEmpId(SqlSession session){
		return session.selectList("student.studentCountByEmpId");
	}
	
	public int countStudentByEmp(SqlSession session) {
		return session.selectOne("student.countStudentByEmp");
	}
	
	public int countStudentByCom(SqlSession session) {
		return session.selectOne("student.countStudentByCom");
	}
	
	//학생 수료 자동화 기능
	public List studentByCom(SqlSession session) {
		return session.selectList("studentCommute.studentByCom");
	}
	
	public int updateStudentByCom(SqlSession session, List student) {
		return session.update("student.updateStudentByCom", student);
	}
	
	//chart.jks 메소드
	public List<Map> charStudentByAtten(SqlSession session) {
		return session.selectList("studentCommute.charStudentByAtten");
	}
	public List<Map> charStudentByEmp(SqlSession session) {
		return session.selectList("studentCommute.charStudentByEmp");
	}
	public List<Map> charStudentByCom(SqlSession session) {
		return session.selectList("studentCommute.charStudentByCom");
	}
}

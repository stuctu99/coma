package com.coma.student.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.student.dao.StudentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentServiceImpl implements StudentService{
	private final StudentDao dao;
	private final SqlSession session;
	
	public List<Map> selectStudentByEmpId(String loginId){
		return dao.selectStudentByEmpId(session, loginId);
	}
	
	public List<Map> selectStudentByInfo(Map<String, Object> stuNo){
		return dao.selectStudentByInfo(session, stuNo);
	}
	
	public int insertStudentByAttend(String[] attendance) {
		int result=0;
		if(attendance!=null&&attendance.length>0) {
			for(String a:attendance)
			result+=dao.insertStudentByAttend(session, a);
		}
		if(result!=attendance.length) throw new IllegalArgumentException("저장되지않음");
		return result;
	}
}

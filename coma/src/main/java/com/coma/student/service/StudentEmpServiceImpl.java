package com.coma.student.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.student.dao.StudentEmpDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentEmpServiceImpl implements StudentEmpService {

	private final StudentEmpDao dao;
	private final SqlSession session;
	
	@Override
	public List<Map> selectStudentEmpByEmpId(String loginId) {		
		return dao.selectStudentEmpByEmpId(session, loginId);
	}

	@Override
	public int insertStudentByEmployment(String[] employment) {
		int result = 0;
		if(employment!=null && employment.length>0) {
			for(String a:employment)
				result+=dao.insertStudentByEmployment(session,a);
		}
		if(result!=employment.length) throw new IllegalArgumentException("저장되지않음");
		return result;
		
	}

	@Override
	public List<Map> infoStudentEmp(Map<String, Object> stuNo) {
		
		return dao.infoStudentEmp(session,stuNo);
	}

	@Override
	public List<Map> selectStudentEmpCount(String loginId) {
		return dao.selectStudentEmpCount(session,loginId);
	}
}

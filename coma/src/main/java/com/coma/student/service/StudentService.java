package com.coma.student.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.student.dao.StudentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentService {
	private final StudentDao dao;
	private final SqlSession session;
	
	public List<Map> selectStudentByEmpId(String loginId){
		return dao.selectStudentByEmpId(session, loginId);
	}
	
	public List<Map> selectStudentByInfo(String stuNo){
		return dao.selectStudentByInfo(session, stuNo);
	}
}

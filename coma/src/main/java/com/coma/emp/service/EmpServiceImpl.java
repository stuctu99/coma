package com.coma.emp.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.emp.dao.EmpDao;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EmpServiceImpl implements EmpService {
	
	private final EmpDao dao;
	private final SqlSession session;
	
	@Override
	public List<Emp> selectEmpAll() {
		return dao.selectEmpAll(session);
	}

	@Override
	public Emp selectEmpById(String empId) {
		// TODO Auto-generated method stub
		return dao.selectEmpById(session, empId);
	}

}

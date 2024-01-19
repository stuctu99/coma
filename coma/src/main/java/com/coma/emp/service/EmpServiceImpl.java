package com.coma.emp.service;

import java.util.List;
import java.util.Map;

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
		System.out.println("service" +empId);
		return dao.selectEmpById(session, empId);
	}

	@Override
	public List<Map> selectEmpId() {
		// TODO Auto-generated method stub
		return dao.selectEmpId(session);
	}

}

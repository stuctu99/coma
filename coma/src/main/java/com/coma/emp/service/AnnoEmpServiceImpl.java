package com.coma.emp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.coma.emp.mapper.EmpMapper;
import com.coma.model.dto.Emp;

@Primary
@Service
public class AnnoEmpServiceImpl implements EmpService{
	
	@Autowired
	private EmpMapper mapper;
	
	@Override
	public List<Emp> selectEmpAll() {
		// TODO Auto-generated method stub
		return mapper.selectEmpAll();
	}

	@Override
	public Emp selectEmpById(String empId) {
		// TODO Auto-generated method stub
		return mapper.selectEmpById(empId);
	}
	
	
}

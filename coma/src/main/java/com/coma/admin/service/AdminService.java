package com.coma.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.admin.dao.AdminDao;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {
	private final AdminDao dao;
	private final SqlSession session;
	
	public List<Emp> selectEmpAll(){
		return dao.selectEmpAll(session);
	}

}

package com.coma.approval.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.approval.model.dao.ApprovalDao;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {

	private final ApprovalDao dao;
	private final SqlSession session;
	
	
	@Override
	public List<Emp> selectEmpByData(String data){
		
		return dao.selectEmpByData(session, data);
		
	}

	
	@Override
	public int insertApproval(ApprovalDoc all) {
		// TODO Auto-generated method stub
		return 0;
	}



}

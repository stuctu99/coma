package com.coma.mypage.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.model.dto.Emp;
import com.coma.mypage.model.dao.MypageDao;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService,CommonService {
	private final MypageDao dao;
	private final SqlSession session;
	
	  @Override
	public int updatetEmp(Emp e) {
		// TODO Auto-generated method stub
		return dao.updatetEmp(session , e);
	}

	@Override
	public Emp selelctDto(String id) {
		// TODO Auto-generated method stub
		return dao.selelctDto(session, id);
	}

	@Override
	public Emp selectEmpAll() {
		// TODO Auto-generated method stub
		return null;
	}
	  
}

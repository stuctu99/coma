package com.coma.mypage.model.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.mypage.model.dao.MypageDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService {
	private final MypageDao dao;
	private final SqlSession session;
	
	  @Override
	public int updateEmp(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return dao.updateEmp(session , emp);
	}


	  
}

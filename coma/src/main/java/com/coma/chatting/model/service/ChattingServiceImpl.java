package com.coma.chatting.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.chatting.model.dao.ChattingDao;
import com.coma.chatting.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChattingServiceImpl implements ChattingService,commonService {
	@Override
	public Emp selectEmpById() {
		// TODO Auto-generated method stub
		return null;
	}


	private final ChattingDao dao;
	private final SqlSession session;
	
	
	@Override
	public List<Emp> selectEmpAll() {
		// TODO Auto-generated method stub
		return dao.selectEmpAll(session);
	}


	@Override
	public List<String> chattingList() {
		// TODO Auto-generated method stub
		return null;
	}

}

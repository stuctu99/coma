package com.coma.commute.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.commute.dao.CommuteDao;
import com.coma.model.dto.Commute;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService {
	private final SqlSession session;
	private final CommuteDao dao;
	
	
	@Override
	public int insertCommute(@RequestBody HashMap<String, Object> empId) {
		// TODO Auto-generated method stub
		return dao.insertCommute(session,empId);
	}
	
	@Override
	public Commute selectCommute(String empId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateClockout(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateStartTime(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEndTime(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}



}

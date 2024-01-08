package com.coma.commute.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.commute.dao.CommuteDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService {
	private final SqlSession session;
	private final CommuteDao dao;
	
	
	@Override
	public int insertCommute(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
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

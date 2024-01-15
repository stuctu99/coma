package com.coma.commute.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.commute.dao.CommuteDao;
import com.coma.model.dto.Calendar;
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
		//return dao.selectCommute(session,empId);
		return dao.selectCommute(session,empId);
	}

	@Override
	public int updateClockout(Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return dao.updateClockout(session,empId);
	}

	@Override
	public int updateStartTime(Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return dao.updateStartTime(session,empId);
	}

	@Override
	public int updateEndTime(Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return dao.updateEndTime(session,empId);
	}

	@Override
	public List<Map> selectCommuteAll(String loginId) {
		// TODO Auto-generated method stub
		return dao.selectCommuteAll(session, loginId);
	}

	@Override
	public int countCommute(String loginId) {
		// TODO Auto-generated method stub
		return dao.countCommute(session, loginId);
	}

	@Override
	public int countSearchCommute(Map <String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.countSearchCommute(session, commute);
	}

	@Override
	public List<Map> searchCommute(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.searchCommute(session,commute);
	}



}

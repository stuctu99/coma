package com.coma.commute.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Commute;
@Repository
public class CommuteDaoImpl implements CommuteDao {

	@Override
	public int insertCommute(SqlSession session, @RequestBody HashMap<String, Object> empId) {
		// TODO Auto-generated method stub
		return session.insert("commute.insertCommute",empId);
	}
	
	@Override
	public Commute selectCommute(SqlSession session, String empId) {
		// TODO Auto-generated method stub
		//System.out.println("dao" +empId);
		return session.selectOne("commute.selectCommute",empId);
	}

	@Override
	public int updateClockout(SqlSession session, Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return session.update("commute.updateClockout",empId);
	}

	@Override
	public int updateStartTime(SqlSession session, Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return session.update("commute.updateStartTime",empId);
	}

	@Override
	public int updateEndTime(SqlSession session, Map<String, Object> empId) {
		// TODO Auto-generated method stub
		return session.update("commute.updateEndTime",empId);
	}



}

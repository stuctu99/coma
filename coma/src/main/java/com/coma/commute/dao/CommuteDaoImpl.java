package com.coma.commute.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Calendar;
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

	@Override
	public List<Map> selectCommuteAll(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectList("commute.selectCommuteAll",loginId);
	}

	@Override
	public int countCommute(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectOne("commute.countCommute",loginId);
	}

	@Override
	public List<Commute> searchCommute(SqlSession session, Map<String, Object> commute) {
		int cPage=(int)commute.get("cPage");
		int numPerpage=(Integer)commute.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("commute.searchCommute",commute,rb);

	}

	@Override
	public int countSearchCommute(SqlSession session,Map <String, Object> commute) {
		// TODO Auto-generated method stub
		return session.selectOne("commute.countSearchCommute",commute);
	}



}

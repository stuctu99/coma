package com.coma.commute.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
@Repository
public class CommuteDaoImpl implements CommuteDao {

	@Override
	public int insertCommute(SqlSession session, Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateClockout(SqlSession session, Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateStartTime(SqlSession session, Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEndTime(SqlSession session, Map<String, Object> emp) {
		// TODO Auto-generated method stub
		return 0;
	}

}

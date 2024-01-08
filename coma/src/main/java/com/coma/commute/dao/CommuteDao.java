package com.coma.commute.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Emp;


public interface CommuteDao {
	//출근시간 찍히기 -> insert
	int insertCommute(SqlSession session, Map <String, Object> emp);
	//퇴근시간 찍히기 ->update
	int updateClockout(SqlSession session, Map <String, Object> emp);
	//외출시작시간찍히기 
	int updateStartTime(SqlSession session, Map <String, Object> emp);
	//외출끝시작찍히기
	int updateEndTime(SqlSession session, Map <String, Object> emp);
}

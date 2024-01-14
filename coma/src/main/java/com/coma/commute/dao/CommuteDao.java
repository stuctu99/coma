package com.coma.commute.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Calendar;
import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;


public interface CommuteDao {
	//출근시간 찍히기 -> insert
	int insertCommute(SqlSession session, @RequestBody HashMap<String, Object> empId);
	//퇴근시간 찍히기 ->update
	int updateClockout(SqlSession session, Map <String, Object> emp);
	//외출시작시간찍히기 
	int updateStartTime(SqlSession session, Map <String, Object> emp);
	//외출끝시작찍히기
	int updateEndTime(SqlSession session, Map <String, Object> emp);
	
	Commute selectCommute(SqlSession session, String empId);
	
	List<Map> selectCommuteAll (SqlSession session, String loginId);
	
	int countCommute(SqlSession session,String loginId);
}

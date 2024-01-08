package com.coma.commute.service;

import java.util.Map;

public interface CommuteService {
	//출근시간 찍히기 -> insert
	int insertCommute(Map <String, Object> emp);
	//퇴근시간 찍히기 ->update
	int updateClockout(Map <String, Object> emp);
	//외출시작시간찍히기 
	int updateStartTime(Map <String, Object> emp);
	//외출끝시작찍히기
	int updateEndTime(Map <String, Object> emp);
	
	
}

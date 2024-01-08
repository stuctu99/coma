package com.coma.commute.service;

import java.util.Map;

public interface CommonService {
	//출근시간 찍히기 -> insert
	int insertCommute(Map <String, Object> emp);
	//퇴근시간 찍히기 ->ipdate
//	int updateClockout(Date clock)
	
}

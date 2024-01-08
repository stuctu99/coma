package com.coma.commute.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import com.coma.model.dto.Commute;

public interface CommuteService {
	//출근시간 찍히기 -> insert
	int insertCommute(@RequestBody HashMap<String, Object> empId);
	//퇴근시간 찍히기 ->update
	int updateClockout(Map <String, Object> emp);
	//외출시작시간찍히기 
	int updateStartTime(Map <String, Object> emp);
	//외출끝시작찍히기
	int updateEndTime(Map <String, Object> emp);
	//나의 근태 조회
	Commute selectCommute(String empId);
}

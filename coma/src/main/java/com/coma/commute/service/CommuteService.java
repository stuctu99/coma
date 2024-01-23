package com.coma.commute.service;


import java.util.List;
import java.util.Map;


import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;

public interface CommuteService {
	//출근시간 찍히기 -> insert
	int updateClockIn (Map <String, Object> emp);
	//퇴근시간 찍히기 ->update
	int updateClockout(Map <String, Object> emp);
	//외출시작시간찍히기 
	int updateStartTime(Map <String, Object> emp);
	//외출끝시작찍히기
	int updateEndTime(Map <String, Object> emp);
	//나의 근태 조회
	Commute selectCommute(String empId);
	//한달동안 나의 근태를 보여줌
	List<Map> selectCommuteAll (Map<String, Object> commute);
	
	int countCommute(String loginId);
	//ajax
	int countSearchCommute(Map <String, Object> commute);
	
	List<Commute> searchCommute (Map <String, Object> commute);
	
	int insertCommuteAll(String empIds);
	
	int updateEmployeeCommute(Map<String, Object> commute);
	
	Emp selectEmpName(String empId);
	
	int updateUncleared();
	
	List<Map> selectCommuteInfo2(String loginId);
	
	
}

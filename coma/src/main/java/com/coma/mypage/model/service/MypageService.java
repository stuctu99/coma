package com.coma.mypage.model.service;

import java.util.List;
import java.util.Map;

public interface MypageService {
	int updateEmp(Map<String, Object> emp);
	int updateEmployeeDetail(Map<String, Object> emp);
	List<Map> selectVacationInfo(Map<String, Object> map);
	int countVacation(String loginId);
}


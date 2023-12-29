package com.coma.mypage.model.service;

import com.coma.mypage.model.dto.EmpWhDto;

public interface MypageService {
	int updatetEmp(EmpWhDto e);
	EmpWhDto selelctDto(String id);
}

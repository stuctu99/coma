package com.coma.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.coma.mypage.model.dto.EmpWhDto;

public interface MypageDao {
	int updatetEmp(SqlSession session, EmpWhDto e);
	EmpWhDto selelctDto(SqlSession session, String id);
}

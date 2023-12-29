package com.coma.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Emp;


public interface MypageDao {
	int updatetEmp(SqlSession session, Emp e);
	Emp selelctDto(SqlSession session, String id);
}

package com.coma.mypage.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Emp;


public interface MypageDao {
	int updateEmp(SqlSession session, Map<String, Object> emp);

}

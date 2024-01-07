package com.coma.mypage.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDaoImpl implements MypageDao  {

	@Override
	public int updateEmp(SqlSession session, Map<String, Object> emp) {
		return session.update("emp.updateEmp" , emp);
	}

	@Override
	public int updateEmployeeDetail(SqlSession session, Map<String, Object> emp) {		
		return session.update("emp.updateEmployeeDetail" , emp);
	}



}

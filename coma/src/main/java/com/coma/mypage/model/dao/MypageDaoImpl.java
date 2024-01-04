package com.coma.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;

@Repository
public class MypageDaoImpl implements MypageDao  {

	@Override
	public int updatetEmp(SqlSession session, Emp e) {
		// TODO Auto-generated method stub
		return session.update("emp.updatetEmp" ,e);
	}

	@Override
	public Emp selelctDto(SqlSession session, String id) {
		// TODO Auto-generated method stub
//		System.out.println(id);
		return session.selectOne("emp.selectEmpById", id);
	}

}

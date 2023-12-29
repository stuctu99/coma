package com.coma.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	@Override
	public List<Emp> selectEmpAll(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("employee.selectEmpAll");
	}

}

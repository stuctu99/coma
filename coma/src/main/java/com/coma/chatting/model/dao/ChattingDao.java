package com.coma.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public interface ChattingDao {
	List<Emp> selectEmpAll(SqlSession session);
}

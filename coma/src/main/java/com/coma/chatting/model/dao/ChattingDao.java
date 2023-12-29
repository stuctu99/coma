package com.coma.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.coma.chatting.model.dto.Emp;

public interface ChattingDao {
	List<Emp> selectEmpAll(SqlSession session);
}

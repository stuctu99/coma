package com.coma.approval.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface ApprovalDao {

	
	int insertApprDoc(SqlSession session, Map data);
	int insertCash(SqlSession session, Map data);
	int insertReq(SqlSession session, Map data);
	int insertEtc(SqlSession session, Map data);
	int insertApprAttach(SqlSession session, Map data);
	int insertApprover(SqlSession session, Map data);
	int insertRef(SqlSession session, Map data);
	
}

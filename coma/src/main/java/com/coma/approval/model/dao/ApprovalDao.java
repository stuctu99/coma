package com.coma.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Emp;

public interface ApprovalDao {

	
	public List<Emp> selectEmpListAll(SqlSession session);
	
	int insertApprDoc(SqlSession session, Map data);
	int insertCash(SqlSession session, Map data);
	int insertReq(SqlSession session, Map data);
	int insertEtc(SqlSession session, Map data);
	int insertApprAttach(SqlSession session, Map data);
	int insertApprover(SqlSession session, Map data);
	int insertRef(SqlSession session, Map data);
	
}

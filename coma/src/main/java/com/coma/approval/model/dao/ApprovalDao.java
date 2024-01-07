package com.coma.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Emp;

public interface ApprovalDao {

	
	List<Emp> selectEmpByData(SqlSession session, String data);
	
	int insertApproval(SqlSession session, ApprovalDoc all);
	
}

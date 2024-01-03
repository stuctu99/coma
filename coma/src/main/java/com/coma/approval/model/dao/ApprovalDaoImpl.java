package com.coma.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;

@Repository
public class ApprovalDaoImpl implements ApprovalDao {

	
	@Override
	public List<Emp> selectEmpByData(SqlSession session, String data){
		
		return session.selectList("emp.selectEmpByData", data);
	}
	
	@Override
	public int insertApprDoc(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertCash(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertReq(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertEtc(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertApprAttach(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertApprover(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertRef(SqlSession session, Map data) {
		// TODO Auto-generated method stub
		return 0;
	}

}

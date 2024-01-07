package com.coma.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Emp;

@Repository
public class ApprovalDaoImpl implements ApprovalDao {

	
	@Override
	public List<Emp> selectEmpByData(SqlSession session, String data){
		
		return session.selectList("emp.selectEmpByData", data);
	}
	
	@Override
	public int insertApproval(SqlSession session, ApprovalDoc all) {
		return 0;
	}

}

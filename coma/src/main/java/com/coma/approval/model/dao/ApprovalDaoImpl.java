package com.coma.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ApprovalAttachment;
import com.coma.model.dto.ApprovalCash;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalEtc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.ApprovalRequest;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

@Repository
public class ApprovalDaoImpl implements ApprovalDao {


	@Override
	public List<Emp> selectEmpByData(SqlSession session, String data){
		
		return session.selectList("emp.selectEmpByData", data);
	}
	
	@Override
	public int insertApprovalDoc(SqlSession session, ApprovalDoc doc) {

		int result = session.insert("approval.insertApprovalDoc", doc);
	
		return result;
	}

	@Override
	public int insertLeave(SqlSession session, ApprovalLeave leave) {

		return session.insert("approval.insertLeave", leave);
	}

	@Override
	public int insertCash(SqlSession session, ApprovalCash cash) {

		return session.insert("approval.insertCash", cash);
	}

	@Override
	public int insertReq(SqlSession session, ApprovalRequest req) {

		return session.insert("approval.insertReq", req);
	}

	@Override
	public int insertEtc(SqlSession session, ApprovalEtc etc) {

		return session.insert("approval.insertEtc",etc);
	}

	@Override
	public int insertAttach(SqlSession session, ApprovalAttachment file) {

		return session.insert("approval.insertAttach", file);
	}

	@Override
	public int insertApprover(SqlSession session, Approver approver) {

		return session.insert("approval.insertApprover", approver);
	}

	@Override
	public int insertRefer(SqlSession session, Referrer ref) {

		return session.insert("approval.insertRefer", ref);
	}


	@Override
	public ApprovalDoc selectAppDoc(SqlSession session, Map<String, String> data) {
		return session.selectOne("approval.selectAppDoc", data);
	}

	@Override
	public Emp selectEmpById(SqlSession session, String empId) {
		return session.selectOne("emp.selectEmpById", empId);
	}

	@Override
	public ApprovalDoc selectRefByDocNo(SqlSession session, String docNo) {
		return session.selectOne("approval.selectRefByDocNo", docNo);
	}

	@Override
	public List<Approver> selectApprByDocNo(SqlSession session, String docNo) {
		return session.selectList("approval.selectApprByDocNo", docNo);
	}

	
	
	
	

}

package com.coma.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ApprovalAttachment;
import com.coma.model.dto.ApprovalCash;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalEtc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.ApprovalRequest;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

public interface ApprovalDao {

	
	List<Emp> selectEmpByData(SqlSession session, String data);
	
	int insertApprovalDoc(SqlSession session, ApprovalDoc doc);
	
	int insertLeave(SqlSession session, ApprovalLeave leave);
	int insertCash(SqlSession session, ApprovalCash cash);
	int insertReq(SqlSession session, ApprovalRequest req);
	int insertEtc(SqlSession session, ApprovalEtc etc);
	
	int insertAttach(SqlSession session, ApprovalAttachment file);
	
	int insertApprover(SqlSession session, Approver approver);
	int insertRefer(SqlSession session, Referrer ref);
	
	
	ApprovalDoc selectAppDoc(SqlSession session, Map<String, String> data);
	
	Emp selectEmpById(SqlSession session, String empId);
	
//	ApprovalDoc selectRefByDocNo(SqlSession session, String docNo);
	
	List<Approver> selectApprByDocNo(SqlSession session, String docNo);
	
	List<Referrer> selectRefByDocNo(SqlSession session, String docNo);
	
	int updateSign(SqlSession session, Map<String, String> data);

}

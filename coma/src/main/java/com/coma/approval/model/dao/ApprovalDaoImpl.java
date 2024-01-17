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
	public List<Approver> selectApprByDocNo(SqlSession session, String docNo) {
		return session.selectList("approval.selectApprByDocNo", docNo);
	}

	@Override
	public List<Referrer> selectRefByDocNo(SqlSession session, String docNo) {
		return session.selectList("approval.selectRefByDocNo", docNo);
	}

	@Override
	public int updateSign(SqlSession session, Map<String, String> data) {
		return session.update("emp.updateSign", data);
	}

	@Override
	public String getSignByApprId(SqlSession session, String arrpId) {
		return session.selectOne("emp.getSignByApprId", arrpId);
	}

	@Override
	public String getStatusByIdAndDocNo(SqlSession session, Map<String, String> data2) {
		return session.selectOne("approval.getStatusByIdAndDocNo", data2);
	}

	@Override
	public String selectApprStatus(SqlSession session, Map<String, String> data3) {
		return session.selectOne("approval.selectApprStatus", data3);
	}

	@Override
	public Approver selectApprMyturn(SqlSession session, String docNo) {
		return session.selectOne("approval.selectApprMyturn", docNo);
	}

	@Override
	public int updateThisOrder(SqlSession session, Map<String, String> data) {
		return session.update("approval.updateThisOrder", data);
	}

	@Override
	public int updateProgress(SqlSession session, Map<String, String> data) {
		return session.update("approval.updateProgress", data);
	}

	@Override
	public int updateNextOrder(SqlSession session, Map<String, String> data) {
		return session.update("approval.updateNextOrder", data);
	}

	@Override
	public int updateEndDate(SqlSession session, Map<String, String> data) {
		return session.update("approval.updateEndDate", data);
	}

	@Override
	public ApprovalLeave selectLeaveDoc(SqlSession session, String docNo) {
		return session.selectOne("approval.selectLeaveDoc", docNo);
	}

	@Override
	public int updateVacationHalf(SqlSession session, String empId) {
		return session.update("emp.updateVacationHalf", empId);
	}

	@Override
	public int updateVacation(SqlSession session, Map<String, String> dataL) {
		return session.update("emp.updateVacation", dataL);
	}

	@Override
	public String selectWriterByDocNo(SqlSession session, String docNo) {
		return session.selectOne("approval.selectWriterByDocNo", docNo);
	}

	@Override
	public int updateAllMyturn(SqlSession session, Map<String, String> data) {
		return session.update("approval.updateAllMyturn", data);
	}
	
	


	

	
	
	
	

}

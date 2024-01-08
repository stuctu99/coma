package com.coma.approval.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.approval.model.dao.ApprovalDao;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {

	private final ApprovalDao dao;
	private final SqlSession session;
	
	
	@Override
	public List<Emp> selectEmpByData(String data){
		
		return dao.selectEmpByData(session, data);
		
	}

	
	@Override
	@Transactional
	public int insertApproval(ApprovalDoc all) {
		int result = dao.insertApprovalDoc(session, all);
		
		//휴가신청서 객체
		//지출결의서 객체
		//품의서 객체
		//기타 문서 객체
		
		System.out.println("공통사항 인서트 결과: "+ result);
		
		
		if(result>0) { // 공통사항 insert 성공했을 때
			
			if(all.getFiles().size()>0) { //파일 리스트에 객체가 있으면
				all.getFiles().forEach(file->{

					file.setDocNo(all.getDocNo()); 
				
					int fileResult = dao.insertAttach(session, file);

					System.out.println("docNo: "+ all.getDocNo());
					System.out.println("파일결과 : "+ fileResult);
					
					if(fileResult==0) throw new RuntimeException("첨부파일 등록 실패");
				});
			}
		}else {
			throw new RuntimeException("첨부파일 등록 실패");
		}
		
	
		
		//결재자 객체 리스트
		
		if(result>0) {
			if(all.getApprover().size()>0) {
				all.getApprover().forEach(appr->{
					appr.setDocNo(all.getDocNo());
					
					int apprResult = dao.insertApprover(session, appr);
					
					System.out.println("결재자 인서트 결과"+apprResult);
					
					if(apprResult==0) throw new RuntimeException("결재자 등록 실패");
					
				});
			}
		}else {
			throw new RuntimeException("결재자 등록 실패");
		}
		
		//참조자 객체 리스트 
		
		if(result>0) {
			if(all.getRef().size()>0) {
				all.getRef().forEach(ref->{
					ref.setDocNo(all.getDocNo());
					
					int refResult = dao.insertRefer(session, ref);
					
					System.out.println("참조자 인서트 결과"+refResult);
					
					if(refResult==0) throw new RuntimeException("참조자 등록 실패");
					
				});
			}
		}else {
			throw new RuntimeException("참조자 등록 실패");
		}
		
		
		//휴가신청서 객체 리스트
		if(all.getLeave()!=null) {
			int leaveResult = dao.insertLeave(session, all.getLeave());
			
			System.out.println("휴가신청서 인서트 결과"+leaveResult);
		}
		
		
		return result;
	}



}

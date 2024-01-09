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
		
		System.out.println("doc result: "+ result);
		
		//휴가신청서 객체
		//지출결의서 객체
		//품의서 객체
		//기타 문서 객체
		
		if(result>0) { // 공통사항 insert 성공했을 때
			
			if(all.getFiles().size()>0) { //파일 리스트에 객체가 있으면
				
				all.getFiles().forEach(file->{

									file.setDocNo(all.getDocNo()); 
								
									int fileResult = dao.insertAttach(session, file);
				
									if(fileResult==0) throw new RuntimeException("첨부파일 등록 실패");
								});
			}
		}else {
			throw new RuntimeException("공통사항 등록 실패");
		}
		
	
		
		
		  //결재자 객체 리스트
		  
		  if(result>0) { 
			  
			  if(all.getApprover().size()>0) {
			  
			  all.getApprover().forEach(appr->{
			  
								  appr.setDocNo(all.getDocNo());
							  
								  int apprResult = dao.insertApprover(session, appr);
							  
							  
								  if(apprResult==0) throw new RuntimeException("결재자 등록 실패");
			  
		  						}); 
				  } 
			}else { 
				throw new RuntimeException("공통사항 등록 실패");
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
				throw new RuntimeException("공통사항 등록 실패");
				}
		 
		
		//휴가신청서 객체
		if(result>0) { 
			if(all.getLeave()!=null) {
				all.getLeave().setDocNo(all.getDocNo()); 
				
				int leaveResult = dao.insertLeave(session, all.getLeave());
				  if(leaveResult==0) throw new RuntimeException("휴가 등록 실패");
				
			}
		}else { 
			throw new RuntimeException("공통사항 등록 실패");
			}
		
		
		//지출결의서 객체
		if(result>0) { 
			if(all.getCash()!=null) {
				all.getCash().setDocNo(all.getDocNo());
				int cashResult = dao.insertCash(session, all.getCash());
				  if(cashResult==0) throw new RuntimeException("지출결의서 등록 실패");
				
			}
		}else { 
			throw new RuntimeException("공통사항 등록 실패");
			}
		
		//품의서 객체
		if(result>0) { 
			if(all.getReq()!=null) {
				
				System.out.println("서비스 품의서 확인: "+ all.getReq().getReqDate());
				all.getReq().setDocNo(all.getDocNo());
				int reqResult = dao.insertReq(session, all.getReq());
				 if(reqResult==0) throw new RuntimeException("품의서 등록 실패");
				
			}
		}else { 
			throw new RuntimeException("공통사항 등록 실패");
			}
		
		//기타 문서 객체
		if(result>0) { 
			if(all.getEtc()!=null) {
				all.getEtc().setDocNo(all.getDocNo());
				int etcResult = dao.insertEtc(session,all.getEtc());
				if(etcResult==0) throw new RuntimeException("기타문서 등록 실패");
			}
		}else { 
			throw new RuntimeException("공통사항 등록 실패");
			}
		
		
		return result;
	}



}

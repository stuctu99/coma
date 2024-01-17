package com.coma.approval.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.approval.model.dao.ApprovalDao;
import com.coma.approval.pdf.PdfGenerator;
import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Approver;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Referrer;

import jakarta.servlet.http.HttpServletResponse;
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
	
	//@Autowired
	//private PdfGenerator pdfGenerator;

	
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

	@Override
	public ApprovalDoc selectAppDoc(Map<String, String> data) {
		
		ApprovalDoc doc = dao.selectAppDoc(session, data);
		
		return doc;
	}

//	@Override
//	public void generatePdf(ApprovalDoc doc, HttpServletResponse response, String fontPath, Emp writer, String imgPath) {
//		PdfGenerator pdfGenerator=new PdfGenerator();
//		pdfGenerator.generatePdf(doc, response, fontPath, writer, imgPath);
//	}

	@Override
	public Emp selectEmpById(String empId) {
		return dao.selectEmpById(session, empId);
	}

//	@Override
//	public ApprovalDoc selectRefByDocNo(String docNo) {
//		return dao.selectRefByDocNo(session, docNo);
//	}

	@Override
	public List<Approver> selectApprByDocNo(String docNo) {
		return dao.selectApprByDocNo(session, docNo);
	}

	@Override
	public List<Referrer> selectRefByDocNo(String docNo) {
		return dao.selectRefByDocNo(session, docNo);
	}

	@Override
	public int updateSign(Map<String, String> data) {
		return dao.updateSign(session, data);
	}

	@Override
	public String getSignByApprId(String arrpId) {
		return dao.getSignByApprId(session, arrpId);
	}

	@Override
	public String getStatusByIdAndDocNo(Map<String, String> data2) {
		return dao.getStatusByIdAndDocNo(session, data2);
	}

	@Override
	public String selectApprStatus(Map<String, String> data3) {
		return dao.selectApprStatus(session, data3);
	}

	@Override
	public Approver selectApprMyturn(String docNo) {
		return dao.selectApprMyturn(session, docNo);
	}

	@Override
	public int updateThisOrder(Map<String, String> data) {
			int result = dao.updateThisOrder(session, data);
		
			if(result==1) { 
				data.put("progress", "진행");
				int result2 = dao.updateProgress(session, data);
				return result2;
			}else return result;
			
	}
	

	@Override
	public int updateNextOrder(Map<String, String> data) {
		return dao.updateNextOrder(session, data);
	}

	@Override
	public int updateEndDate(Map<String, String> data) {
		return dao.updateEndDate(session, data);
	}

	@Override
	public ApprovalLeave selectLeaveDoc(String docNo) {
		return dao.selectLeaveDoc(session, docNo);
	}

	@Override
	public int updateVacationHalf(String empId) {
		return dao.updateVacationHalf(session, empId);
	}

	@Override
	public int updateVacation(Map<String, String> dataL) {
		return dao.updateVacation(session, dataL);
	}

	@Override
	public String selectWriterByDocNo(String docNo) {
		return dao.selectWriterByDocNo(session, docNo);
	}

	@Override
	public int updateProgress(Map<String, String> data) {
		return dao.updateProgress(session, data);
	}

	@Override
	public int updateAllMyturn(Map<String, String> data) {
		return dao.updateAllMyturn(session, data);
	}



	
	

	


}
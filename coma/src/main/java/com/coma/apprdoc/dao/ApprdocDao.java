package com.coma.apprdoc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Board;

public interface ApprdocDao {
	
	
		//진행중인 문서리스트
		List<ApprovalDoc> selectProceedList(SqlSession session, Map<String, Integer> page, String docProgress);
		//문서함 문서리스트
		List<ApprovalDoc> selectDocList(SqlSession session, Map<String, Integer> page, String docProgress);
		//검색기능
		List<ApprovalDoc> searchDoc(SqlSession session, Map<String, Object> doc);
		
		int selectApprCount(SqlSession session, Map<String, Object> pgMap);
}

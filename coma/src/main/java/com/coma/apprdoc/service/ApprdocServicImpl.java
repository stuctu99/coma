package com.coma.apprdoc.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.apprdoc.dao.ApprdocDao;
import com.coma.model.dto.ApprovalDoc;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprdocServicImpl implements ApprdocService {
	
	private final ApprdocDao dao;
	private final SqlSession session;
	
	@Override
	public List<ApprovalDoc> selectProceedList(Map<String, Integer> page, String docProgress) {
		// TODO Auto-generated method stub
		return dao.selectProceedList(session, page, docProgress);
	}

	@Override
	public List<ApprovalDoc> selectDocList(Map<String, Integer> page, String docProgress) {
		// TODO Auto-generated method stub
		return dao.selectDocList(session, page, docProgress);
	}

	@Override
	public List<ApprovalDoc> searchDoc(Map<String, Object> doc) {
		// TODO Auto-generated method stub
		return dao.searchDoc(session, doc);
	}

	@Override
	public int selectApprCount(Map<String, Object> pgMap) {
		// TODO Auto-generated method stub
		return dao.selectApprCount(session, pgMap);
	}

	@Override
	public List<ApprovalDoc> selectMyList(Map<String, Integer> page, Map<String, Object> myMap) {
		// TODO Auto-generated method stub
		return dao.selectMyList(session, page, myMap);
	}
	
	
	
}

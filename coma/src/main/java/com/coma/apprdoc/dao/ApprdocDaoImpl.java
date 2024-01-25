package com.coma.apprdoc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ApprovalDoc;
import com.coma.model.dto.Board;

@Repository
public class ApprdocDaoImpl implements ApprdocDao {

	@Override
	public List<ApprovalDoc> selectProceedList(SqlSession session, Map<String, Integer> page, String docProgress) {
		// TODO Auto-generated method stub
		int cPage=page.get("cPage");
		int numPerpage=page.get("numPerpage");
		RowBounds rb = new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("approval.selectProceedList",docProgress,rb);
	}

	@Override
	public List<ApprovalDoc> selectDocList(SqlSession session, Map<String, Integer> page, String docProgress) {
		int cPage=page.get("cPage");
		int numPerpage=page.get("numPerpage");
		RowBounds rb = new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("approval.selectDocList",docProgress,rb);
	}

	@Override
	public List<ApprovalDoc> searchDoc(SqlSession session, Map<String, Object> doc) {
		int cPage=(int) doc.get("cPage");
		int numPerpage= (int) doc.get("numPerpage");
		RowBounds rb = new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("approval.searchDoc",doc,rb);
	}

	@Override
	public int selectApprCount(SqlSession session, Map<String, Object> pgMap) {
		// TODO Auto-generated method stub
		
		return session.selectOne("approval.selectApprCount",pgMap);
	}

	@Override
	public List<ApprovalDoc> selectMyList(SqlSession session, Map<String, Integer> page,Map<String, Object> myMap) {
		// TODO Auto-generated method stub
		int cPage=page.get("cPage");
		int numPerpage=page.get("numPerpage");
		RowBounds rb = new RowBounds((cPage-1)*numPerpage,numPerpage);
		
		return session.selectList("approval.selectMyList",myMap,rb);
	}

	@Override
	public List<ApprovalDoc> filterDoc(SqlSession session, Map<String, Object> filMap) {
		// TODO Auto-generated method stub
		return session.selectList("approval.selectFilter", filMap);
	}

	@Override
	public List<ApprovalDoc> filterDocAll(SqlSession session, Map<String, Object> filMap) {
		// TODO Auto-generated method stub
		return session.selectList("approval.selectFilterAll", filMap);
	}
	
	
	

	
	
}

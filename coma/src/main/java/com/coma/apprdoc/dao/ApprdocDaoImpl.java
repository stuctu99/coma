package com.coma.apprdoc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ApprovalDoc;

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

	
	
}

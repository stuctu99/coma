package com.coma.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDaoImpl implements MypageDao  {

	@Override
	public int updateEmp(SqlSession session, Map<String, Object> emp) {
		return session.update("emp.updateEmp" , emp);
	}

	@Override
	public int updateEmployeeDetail(SqlSession session, Map<String, Object> emp) {		
		return session.update("emp.updateEmployeeDetail" , emp);
	}
	
	@Override
	public List<Map> selectVacationInfo(SqlSession session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(Integer)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("approval.selectVacationInfo",map,rb);
	}


	@Override
	public int countVacation(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectOne("approval.countVacation",loginId);
	}





}

package com.coma.commute.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;
@Repository
public class CommuteDaoImpl implements CommuteDao {

   @Override
   public int updateClockIn(SqlSession session, Map <String, Object> emp) {
      // TODO Auto-generated method stub
      return session.update("commute.updateClockIn",emp);
   }
   
   @Override
   public Commute selectCommute(SqlSession session, String empId) {
      // TODO Auto-generated method stub
      //System.out.println("dao" +empId);
      return session.selectOne("commute.selectCommute",empId);
   }

   @Override
   public int updateClockout(SqlSession session, Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return session.update("commute.updateClockout",empId);
   }

   @Override
   public int updateStartTime(SqlSession session, Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return session.update("commute.updateStartTime",empId);
   }

   @Override
   public int updateEndTime(SqlSession session, Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return session.update("commute.updateEndTime",empId);
   }

	@Override
	public List<Map> selectCommuteAll(SqlSession session, Map<String, Object> commute) {
		int cPage=(int)commute.get("cPage");
		int numPerpage=(Integer)commute.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("commute.selectCommuteAll",commute , rb);
	}

	@Override
	public int countCommute(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectOne("commute.countCommute",loginId);
	}

	@Override
	public List<Commute> searchCommute(SqlSession session, Map<String, Object> commute) {
		int cPage=(int)commute.get("cPage");
		int numPerpage=(Integer)commute.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage, numPerpage);
		return session.selectList("commute.searchCommute",commute,rb);

	}

	@Override
	public int countSearchCommute(SqlSession session,Map <String, Object> commute) {
		// TODO Auto-generated method stub
		return session.selectOne("commute.countSearchCommute",commute);
	}

	@Override
	public int insertCommuteAll(SqlSession session, String empIds) {
		// TODO Auto-generated method stub
		return session.insert("commute.insertCommuteAll", empIds);
	}

	@Override
	public int updateEmployeeCommute(SqlSession session, Map<String, Object> commute) {
		// TODO Auto-generated method stub
		System.out.println(commute);
		return session.update("commute.updateEmployeeCommute",commute);
	}

	@Override
	public Emp selectEmpName(SqlSession session, String empId) {
		// TODO Auto-generated method stub
		return session.selectOne("emp.selectEmpName",empId);
	}

	@Override
	public int updateUncleared(SqlSession session) {
		// TODO Auto-generated method stub
		return session.update("commute.updateUncleared");
	}

	@Override
	public List<Map> selectCommuteInfo2(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectList("commute.selectCommuteInfo2",loginId);
	}

	@Override
	public int searchCommuteByData(SqlSession session, Map<String, Object> commute) {
		// TODO Auto-generated method stub
		
		return session.selectOne("commute.searchCommuteByData",commute);
	}

	@Override
	public List<Map> selectCommuteAll2(SqlSession session, Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return session.selectList("commute.selectCommuteAll",commute );
	}







}

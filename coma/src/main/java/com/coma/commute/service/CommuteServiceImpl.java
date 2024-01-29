package com.coma.commute.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.commute.dao.CommuteDao;
import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService {
   private final SqlSession session;
   private final CommuteDao dao;
   
   
   @Override
   public int updateClockIn(Map <String, Object> emp) {
      // TODO Auto-generated method stub
      return dao.updateClockIn(session,emp);
   }
   
   @Override
   public Commute selectCommute(String empId) {
      // TODO Auto-generated method stub
      //return dao.selectCommute(session,empId);
      return dao.selectCommute(session,empId);
   }

   @Override
   public int updateClockout(Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return dao.updateClockout(session,empId);
   }

   @Override
   public int updateStartTime(Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return dao.updateStartTime(session,empId);
   }

   @Override
   public int updateEndTime(Map<String, Object> empId) {
      // TODO Auto-generated method stub
      return dao.updateEndTime(session,empId);
   }

	@Override
	public List<Map> selectCommuteAll(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.selectCommuteAll(session, commute);
	}

	@Override
	public int countCommute(String loginId) {
		// TODO Auto-generated method stub
		return dao.countCommute(session, loginId);
	}

	@Override
	public int countSearchCommute(Map <String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.countSearchCommute(session, commute);
	}

	@Override
	public List<Commute> searchCommute(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.searchCommute(session,commute);
	}

	@Override
	public int insertCommuteAll(String empIds) {
		// TODO Auto-generated method stub
		return dao.insertCommuteAll(session,empIds);
	}

	@Override
	public int updateEmployeeCommute(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.updateEmployeeCommute(session,commute);
	}

	@Override
	public Emp selectEmpName(String empId) {
		// TODO Auto-generated method stub
		return dao.selectEmpName(session,empId);
	}

	@Override
	public int updateUncleared() {
		
		return dao.updateUncleared(session);
	}

	@Override
	public List<Map> selectCommuteInfo2(String loginId) {
		// TODO Auto-generated method stub
		return dao.selectCommuteInfo2(session,loginId);
	}

	@Override
	public int searchCommuteByData(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.searchCommuteByData(session,commute);
	}

	@Override
	public List<Map> selectCommuteAll2(Map<String, Object> commute) {
		// TODO Auto-generated method stub
		return dao.selectCommuteAll2(session, commute);
	}







}

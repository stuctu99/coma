package com.coma.mypage.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.coma.emp.dao.EmpDao;
import com.coma.model.dto.Emp;
import com.coma.mypage.model.dao.MypageDao;
import com.coma.security.DBConnectionProvider;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService {
	private final MypageDao dao;
	private final EmpDao empDao;
	private final SqlSession session;
	private final DBConnectionProvider authManager;
	@Override
	public int updateEmp(Map<String, Object> emp) {
		// TODO Auto-generated method stub
		int result=dao.updateEmp(session, emp);
		Emp updateEmp=empDao.selectEmpById(session, (String)emp.get("empId"));
		Authentication auth=authManager.authenticate(
				new UsernamePasswordAuthenticationToken(updateEmp,"updateData",updateEmp.getAuthorities()));
		SecurityContextHolder.getContext().setAuthentication(auth);
		return result;
	}
	@Override
	public int updateEmployeeDetail(Map<String, Object> emp) {
		int result=dao.updateEmployeeDetail(session, emp);
		return result;
	}
	@Override
	public int countVacation(String loginId) {
		// TODO Auto-generated method stub
		return dao.countVacation(session,loginId);
	}
	@Override
	public List<Map> selectVacationInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.selectVacationInfo(session, map);
	}
	 


	  
}

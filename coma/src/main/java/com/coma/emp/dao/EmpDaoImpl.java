package com.coma.emp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;



@Repository
public class EmpDaoImpl implements EmpDao {
	
	@Override
	public List<Emp> selectEmpAll(SqlSession session) {
		return session.selectList("emp.selectEmpAll");
	}

	@Override
	public Emp selectEmpById(SqlSession session, String empId) {
		return session.selectOne("emp.selectEmpById",empId);
	}

	@Override
	public List<Map> selectEmpId(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("emp.selectEmpId");
	}

}

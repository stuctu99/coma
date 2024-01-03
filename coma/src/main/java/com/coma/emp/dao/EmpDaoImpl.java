package com.coma.emp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;


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

}

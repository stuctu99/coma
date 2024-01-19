package com.coma.emp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Emp;

public interface EmpDao {
	//전체조회
	List<Emp> selectEmpAll(SqlSession session);
	
	//empId로조회
	Emp selectEmpById(SqlSession session, String empId);

	List<Map> selectEmpId(SqlSession session);
}

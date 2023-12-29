package com.coma.admin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Repository
public class AdminDao {
	
	public List<Emp> selectEmpAll(SqlSession session){
		return session.selectList("emp.selectEmpAll");
	}
}

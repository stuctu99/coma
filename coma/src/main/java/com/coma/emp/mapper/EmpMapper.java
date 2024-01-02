package com.coma.emp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.coma.model.dto.Emp;

@Mapper
public interface EmpMapper {
	 
	@Select("SELECT * FROM EMP")
	List<Emp> selectEmpAll();
	
	@Select("SELECT * FROM EMP WHERE EMP_ID=#{empId}")
	Emp selectEmpById(String empId);
}

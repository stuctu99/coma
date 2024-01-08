package com.coma.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Student {
	private String stuNo;
	private String stuName;
	private Date stuStartDate;
	private Date stuEndDate;
	private String stuComStatus; //출석 상태  //리스트로 바껴야댈듯
	private String stuEmpStatus; //수료 상태  //리스트로 바껴야댈듯
	private String empId;   //test 이후 객체로 바꿀 예정
	private Date stuBirth;
	private String stuProfile;
}

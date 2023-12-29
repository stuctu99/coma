package com.coma.chatting.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Emp {
	private String empId;
	private String empName;
	private String empGender;
	private Date empBirthdate;
	private Date empHiredate;
	private String empCurrent;
	private String empPhone;
	private int empVacation;
	private String emp_ACCESS;
	private String jobCode;
	private String deptCode;
}

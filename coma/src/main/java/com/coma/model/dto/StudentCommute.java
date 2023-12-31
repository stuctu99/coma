package com.coma.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentCommute {
	private String stuCommuteNo;
	private String stuCommuteStatus;
	private Date stuCommuteDate;
	private Student student; 
}

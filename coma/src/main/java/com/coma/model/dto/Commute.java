package com.coma.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Commute {
	private String commuteNo;
	private String empId;
	private Date commuteClock;
	private Date commuteClockin;
	private Date commuteWorkDate;
	private String commuteStatus;
	private Date commuteStarttime;
	private Date commuteEndtime;
	private String commutelateness;
	private String commuteAbsence;
	
	
}

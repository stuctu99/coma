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
	private String CommuteNo;
	private Date CommuteClock;
	private Date CommuteClockin;
	private Date commuteWorkDate;
	private String CommuteStatus;
	private Date commuteStarttime;
	private Date commuteEndTime;
	
	
}

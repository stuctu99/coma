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
public class Schedule {

	private String schDateNo;
	private String schTitle;
	private String schContent;
	private Date schStart;
	private Date schEnd;
	private String schType;
	private String calNo; //test이후에 수정예정
}

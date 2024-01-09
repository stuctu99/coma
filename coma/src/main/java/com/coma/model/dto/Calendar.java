package com.coma.model.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Calendar {

	private String calNo;
	private String calTitle;
	private String calContent;
	private Timestamp calStart;
	private Timestamp calEnd;
	private String calType;
	private String calColor;
	private List<Emp> empId; 

}

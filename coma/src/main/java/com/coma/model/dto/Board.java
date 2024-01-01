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
public class Board {
	private String boardNo;
	private String empId;
	private String boardTitle;
	private String boardContent;
	private Date boardDate;
	private int boardReadCount;
	private String boardFileCheck;
	private int boardType;
}

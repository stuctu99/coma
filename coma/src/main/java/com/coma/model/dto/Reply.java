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
public class Reply {
	private String replyNo;
	private Board board;
	private String replyContent;
	private Date replyDate;
	private String replyParentNo;
	private Emp emp;
	private int replyLevel;
}

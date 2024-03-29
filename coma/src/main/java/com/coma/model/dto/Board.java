package com.coma.model.dto;

import java.sql.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;

import javax.validation.constraints.NotEmpty;

import javax.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
	private int boardNo;
	private Emp emp;
	private String boardTitle;
	private String boardContent;
	private Date boardDate;
	private int boardReadCount;
	private int boardFileCount;
	private int boardType;
	private int replyCount;
	private List<BoardFile> boardFile;
	
	//검색기능필요 데이터
	private String type;
	private String keyword;
}

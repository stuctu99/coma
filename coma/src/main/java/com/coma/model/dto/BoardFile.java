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
public class BoardFile {
	private String boardFileNo;
	private String boardFileOriname;
	private String boardFileRename;
	private Date boardFileDate;
	
}

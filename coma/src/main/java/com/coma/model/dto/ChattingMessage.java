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
public class ChattingMessage {
	private String chatNo;
	private String chatContent;
	private Date chatCreateDate;
	private Emp empObj; //String empId
	private ChattingRoom roomObj; //String roomNo
}

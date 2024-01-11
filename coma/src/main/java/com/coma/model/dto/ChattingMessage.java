package com.coma.model.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChattingMessage {
	private String type;
	private String chatNo;
	private String chatContent;
	private Timestamp chatCreateDate;
	private String empId; //String empId
	private String roomNo; //String roomNo
	private Emp EmpObj;
	private ChattingRoom roomObj;
}

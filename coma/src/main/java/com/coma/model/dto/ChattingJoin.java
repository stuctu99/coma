package com.coma.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChattingJoin {  
//	private ChattingRoom roomObj;
	private Emp empObj;
//	private String empId;
	private String roomNo;
	private String newJoin;
}

package com.coma.model.dto;

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
	private String empId; //test이후에 수정예정
	private List<Schedule> schedule;
}
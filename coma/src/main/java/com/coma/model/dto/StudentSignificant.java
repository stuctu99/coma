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
public class StudentSignificant {
	private String stuSignificantNo;
	private Student student;
	private String stuSignificantContent;
	private Date stuSignificantDate;
}

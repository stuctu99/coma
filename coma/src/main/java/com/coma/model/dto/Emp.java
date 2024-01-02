package com.coma.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Emp {
   private String empId;
   private String empPw;
   private String empName;
   private String empGender;
   private Date empBrithDate;
   private Date empHireDate;
   private String empCurrent;
   private String empPhone;
   private String empPhoto;
   private int empVacation;
   private String empAccess;
   private Dept dept;
   private Job job;
}

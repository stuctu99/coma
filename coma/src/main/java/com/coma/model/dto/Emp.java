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
   private String empVacation;
   private String empAccess;
   private String jobCode;
   private String deptCode;
   
}

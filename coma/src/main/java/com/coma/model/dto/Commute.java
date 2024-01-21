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
public class Commute {
   private String commuteNo;
   private String empId;
   private Date commuteClockout; //퇴근시간
   private Date commuteClockin; //출근시간
   private Date commuteWorkDate; //출근일
   private String commuteStatus; // 출근상태 (근무중,퇴근)
   private Date commuteStarttime; 
   private Date commuteEndtime;
   private String commutelateness;
   private String commuteAbsence;
   private String breakDuration;
   private String workDuration;
   
   

}
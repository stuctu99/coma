package com.coma.calendar.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Calendar;


public interface CalendarService {

	List<Calendar> selectCalendar();
	List<Calendar> selectCalendarDept(String empId);
	List<Calendar> selectCalendarMy(String empId);
	List<Calendar> selectCalendarAll(String empId);
	List<ApprovalLeave> selectCalendarApproval(String empId);
	int calendarInsert(Map<String,String> event);
	int calendarUpdate(Map<String,String> event);
	int calendarDelete(Map<String,String> event);
	
}

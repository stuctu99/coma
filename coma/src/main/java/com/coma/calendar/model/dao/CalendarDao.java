package com.coma.calendar.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Calendar;
import com.coma.model.dto.Commute;


public interface CalendarDao {

	List<Calendar> selectCalendar(SqlSession session);
	List<Calendar> selectCalendarDept(SqlSession session,Map<String,String> emp);
	List<Calendar> selectCalendarMy(SqlSession session,String empId);
	List<Calendar> selectCalendarAll(SqlSession session,String empId);
	List<ApprovalLeave> selectCalendarApproval(SqlSession session, String empId);
	int calendarInsert(SqlSession session,Map<String,String> event);
	int calendarUpdate(SqlSession session,Map<String,String> event);
	int calendarDelete(SqlSession session,Map<String,String> event);
}

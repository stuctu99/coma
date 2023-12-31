package com.coma.calendar.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Calendar;


public interface CalendarDao {

	List<Calendar> selectCalendar(SqlSession session);
	List<Calendar> selectCalendarDept(SqlSession session,String deptCode);
	int calendarInsert(SqlSession session,Map<String,String> event);
}

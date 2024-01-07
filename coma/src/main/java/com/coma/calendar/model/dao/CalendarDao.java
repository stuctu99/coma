package com.coma.calendar.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Calendar;


public interface CalendarDao {

	List<Calendar> selectCalendar(SqlSession session);
	
}

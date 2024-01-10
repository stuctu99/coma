package com.coma.calendar.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Calendar;


@Repository
public class CalendarDaoImpl implements CalendarDao {


	@Override
	public List<Calendar> selectCalendar(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("calendar.selectCalendar");
	}
	@Override
	public int calendarInsert(SqlSession session, Map<String,String> event) {
		// TODO Auto-generated method stub
		return session.insert("calendar.calendarInsert",event);
	}
	@Override
	public List<Calendar> selectCalendarDept(SqlSession session, String empId) {
		// TODO Auto-generated method stub
		return session.selectList("calendar.selectCalendarDept",empId);
	}
	@Override
	public int calendarUpdate(SqlSession session, Map<String, String> event) {
		// TODO Auto-generated method stub
		return session.update("calendar.calendarUpdate",event);
	}
	@Override
	public int calendarDelete(SqlSession session, Map<String, String> event) {
		// TODO Auto-generated method stub
		return session.delete("calendar.calendarDelete",event);
	}
	
	
}

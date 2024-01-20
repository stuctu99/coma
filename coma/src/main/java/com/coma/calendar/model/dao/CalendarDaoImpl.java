package com.coma.calendar.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Calendar;
import com.coma.model.dto.Commute;


@Repository
public class CalendarDaoImpl implements CalendarDao {


	@Override
	public List<Calendar> selectCalendar(SqlSession session) {
		
		return session.selectList("calendar.selectCalendar");
	}
	@Override
	public int calendarInsert(SqlSession session, Map<String,String> event) {
	
		return session.insert("calendar.calendarInsert",event);
	}
	@Override
	public List<Calendar> selectCalendarDept(SqlSession session, String empId) {
		
		return session.selectList("calendar.selectCalendarDept",empId);
	}
	@Override
	public int calendarUpdate(SqlSession session, Map<String, String> event) {
	
		return session.update("calendar.calendarUpdate",event);
	}
	@Override
	public int calendarDelete(SqlSession session, Map<String, String> event) {
		return session.delete("calendar.calendarDelete",event);
	}
	@Override
	public List<Calendar> selectCalendarMy(SqlSession session, String empId) {
		return session.selectList("calendar.selectCalendarMy",empId);
	}
	@Override
	public List<Calendar> selectCalendarAll(SqlSession session, String empId) {
		return session.selectList("calendar.selectCalendarAll",empId);
	}
	@Override
	public List<ApprovalLeave> selectCalendarApproval(SqlSession session, String empId) {
		return session.selectList("calendar.selectCalendarApproval",empId);
	}

	
}

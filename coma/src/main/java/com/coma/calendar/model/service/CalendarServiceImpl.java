package com.coma.calendar.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.calendar.model.dao.CalendarDao;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Calendar;
import com.coma.model.dto.Commute;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	

	private final CalendarDao dao;
	private final SqlSession session;
	
	@Override
	public List<Calendar> selectCalendar() {
		// TODO Auto-generated method stub
		return dao.selectCalendar(session);
	}
	@Override
	public int calendarInsert(Map<String,String> event) {
		
		return dao.calendarInsert(session,event);
	}
	@Override
	public List<Calendar> selectCalendarDept(String empId) {
	
		return dao.selectCalendarDept(session, empId);
	}
	@Override
	public int calendarUpdate(Map<String, String> event) {
		
		return dao.calendarUpdate(session, event);
	}
	@Override
	public int calendarDelete(Map<String, String> event) {
	
		return dao.calendarDelete(session,event);
	}
	@Override
	public List<Calendar> selectCalendarMy(String empId) {
		
		return dao.selectCalendarMy(session,empId);
	}
	@Override
	public List<Calendar> selectCalendarAll(String empId) {
	
		return dao.selectCalendarAll(session,empId);
	}
	@Override
	public List<ApprovalLeave> selectCalendarApproval(String empId) {
		
		return dao.selectCalendarApproval(session,empId);
	}

	


	

}

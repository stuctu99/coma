package com.coma.calendar.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.calendar.model.dao.CalendarDao;
import com.coma.model.dto.Calendar;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	

	private final CalendarDao dao;
	private final SqlSession session;
	
	@Override
	@Transactional
	public List<Calendar> selectCalendar() {
		// TODO Auto-generated method stub
		return dao.selectCalendar(session);
	}
	@Override
	@Transactional
	public int calendarInsert(Map<String,String> event) {
		// TODO Auto-generated method stub
		return dao.calendarInsert(session,event);
	}
	@Override
	public List<Calendar> selectCalendarDept(String empId) {
		// TODO Auto-generated method stub
		return dao.selectCalendarDept(session, empId);
	}
	@Override
	public int calendarUpdate(Map<String, String> event) {
		// TODO Auto-generated method stub
		return dao.calendarUpdate(session, event);
	}
	@Override
	public int calendarDelete(Map<String, String> event) {
		// TODO Auto-generated method stub
		return dao.calendarDelete(session,event);
	}


	

}

package com.coma.calendar.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.calendar.model.dao.CalendarDao;
import com.coma.model.dto.Calendar;


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


	

}

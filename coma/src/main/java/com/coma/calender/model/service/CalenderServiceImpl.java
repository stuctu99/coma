package com.coma.calender.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.calender.model.dao.CalenderDao;
import com.coma.model.dto.Calender;
import com.coma.model.dto.Schedule;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalenderServiceImpl implements CalenderService {
	
	private final CalenderDao dao;
	private final SqlSession session;
	
	@Override
	public List<Calender> selectCalender() {
		// TODO Auto-generated method stub
		return dao.selectCalender(session);
	}

	@Override
	public List<Schedule> scheduleAll() {
		// TODO Auto-generated method stub
		return dao.scheduleAll(session);
	}
	

}

package com.coma.calendar.model.dao;

import java.util.List;

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

	
}

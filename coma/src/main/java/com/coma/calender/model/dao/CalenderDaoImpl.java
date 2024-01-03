package com.coma.calender.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Calender;
import com.coma.model.dto.Schedule;

@Repository
public class CalenderDaoImpl implements CalenderDao {

	@Override
	public List<Calender> selectCalender(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("calender.selectCalender");
	}

	@Override
	public List<Schedule> scheduleAll(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("schedule.scheduleAll");
	}

}

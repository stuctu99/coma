package com.coma.calender.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Calender;
import com.coma.model.dto.Schedule;

public interface CalenderDao {

	List<Calender> selectCalender(SqlSession session);
	List<Schedule> scheduleAll(SqlSession session);
}

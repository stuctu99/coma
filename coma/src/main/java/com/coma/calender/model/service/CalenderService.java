package com.coma.calender.model.service;

import java.util.List;

import com.coma.model.dto.Calender;
import com.coma.model.dto.Schedule;

public interface CalenderService {

	List<Calender> selectCalender();
	List<Schedule> scheduleAll();
}

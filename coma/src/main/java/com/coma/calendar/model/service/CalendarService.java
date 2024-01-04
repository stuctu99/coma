package com.coma.calendar.model.service;

import java.util.List;

import com.coma.model.dto.Calendar;
import com.coma.model.dto.Schedule;

public interface CalendarService {

	List<Calendar> selectCalendar();
	List<Schedule> scheduleAll();
}

package com.coma.calendar.model.service;

import java.util.List;

import com.coma.model.dto.Calendar;


public interface CalendarService {

	List<Calendar> selectCalendar();
	int calendarInsert(Calendar event);
}

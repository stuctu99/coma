package com.coma.calendar.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.coma.calendar.model.service.CalendarService;
import com.coma.model.dto.Calendar;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@RequestMapping("/calendar")
@RestController
public class CalendarCont {
	
	private final CalendarService service;
	
	
	@PostMapping("/calendarInsert")
	
	public String calendarInsert(@RequestBody Calendar event) {
		System.out.println("제발"+event);
       int result= service.calendarInsert(event);
            return "Event inserted";
      
}
}
package com.coma.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public Map<String,String> calendarInsert(@RequestBody Map<String,String> event) {
//		string을 date로  replace 문자열 치환
		Map<String, String> test = new HashMap<>();
		event.put("calStart",event.get("calStart").replace('T',' '));
		event.put("calEnd",event.get("calEnd").replace('T',' '));
		System.out.println("제발"+event);
       int result= service.calendarInsert(event);
       test.put("msg"," ");
       
            return test;      
}
	@PostMapping("/calendarDept")
	public List<Calendar> selectCalendarDept(@RequestBody String deptCode){
		System.out.println("안녕2");
		return service.selectCalendarDept(deptCode);
	}
}
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

@Controller
@RequiredArgsConstructor
@RequestMapping("/calendar")

public class CalendarController {
	
	private final CalendarService service;
	
	@RequestMapping
	public String calendar() {
		
		return "calendar/calendar";
	}
	@GetMapping("/calendar.do")
	@ResponseBody
	public List<Calendar> selectCalendar(){
		System.out.println("안녕");
		return service.selectCalendar();
	}
//	@PostMapping("/calendarInsert")
//	
//	public String calendarInsert(@RequestBody Calendar data) {
//		System.out.println(data);
//       int result= service.calendarInsert(data);
//            return "redirect:/calendar";
//      
//}
}
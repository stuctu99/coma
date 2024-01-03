package com.coma.calender.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.calender.model.service.CalenderService;
import com.coma.model.dto.Calender;
import com.coma.model.dto.Schedule;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/calender")
public class CalenderController {
	
	private final CalenderService service;
	
	@RequestMapping
	public String calender() {
		
		return "/calender/calender";
	}
	@GetMapping("/calender.do")
	@ResponseBody
	public List<Calender> selectCalender(){
		System.out.println("안녕");
		return service.selectCalender();
	}
//	@GetMapping("/calender.do")
//	@ResponseBody
//	public List<Schedule> scheduleAll(){
//		System.out.println("안녕");
//		return service.scheduleAll();
//	}

}

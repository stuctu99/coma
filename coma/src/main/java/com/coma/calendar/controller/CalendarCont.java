package com.coma.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.coma.calendar.model.service.CalendarService;
import com.coma.model.dto.ApprovalLeave;
import com.coma.model.dto.Calendar;
import com.coma.model.dto.Commute;

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
	@PostMapping("/calendarUpdate")
	public Map<String,String> calendarUpdate(@RequestBody Map<String,String> event){
		Map<String, String> cal = new HashMap<>();
		event.put("calStart", event.get("calStart").replace('T', ' '));
		event.put("calEnd", event.get("calEnd").replace('T', ' '));
		System.out.println("업데이트"+event);
		int result = service.calendarUpdate(event);
		cal.put("msg"," ");
		return cal;
	}
	@PostMapping("/calendarDelete")
	public Map<String,String> calendarDelete(@RequestBody Map<String,String> event){
		System.out.println("밀래 ?"+event.get("calNo"));
		Map<String,String> cal =new HashMap<>();
		int result = service.calendarDelete(event);
		cal.put("msg"," ");
		return cal;
	}
	
	@PostMapping("/calendarDept")
	public List<Calendar> selectCalendarDept(@RequestBody Map<String,String> deptEvent){
		System.out.println("안녕2");
		System.out.println(deptEvent.get("empId"));
		String empId = deptEvent.get("empId");
		return service.selectCalendarDept(empId);
	}
	@PostMapping("/calendarMy")
	public List<Calendar> selectCalendarMy(@RequestBody Map<String,String> deptEvent){
		String empId = deptEvent.get("empId");
		return service.selectCalendarMy(empId);
	}
	@PostMapping("/calendarAll")
	public List<Calendar> selectCalendarAll(@RequestBody Map<String,String> deptEvent){
		String empId = deptEvent.get("empId");
		return service.selectCalendarAll(empId);
	}
	@PostMapping("/calendarApproval")
	public List<ApprovalLeave> selectCalendarApproval(@RequestBody Map<String,String> event){
		String empId = event.get("empId");
	//	System.out.println("내가찾는"+empId);
		System.out.println("내가내가+"+service.selectCalendarApproval(empId));
		
		return service.selectCalendarApproval(empId);
	
	}
}

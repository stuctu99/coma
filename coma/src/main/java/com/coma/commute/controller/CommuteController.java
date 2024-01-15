package com.coma.commute.controller;

import java.security.Principal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.coma.common.pagefactory.PageFactory;
import com.coma.commute.service.CommuteService;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@RequestMapping("/commute")
@Controller
@RequiredArgsConstructor
@Slf4j
public class CommuteController {
	
	private final PageFactory pageFactory;
	private final CommuteService service;
	private final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	//출근 누르면 찍는 메소드
	@PostMapping("/insertCommute")
	@ResponseBody
	public int insertCommute(@RequestBody HashMap<String, Object> empId) {
		//System.out.println(empId);
	    int result = service.insertCommute(empId);
	    //System.out.println("결과"+result);
	    return result;
	}
	//퇴근하면 누르면 찍는 메소드
	@PostMapping("/updateclockout")
	@ResponseBody
	public int updateClockout(@RequestBody HashMap<String, Object> empId) {
		System.out.println(empId);
		int result = service.updateClockout(empId);
	    //System.out.println("결과"+result);
	    return result;
	    
	}
	//외근시작  누르면 찍는 메소드
	@PostMapping("/updatestarttime")
	@ResponseBody
	public int updateStartTime(@RequestBody HashMap<String, Object> empId) {
		System.out.println(empId);
		int result = service.updateStartTime(empId);
	    //System.out.println("결과"+result);
	    return result;
	    
	}
	//외근끝 찍는 메소드
	@PostMapping("/updateEndtime")
	@ResponseBody
	public int updateEndTime(@RequestBody HashMap<String, Object> empId) {
		System.out.println(empId);
		int result = service.updateEndTime(empId);
	    //System.out.println("결과"+result);
	    return result;
	    
	}
	@GetMapping("/MyCommuteInfo")
	public ModelAndView selectCommuteAll(Principal pri) {
		String loginId=pri.getName();
		//System.out.println("아아아 달력에 넣을 정보 "+service.selectCommuteAll(loginId));
		List<Map> commute= service.selectCommuteAll(loginId);
		int count =service.countCommute(loginId);
		
		ModelAndView modelAndView = new ModelAndView("mypage/MyCommuteInfo");
		modelAndView.addObject("count",count);
		modelAndView.addObject("commute",commute);
		return modelAndView;
		
	}
	
	  @GetMapping("/commuteDetail")
	  public String commuteDetail(Principal pri, Model m,@RequestParam(defaultValue="1") int cPage,
				@RequestParam(defaultValue="10") int numPerpage) {
		  String loginId=pri.getName();
		  List<Map> commute= service.selectCommuteAll(loginId);
		  int count =service.countCommute(loginId);
		  m.addAttribute("commute",commute);	
		  m.addAttribute("count",count);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, count, "/mypage/MyvacationInfo"));

		  return "mypage/commuteDetail";
	  }
	  
	  @PostMapping("/commuteDetailEnd")
	  public @ResponseBody Map<String, Object> commuteDetailEnd (@RequestBody Map<String, Object> commute,Principal pri) {
		  String startTime = (String) commute.get("startTime");
		  System.out.println("startTime"+startTime);
		  
		  String loginId=pri.getName();
		  System.out.println(loginId);
		  commute.put("loginId", loginId);
		  
		  int totalData =service.countSearchCommute(commute);
		  List <Map> commuteList = service.searchCommute(commute);
		  List<Map<String, Object>> convertedCommuteList = new ArrayList<>();
		  
		  for (Map<String, Object> commuteMap : commuteList) {
	            Timestamp empCommuteClockin = (Timestamp) commuteMap.get("EMP_COMMUTE_CLOCKIN");
	            Timestamp empCommuteClockout = (Timestamp) commuteMap.get("EMP_COMMUTE_CLOCKOUT");
	            Timestamp empCommuteStarttime = (Timestamp) commuteMap.get("EMP_COMMUTE_STARTTIME");
	            Timestamp empCommuteEndTime = (Timestamp) commuteMap.get("EMP_COMMUTE_ENDTIME");
	            
	            
	            
	            
	            String formattedClockin = convertTimestampToString(empCommuteClockin);
	            String formattedClockout = convertTimestampToString(empCommuteClockout);
	            String formattedStarttime = convertTimestampToString(empCommuteStarttime);
	            String formattedEndTime = convertTimestampToString(empCommuteEndTime);
	            

	            
	            commuteMap.put("EMP_COMMUTE_CLOCKIN", formattedClockin);
	            commuteMap.put("EMP_COMMUTE_CLOCKOUT", formattedClockout);
	            commuteMap.put("EMP_COMMUTE_STARTTIME", formattedStarttime);
	            commuteMap.put("EMP_COMMUTE_ENDTIME", formattedEndTime);
	            convertedCommuteList.add(commuteMap);
	        }
		  
		  
		  return Map.of("commuteList",convertedCommuteList,"pageBar",pageFactory.pageAjax((int)commute.get("cPage"), (int)commute.get("numPerpage"), totalData, "/mypage/commuteDetailEnd",(String)commute.get("jsName")));

	  }
	  private String convertTimestampToString(Timestamp timestamp) {
	        // Apply the desired format
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
	        return dateFormat.format(timestamp);
	    }
	 


	
	
	
	
}

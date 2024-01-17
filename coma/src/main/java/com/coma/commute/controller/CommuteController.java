package com.coma.commute.controller;

import java.security.Principal;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
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
import com.coma.emp.service.EmpService;
import com.coma.model.dto.Commute;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;
@RequestMapping("/commute")
@Controller
@RequiredArgsConstructor
public class CommuteController {
	
	private final CommuteService service;
	private final PageFactory pageFactory;
	
	//private final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	private final EmpService empService;
	

	   //출근 누르면 찍는 메소드
	   @PostMapping("/updateClockIn")
	   @ResponseBody
	   public int updateClockIn(@RequestBody HashMap<String, Object> empId) {
	      //System.out.println(empId);
	       int result = service.updateClockIn(empId);
	       System.out.println("updateClockIn결과"+result);
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
	        List <Commute> commuteList = service.searchCommute(commute);
	          
	        
	        return Map.of("totalData",totalData,"commuteList",commuteList,"pageBar",pageFactory.pageAjax((int)commute.get("cPage"), (int)commute.get("numPerpage"), totalData, "/mypage/commuteDetailEnd",(String)commute.get("jsName")));

	     }
	     
	     //사원 근태 수정하기 페이지 맵핑
	     @GetMapping("/empCommute")
	     public String  empCommute (@RequestParam("empId") String empId, Model m,@RequestParam(defaultValue="1") int cPage,
		            @RequestParam(defaultValue="10") int numPerpage) {
			
	    	List<Map> commute= service.selectCommuteAll(empId);
			int count =service.countCommute(empId);
			m.addAttribute("commute",commute);   
			m.addAttribute("count",count);
			m.addAttribute("empId",empId);
			m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, count, "/mypage/MyvacationInfo"));
			
			return "mypage/empCommute";
	     }
	    //수정하기 
	    @PostMapping("/updateEmployeeCommute")
	 	public String  updateEmployeeCommute (@RequestParam Map<String, Object> commute, Model model) {
	    	System.out.println("여기 왔ㄴ; ??");
	    	System.out.println(commute);
	    	String clockin = (String) commute.get("clockin");
	    	String clockout = (String) commute.get("clockout");
	    	String starttime = (String) commute.get("starttime");
	    	String workdate = (String) commute.get("workdate");
	    	System.out.println(workdate);
	    	int result = service.updateEmployeeCommute(commute);
	    	System.out.println(result);
//	    	String msg, loc;		
//	 		if(result>0) {
//	 			msg="입력성공";
//	 			loc="admin/adminEmp";
//	 		}else {
//	 			Object empId = emp.get("empId");
//	 			msg="입력실패";
//	 			loc = "mypage/EmployeeDetails?empId=" + empId;
//	 			
//	 		}
//	 		model.addAttribute("msg",msg);
//			model.addAttribute("loc",loc);
			return "common/msg";

	     }
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     
	     

	     //월요일부터 금요일까지 아침 9시에 insert되게 
		//@Scheduled(cron = "0 0 9 * * 1-5")
		@GetMapping("/checkInsert") 
		public void checkInsert() {
			List <Map> empIds = empService.selectEmpId();
			for (Map empIdMap : empIds) { 
				String empId =(String) empIdMap.get("EMP_ID"); 
				
				if (empId != null) {
				service.insertCommuteAll(empId);
				
				} 
			}
		}
			 
		
	 


	
	
	
	
}

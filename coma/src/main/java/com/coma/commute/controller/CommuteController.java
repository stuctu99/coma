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
	       int result = service.updateClockIn(empId);
	       return result;
	   }
	   //퇴근하면 누르면 찍는 메소드
	   @PostMapping("/updateclockout")
	   @ResponseBody
	   public int updateClockout(@RequestBody HashMap<String, Object> empId) {
	      int result = service.updateClockout(empId);
	      return result;
	       
	   }
	   //외근시작  누르면 찍는 메소드
	   @PostMapping("/updatestarttime")
	   @ResponseBody
	   public int updateStartTime(@RequestBody HashMap<String, Object> empId) {
	      int result = service.updateStartTime(empId);
	       return result;
	       
	   }
	   //외근끝 찍는 메소드
	   @PostMapping("/updateEndtime")
	   @ResponseBody
	   public int updateEndTime(@RequestBody HashMap<String, Object> empId) {
	      int result = service.updateEndTime(empId);
	       return result;
	       
	   }
	   @GetMapping("/MyCommuteInfo")
	   public ModelAndView selectCommuteAll(Principal pri) {
	      String loginId=pri.getName();
	      List<Map> commute= service.selectCommuteInfo2(loginId);
	      int count =service.countCommute(loginId);
	      ModelAndView modelAndView = new ModelAndView("mypage/MyCommuteInfo");
	      modelAndView.addObject("count",count);
	      modelAndView.addObject("commute",commute);
	      return modelAndView;
	      
	   }
	   //
	     @GetMapping("/commuteDetail")
	     public String commuteDetail(Principal pri, Model m,@RequestParam(defaultValue="1") int cPage,
	            @RequestParam(defaultValue="10") int numPerpage,Map<String, Object> commute) {
	        
	    	String loginId=pri.getName();
	    	commute.put("loginId",loginId);
	    	commute.put("cPage",cPage);
	    	commute.put("numPerpage",numPerpage);
	    	
	        List<Map> commute2= service.selectCommuteAll(commute);
	        int count =service.countCommute(loginId);
	        m.addAttribute("commute",commute2);   
	        m.addAttribute("count",count);
	        m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, count, "/commute/commuteDetail"));

	        return "mypage/commuteDetail";
	     }
	     
	     @PostMapping("/commuteDetailEnd")
	     public @ResponseBody Map<String, Object> commuteDetailEnd (@RequestBody Map<String, Object> commute,Principal pri) {
	        String startTime = (String) commute.get("startTime");
	        
	        String loginId=pri.getName();
	        commute.put("loginId", loginId);
	        
	        int totalData =service.countSearchCommute(commute);
	        List <Commute> commuteList = service.searchCommute(commute);
	        return Map.of("totalData",totalData,"commuteList",commuteList,"pageBar",pageFactory.pageAjax((int)commute.get("cPage"), (int)commute.get("numPerpage"), totalData, "/commute/commuteDetailEnd",(String)commute.get("jsName")));

	     }
	     
	     //사원 근태 수정하기 페이지 맵핑
	     @GetMapping("/empCommute")
	     public String  empCommute (@RequestParam("empId") String empId, Model m,@RequestParam(defaultValue="1") int cPage,
		            @RequestParam(defaultValue="10") int numPerpage,Map<String, Object> commute) {
	    	
	    	commute.put("loginId",empId);
	    	commute.put("cPage",cPage);
	    	commute.put("numPerpage",numPerpage);
	    	List<Map> commute2= service.selectCommuteAll(commute);
			int count =service.countCommute(empId);
			Emp empName = service.selectEmpName(empId);
			m.addAttribute("empName",empName);
			m.addAttribute("commute",commute2);   
			m.addAttribute("count",count);
			m.addAttribute("empId",empId);
			m.addAttribute("pageBar",pageFactory.getPageByWh(cPage, numPerpage, count, "/commute/empCommute", empId));
			
			return "mypage/empCommute";
	     }
	     //ajax 리스트 메소드
	     @PostMapping("/empCommuteEnd")
	     public @ResponseBody Map<String, Object> empCommuteEnd (@RequestBody Map<String, Object> commute,
	    		@RequestParam(defaultValue="1") int cPage,
		        @RequestParam(defaultValue="10") int numPerpage) {	
	    	 
		    commute.put("cPage",cPage);
		    commute.put("numPerpage",numPerpage);
	        int totalData =service.countSearchCommute(commute);
	        List <Commute> commuteList = service.searchCommute(commute); 

	        return Map.of("commuteList",commuteList,"pageBar",pageFactory.pageAjax((int)commute.get("cPage"), (int)commute.get("numPerpage"), totalData, "/commute/empCommuteEnd",(String)commute.get("jsName")));
	     }
	     
	    //수정하기 
	    @PostMapping("/updateEmployeeCommute")
	 	public String  updateEmployeeCommute (@RequestParam Map<String, Object> commute, Model model) {
	    	System.out.println("업데이트하러 들어왓ㄴ: ");
	    	int result = service.updateEmployeeCommute(commute);
	    	String msg, loc;	
	 		if(result>0) {
	 			
	 			msg= "사원 정보가 수정되었습니다!!! ";
	 			loc="admin/adminEmp";
	 		}else {
	 			String empId = (String)commute.get("empId");
	 			msg="사원 정보수정이 실패되었습니다.";
	 			loc = "commute/empCommute?empId=" + empId;
	 		}
	 		model.addAttribute("msg",msg);
			model.addAttribute("loc",loc);
			return "common/msg";
	     }

	  //월요일부터 금요일까지 아침 10시에 퇴근 미처리 update
	    @Scheduled(cron = "0 0 22 * * 1-5")
	//	@GetMapping("/updateUncleared") 
		public void updateUncleared() {
			int result = service.updateUncleared();
		}

	    
		//월요일부터 금요일까지 아침 9시에 insert
		@Scheduled(cron = "0 0 9 * * 1-5")
		//@GetMapping("/checkInsert") 
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

package com.coma.emp.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.coma.board.service.BoardService;
import com.coma.commute.service.CommuteService;
import com.coma.model.dto.Board;
import com.coma.model.dto.Commute;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class EmployeeController {
	
	private final BoardService service;
	private final CommuteService commuteService;
	
//	@PostMapping("/loginsuccess")
//	public String successLogin(Principal data) {
////		log.debug("{}",data);
//		System.out.println(data);
//		return "redirect:/";
//	}
	
	@PostMapping("/loginsuccess")
	public String successLogin(Principal data) {
		log.debug("{}",data);

		
		return "redirect:/";
	}
	
	
	@GetMapping("/")
	public ModelAndView selectMainNotice(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "5") int numPerpage,
										@RequestParam(defaultValue="0") int boardType) {
		
		List<Board> boards = service.selectBoardByType(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
        List<Board> mainNotice = boards.stream().limit(5).collect(Collectors.toList());
        // ***근태 정보 불러오기 ***
        //로그인한 정보에서 아이디 가져오기 
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String empId = authentication.getName();
        //System.out.println("LoggedID: " + empId);
        //오늘 근태 정보 가져오기 
        Commute myCommute = commuteService.selectCommute(empId);
        //System.out.println(myCommute);
        //type이 date이면 날짜빼고 시분초 변경해주기 
//        if (myCommute != null) {
//            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
//            String formattedClockin = myCommute.getCommuteClockin() != null ? dateFormat.format(myCommute.getCommuteClockin()) : null;
//            String formattedStarttime = myCommute.getCommuteStarttime() != null ? dateFormat.format(myCommute.getCommuteStarttime()) : null;
//            String formattedEndtime = myCommute.getCommuteEndtime() != null ? dateFormat.format(myCommute.getCommuteEndtime()) : null;
//            String formattedClockout = myCommute.getCommuteClockout() != null ? dateFormat.format(myCommute.getCommuteClockout()) : null;
//
//            ModelAndView modelAndView = new ModelAndView("index");
//            modelAndView.addObject("mainNotice", mainNotice);
//            modelAndView.addObject("myCommute", myCommute);
//            modelAndView.addObject("formattedClockin", formattedClockin);
//            modelAndView.addObject("formattedStarttime", formattedStarttime);
//            modelAndView.addObject("formattedEndtime", formattedEndtime);
//            modelAndView.addObject("formattedClockout", formattedClockout);
//            return modelAndView;
//            
//        }else {
//        	ModelAndView modelAndView = new ModelAndView("index");
//            modelAndView.addObject("mainNotice", mainNotice);
//            return modelAndView;
//        }
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("mainNotice", mainNotice);
        modelAndView.addObject("myCommute", myCommute);

        return modelAndView;
        
	}
}

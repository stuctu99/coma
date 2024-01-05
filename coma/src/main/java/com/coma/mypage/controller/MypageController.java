package com.coma.mypage.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.coma.mypage.model.service.MypageService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/mypage")
@Controller
@RequiredArgsConstructor
public class MypageController {
	@Autowired
	private final MypageService service;
	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	//나의 상세보기로 화면 전환하는 메소드
	@GetMapping("/mypageDetails")
	public void test() {
	}
	
	//상세보기 수정 메소드
	@PostMapping("/updatemypage")
	public String  updateEmployee(@RequestParam Map<String, Object> emp
								//@RequestParam("upFile") MultipartFile upFile,
								//HttpSession session
								) {
		
		// 프로필 사진 업로드하기 
//		String path = session.getServletContext().getRealPath("/resources/upload/profile");
//		//폴더가 없으면 만들어라! 
//		File dir = new File(path);
//		if (!dir.exists()) {
//			dir.mkdirs(); 
//		}
//		
//		if (upFile != null && !upFile.isEmpty()) {
//			String profilename = upFile.getOriginalFilename();
//
//			try {
//				upFile.transferTo(new File(path, profilename));
//			} catch (IOException e) {
//				e.printStackTrace();
//
//			}
//		}
		
		
		System.out.println(emp);
		int result = service.updateEmp(emp);
		System.out.println(result);
		return "redirect:/";
	}
	
	//인사팀에서 상세보기 
	@GetMapping("/EmployeeDetails")
	public void test2() { }

	
	
}

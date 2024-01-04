package com.coma.mypage.controller;

import java.io.IOException;
import java.util.Map;

import java.io.File;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.coma.mypage.model.service.MypageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/mypage")
@Controller
@RequiredArgsConstructor
public class MypageController {

	private final MypageService service;

	@GetMapping("/mypageDetails")
	public void test() {
	}
	
	
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
	
	@GetMapping("/EmployeeDetails")
	public void test2() { }

}

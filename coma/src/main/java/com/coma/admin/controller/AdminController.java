package com.coma.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.admin.service.AdminService;
import com.coma.common.pagefactory.PageFactory;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Student;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	private final AdminService service;
	private final PageFactory pageFactory;
	//private final BCryptPasswordEncoder passwordEncoder;
	
	//사원관련 컨트롤러
	@GetMapping("/adminEmp")
	public void selectEmpAllByCurrent(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, Model m) {
		List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		int totalData=service.countEmp();
		List<Map> empCount=service.countEmpByDept();
		//chart.js 메소드
		List<Map> chartEmp=service.charEmpData();
		m.addAttribute("emps",emps);
		m.addAttribute("empCount",empCount);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, totalData, "/admin/adminEmp"));
		m.addAttribute("totalEmp",totalData);
	}
	
	//신규 사원 아이디 생성
	@PostMapping("/insertEmp")
	public @ResponseBody List<Emp> insertEmp(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, @RequestBody HashMap<String, Object> empName) {
		//String password=passwordEncoder.encode("1234");
		//empName.put("password", password);
		System.out.println(empName);
		service.insertEmp(empName);
		List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		return emps;
		
	}
	
	
	@PostMapping("/deleteEmp")
	public @ResponseBody List<Emp> deleteEmp(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, @RequestBody HashMap<String, Object> empId) {
		service.deleteEmp(empId);
		List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		return emps;
	}
	
	
	@PostMapping("/searchEmp")
	public @ResponseBody Map<String,Object> searchEmp(@RequestBody HashMap<String, Object> searchMap) {
		List<Emp> emps=service.searchEmp(searchMap);
		int totalData=service.countEmpByData(searchMap);
		return Map.of("emps",emps,"pageBar",pageFactory.pageAjax((int)searchMap.get("cPage"), (int)searchMap.get("numPerpage"), totalData, "/admin/searchEmp"));
	}
	
	//학생관련 컨트롤러
	@GetMapping("/adminStudent")
	public void adminStudent(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, Model m) {
		List<Student> students=service.selectStudent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		int totalData=service.countStudent();
		List<Map> studentCount=service.studentCountByEmpId();
		//chart.js 메소드
		List<Map> chartStudent=service.charStudentData();
		m.addAttribute("students",students);
		m.addAttribute("studentCount",studentCount);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, totalData, "/admin/adminStudent"));
		m.addAttribute("totalStudent",totalData);
	}
	
	
	@PostMapping("/searchStudent")
	public @ResponseBody Map<String,Object> searchStudent(@RequestBody HashMap<String, Object> searchMap){
		List<Student> students=service.searchStudent(searchMap);
		int totalData=service.countStudentByData(searchMap);
		return Map.of("students",students,"pageBar",pageFactory.pageAjax((int)searchMap.get("cPage"), (int)searchMap.get("numPerpage"), totalData, "/admin/searchStudent"));
	}
	
//	//chart.js 메소드
//	@PostMapping("/chartEmp")
//	public @ResponseBody List<Map> charEmpData() {
//		List<Map> chartEmp=service.charEmpData();
//		return null;
//	}
//	@PostMapping("/chartEmp")
//	public @ResponseBody List<Map> charStudentData() {
//		List<Map> chartStudent=service.charStudentData();
//		return null;
//	}

}

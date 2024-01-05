package com.coma.admin.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	private final AdminService service;
	private final PageFactory pageFactory;
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	/*사원관련 컨트롤러*/
	//전체 사원 출력
	@GetMapping("/adminEmp")
	public void selectEmpAllByCurrent(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, Model m) {
		List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));	//전체 사원 데이터 가져오기
		int totalData=service.countEmp();	//전체 사원 수
		List<Map> empCount=service.countEmpByDept();	//각 부서별 인원 수
		
		//chart.js 메소드
		List<Map> chartEmp=service.charEmpData();	//차트에 넣을 사원 근태 데이터
		Gson gson=new Gson();	//Gson 호출
		JsonArray jArray=new JsonArray();	//Gson에서 제공하는 Json배열 호출
		//Iterator<Map> it=chartEmp.iterator();
		Iterator<Map> it=empCount.iterator();	//사원 데이터를 가져오기 위해 iterator<Map>을 생성
		while (it.hasNext()) {	//while 루프를 사용해 hasNext()함수로 데이터가 있는지 확인
		    Map<String, Object> dataMap = it.next();	//next()함수를 통해 데이터를 Map에 대입
		    JsonObject jsonObject = new JsonObject();	//Map 데이터를 JSON 형식으로 변환하기 위해 JsonObject 호출

		    for (Map.Entry<String, Object> entry : dataMap.entrySet()) {	//반복문을 통해 JSON 객체에 속성값 추가
		        jsonObject.addProperty(entry.getKey(), entry.getValue().toString());
		    }

		    jArray.add(jsonObject);	//변환된 JSON객체를 jArray 배열에 추가
		}
		String jsonString = gson.toJson(jArray);	//JSON형식의 문자열로 생성
		m.addAttribute("chartEmpData",jsonString);
		m.addAttribute("emps",emps);
		m.addAttribute("empCount",empCount);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, totalData, "/admin/adminEmp"));
		m.addAttribute("totalEmp",totalData);
	}
	
	//신규 사원 아이디 생성
	@GetMapping("/insertEmp")
	public String insertEmp(@RequestBody HashMap<String, Object> empData) {
		String password=passwordEncoder.encode("1234");	//신규 사원 아이디 생성시 비밀번호 암호화
		empData.put("password", password);
		System.out.println(empData);
		service.insertEmp(empData);
		return "/admin/adminEmp";
		
	}
	
	//퇴사한 사원 처리
	@GetMapping("/deleteEmp")
	public String deleteEmp(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, @RequestBody HashMap<String, Object> empId) {
		service.deleteEmp(empId);
		//List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		return "/admin/adminEmp";
	}
	
	//사원 검색
	@PostMapping("/searchEmp")
	public @ResponseBody Map<String,Object> searchEmp(@RequestBody HashMap<String, Object> searchMap) {
		List<Emp> emps=service.searchEmp(searchMap);
		int totalData=service.countEmpByData(searchMap);
		return Map.of("emps",emps,"pageBar",pageFactory.pageAjax((int)searchMap.get("cPage"), (int)searchMap.get("numPerpage"), totalData, "/admin/searchEmp"));
	}
	
	/*학생관련 컨트롤러*/
	//전체 학생 출력
	@GetMapping("/adminStudent")
	public void adminStudent(@RequestParam(defaultValue="1") int cPage, @RequestParam(defaultValue="10") int numPerpage, Model m) {
		List<Student> students=service.selectStudent(Map.of("cPage",cPage,"numPerpage",numPerpage));	//전체 학생 데이터 출력
		int totalData=service.countStudent();	//전체 학생 수 출력
		int studentComStatusData=service.countStudentByCom();	//수교한 학생 수 출력
		int studentEmpStatusData=service.countStudentByEmp();	//취업한 학생 수 출력
		List<Map> studentCount=service.studentCountByEmpId();
		
		//chart.js 메소드
		List<Map> chartStudent=service.charStudentData();	//전체 학생 출결 데이터 출력
		Gson gson=new Gson();	//Gson객체 호출
		JsonArray jArray=new JsonArray();	//Gson에서 제공하는 Json배열 호출
		//Iterator<Map> it=chartStudent.iterator();
		Iterator<Map> it=studentCount.iterator();	//학생 데이터를 가져오기 위해 iterator<Map>을 생성
		while (it.hasNext()) {	//while 루프를 사용해 hasNext()함수로 데이터가 있는지 확인
		    Map<String, Object> dataMap = it.next();	//next()함수를 통해 데이터를 Map에 대입
		    JsonObject jsonObject = new JsonObject();	//Map 데이터를 JSON 형식으로 변환하기 위해 JsonObject 호출

		    for (Map.Entry<String, Object> entry : dataMap.entrySet()) {	//반복문을 통해 JSON 객체에 속성값 추가
		        jsonObject.addProperty(entry.getKey(), entry.getValue().toString());
		    }

		    jArray.add(jsonObject);	//변환된 JSON객체를 jArray 배열에 추가
		}
		String jsonString = gson.toJson(jArray);	//JSON형식의 문자열로 생성
		m.addAttribute("chartStudentData",jsonString);
		m.addAttribute("students",students);
		m.addAttribute("studentCount",studentCount);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, totalData, "/admin/adminStudent"));
		m.addAttribute("studentComStatusData",studentComStatusData);
		m.addAttribute("studentEmpStatusData",studentEmpStatusData);
		m.addAttribute("totalStudent",totalData);
	}
	
	//학생 수료 자동화 기능
	@Scheduled(cron = "0 0 18 1 ?")
	public void updateStudentByCom() {
		int result=service.updateStudentByCom();
	}
	
	//학생 검색 기능
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

package com.coma.admin.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import com.coma.model.dto.Commute;
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
		//List<Map> empCommutes=service.selectEmpAllByCommute();	//사원 근태 형황 데이터 가져오기
		Map<String, Object> empData= new HashMap<>();	
		empData.put("emps", emps);	//전체 사원 데이터 Map
		//empData.put("commutes",empCommutes);	//사원 근태 현황 Map-
		int totalData=service.countEmp();	//전체 사원 수
		List<Map> empCount=service.countEmpByDept();	//각 부서별 인원 수
		
		//chart.js 메소드
		//List<Map> chartEmp=service.charEmpData();	//차트에 넣을 사원 근태 데이터
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
	@PostMapping("/insertEmp")
	public @ResponseBody int insertEmp(@RequestBody HashMap<String, Object> empData) {
		String password=passwordEncoder.encode("1234");	//신규 사원 아이디 생성시 비밀번호 암호화
		empData.put("password", password);
		int ressult=service.insertEmp(empData);	
		return ressult;
		
	}
	
	//퇴사한 사원 처리
	@PostMapping("/deleteEmp")
	public @ResponseBody int deleteEmp(@RequestBody HashMap<String, Object> empId) {
		int resutl=service.deleteEmp(empId);
		//List<Emp> emps=service.selectEmpAllByCurrent(Map.of("cPage",cPage,"numPerpage",numPerpage));
		return resutl;
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
		List<Map> students=service.selectStudent(Map.of("cPage",cPage,"numPerpage",numPerpage));	//전체 학생 데이터 출력
		int totalData=service.countStudent();	//전체 학생 수 출력
		List<Map> studentCount=service.studentCountByEmpId();
		int studentComStatusData=service.countStudentByCom();	//수교한 학생 수 출력
		int studentEmpStatusData=service.countStudentByEmp();	//취업한 학생 수 출력
		m.addAttribute("students",students);
		m.addAttribute("pageBar",pageFactory.getPage(cPage, numPerpage, totalData, "/admin/adminStudent"));
		m.addAttribute("studentCount",studentCount);
		m.addAttribute("studentComStatusData",studentComStatusData);
		m.addAttribute("studentEmpStatusData",studentEmpStatusData);
		m.addAttribute("totalStudent",totalData);
		

		//chart.js 메소드
		//학생 출석률 Data
		List<Map> studentAttence=service.charStudentByAtten();	//전체 학생 출결 데이터 출력
		Gson gson=new Gson();	//Gson객체 호출
		JsonArray jArray2=new JsonArray();	//Gson에서 제공하는 Json배열 호출
		Iterator<Map> sa=studentAttence.iterator(); //학생 데이터를 가져오기 위해 iterator<Map>을 생성
		while (sa.hasNext()) {	//while 루프를 사용해 hasNext()함수로 데이터가 있는지 확인
			Map<String, Object> dataMap = sa.next();	//next()함수를 통해 데이터를 Map에 대입
			JsonObject jsonObject = new JsonObject();	//Map 데이터를 JSON 형식으로 변환하기 위해 JsonObject 호출
			
			for (Map.Entry<String, Object> entry : dataMap.entrySet()) {	//반복문을 통해 JSON 객체에 속성값 추가
				jsonObject.addProperty(entry.getKey(), entry.getValue().toString());
			}
			
			jArray2.add(jsonObject);	//변환된 JSON객체를 jArray 배열에 추가
		}
		String jsonSa = gson.toJson(jArray2);	//JSON형식의 문자열로 생성
		m.addAttribute("studentAttence",jsonSa);
		
		//학생 수료율 Data
		List<Map> studentByCom=service.charStudentByCom();
		JsonArray jArray3=new JsonArray();	//Gson에서 제공하는 Json배열 호출
		Iterator<Map> sbc=studentByCom.iterator(); //학생 데이터를 가져오기 위해 iterator<Map>을 생성
		while (sbc.hasNext()) {	//while 루프를 사용해 hasNext()함수로 데이터가 있는지 확인
			Map<String, Object> dataMap = sbc.next();	//next()함수를 통해 데이터를 Map에 대입
			JsonObject jsonObject = new JsonObject();	//Map 데이터를 JSON 형식으로 변환하기 위해 JsonObject 호출
			
			for (Map.Entry<String, Object> entry : dataMap.entrySet()) {	//반복문을 통해 JSON 객체에 속성값 추가
				jsonObject.addProperty(entry.getKey(), entry.getValue().toString());
			}
			
			jArray3.add(jsonObject);	//변환된 JSON객체를 jArray 배열에 추가
		}
		String jsonSbc = gson.toJson(jArray3);	//JSON형식의 문자열로 생성
		m.addAttribute("studentByCom",jsonSbc);
		m.addAttribute("studentByComTable",studentByCom);
		
		//학생 취업율 Data
		List<Map> studentByEmp=service.charStudentByEmp();
		JsonArray jArray4=new JsonArray();	//Gson에서 제공하는 Json배열 호출
		Iterator<Map> sbe=studentByEmp.iterator(); //학생 데이터를 가져오기 위해 iterator<Map>을 생성
		while (sbe.hasNext()) {	//while 루프를 사용해 hasNext()함수로 데이터가 있는지 확인
			Map<String, Object> dataMap = sbe.next();	//next()함수를 통해 데이터를 Map에 대입
			JsonObject jsonObject = new JsonObject();	//Map 데이터를 JSON 형식으로 변환하기 위해 JsonObject 호출
			
			for (Map.Entry<String, Object> entry : dataMap.entrySet()) {	//반복문을 통해 JSON 객체에 속성값 추가
				jsonObject.addProperty(entry.getKey(), entry.getValue().toString());
			}
			
			jArray4.add(jsonObject);	//변환된 JSON객체를 jArray 배열에 추가
		}
		String jsonSbe = gson.toJson(jArray4);	//JSON형식의 문자열로 생성
		m.addAttribute("studentByEmp",jsonSbe);
		m.addAttribute("studentByEmpTable",studentByEmp);
		
	}
	
	//학생 수료 자동화 기능
	@Scheduled(cron = "0 0 18 1 ?")
	public void updateStudentByCom() {
		List student=service.studentByCom();
		service.updateStudentByCom(student);
	}
	
	//학생 검색 기능
	@PostMapping("/searchStudent")
	public @ResponseBody Map<String,Object> searchStudent(@RequestBody HashMap<String, Object> searchMap){
		List<Map> students=service.searchStudent(searchMap);
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

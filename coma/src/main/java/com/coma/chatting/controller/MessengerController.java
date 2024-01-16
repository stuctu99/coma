package com.coma.chatting.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.chatting.model.service.MessengerService;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingRoomType;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/messenger")
@RequiredArgsConstructor
public class MessengerController {
	private final MessengerService service;
	
	@GetMapping
	public String MessengerOpen(Model model) {
		List<Emp> emp = service.selectEmpListAll();
		List<Dept> dept = service.selectDept();
		model.addAttribute("emp", emp);
		model.addAttribute("dept", dept);
		
		/* 조회 데이터 확인용
		 * for (Emp e : emp) { System.out.println(e); }
		 *System.out.println(dept);
		*/
		return "chat/chat";
	}
	
	
	//변수명 수정하기
	@GetMapping("/init/{loginId}")
	@ResponseBody
	public Map<String,Object> initButton(@PathVariable String loginId){
		Map<String,Object> test = new HashMap<>();
		List<ChattingPrivateRoom> data = service.selectPrivateChatJoinInfo(loginId);
		test.put("test", data);
		return test;
	}

	/*
	 * @GetMapping("/roomlist")
	 * 
	 * @ResponseBody public List<ChattingRoom> chatRoomList() { return
	 * service.selectRoomList(); }
	 */
	
	@GetMapping("/roomlist/{type}/{loginId}")
	@ResponseBody
	public Map<String,Object> chatRoomListByType(@PathVariable String type, @PathVariable String loginId){
		Map<String,String> searchInfo = Map.of("type",type,"loginId",loginId);
		List<ChattingRoom> roomList = service.selectChatRoomListByType(searchInfo);
		List<String> joinRoom = service.selectMyJoinRoomById(loginId);
		//변수명 수정 필요
		List<ChattingPrivateRoom> privateRoomList = service.selectPrivateChatJoinInfo(loginId);
		Map<String,Object> roomInfo = new HashMap<String,Object>();
		
		roomInfo.put("roomList",roomList);
		roomInfo.put("joinRoom", joinRoom);
		roomInfo.put("privateRoom", privateRoomList);
		System.out.println("원하는 데이터 출력 "+joinRoom);
		return roomInfo;
	}

	@PostMapping("/createRoom")
	@ResponseBody
	public Map<String, Object> createRoom(@RequestBody Map<String, String> roomInfo) {
		
		ChattingRoom room = new ChattingRoom();
		ChattingRoomType roomType = new ChattingRoomType();
		room.setRoomName(roomInfo.get("roomName"));
		room.setRoomPassword(roomInfo.get("roomPassword"));
		room.setRoomPasswordFlag(roomInfo.get("roomPasswordFlag"));

		roomType.setRoomType(roomInfo.get("roomType"));
		room.setRoomTypeObj(roomType);
		room.setRoomPasswordFlag(roomInfo.get("roomPasswordFlag"));
		
		if(roomInfo.get("targetId").equals("")) {
			room.setIdList(Map.of("empId",roomInfo.get("empId")));
		}else {
			room.setIdList(Map.of("empId",roomInfo.get("empId"),"targetId",roomInfo.get("targetId")));
			
		}
		System.out.println(roomInfo);
//		int alreadyExistFlag = service.selectCountPrivateRoomCheck();
		int result = service.insertChattingRoom(room);
		Map<String, Object> data = new HashMap<>();
		if(result>0) {
			data.put("result", "success");
			data.put("roomNo", service.selectNowCreateChatRoomNo());
		}else {
			data.put("result", "fail");
		}

		return data;
	}

	@PostMapping("/passwordCheck")
	@ResponseBody
	public Map<String, Object> checkPassword(@RequestBody Map<String, String> roomInfo) {
		Map<String, Object> data = new HashMap<String, Object>();
		System.out.println(roomInfo);
		ChattingRoom room = service.passwordCheck(roomInfo);

		Boolean flag = false;

		if (room != null) {
			flag = true;
			data.put("flag", flag);
			data.put("room", room);
		} else {
			data.put("flag", flag);
			data.put("msg", "비밀번호가 틀렸습니다.");
		}
		System.out.println(room);

		return data;
	}
	
	@DeleteMapping
	@ResponseBody
	public Map<String,String> deleteChatRoomInfoByRoomNo(@RequestBody String[] roomNo){
		System.out.println(roomNo);
		Map<String,String> result = new HashMap<>();
		List<String> delRoomList = Arrays.asList(roomNo);
		int delResult = service.deleteChatRoomInfoByRoomNo(delRoomList);
		if(delResult>0) {
			result.put("result", "success");
		}else {
			result.put("result","fail");
		}
		
		return result;
		
	}

}
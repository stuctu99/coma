package com.coma.chatting.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.chatting.model.service.MessengerService;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingRoomType;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

import jakarta.servlet.http.HttpServletRequest;
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

		/*
		 * 조회 데이터 확인용 for (Emp e : emp) { System.out.println(e); }
		 * System.out.println(dept);
		 */
		return "chat/chat";
	}

	// 변수명 수정하기
	@GetMapping("/init/{loginId}")
	@ResponseBody
	public Map<String, Object> initButton(@PathVariable String loginId) {
		Map<String, Object> param = new HashMap<>();
		List<ChattingPrivateRoom> data = service.selectPrivateChatJoinInfo(loginId);
		param.put("proom", data);
		return param;
	}

	@GetMapping("/room/{roomNo}")
	@ResponseBody
	public ChattingRoom selectRoomByRoomNo(@PathVariable String roomNo) {
		ChattingRoom room = service.selectRoomByRoomNo(roomNo); 
		return room;
	}

	@GetMapping("/roomlist/{loginId}")
	@ResponseBody
	public Map<String, Object> chatRoomListByType(@PathVariable String loginId) {
		Map<String, String> searchInfo = Map.of("loginId", loginId);
		List<ChattingRoom> roomList = service.selectChatRoomList(searchInfo);
		List<ChattingJoin> joinRoom = service.selectMyJoinRoomById(loginId);
		// 변수명 수정 필요
		List<ChattingPrivateRoom> privateRoomList = service.selectPrivateChatJoinInfo(loginId);
		Map<String, Object> roomInfo = new HashMap<String, Object>();

		roomInfo.put("roomList", roomList);
		roomInfo.put("joinRoom", joinRoom);
		roomInfo.put("privateRoom", privateRoomList);
		return roomInfo;
	}

	@GetMapping("/message/{roomNo}")
	@ResponseBody
	public String recentChattingMessageByRoomNo(@PathVariable String roomNo) {
		return service.selectRecentChattingMessageByRoomNo(roomNo);
	}
	
	@PostMapping("/alarm")
	@ResponseBody
	public Map<String,Object> selectInviteInfo(@RequestBody Map<String,String> inviteInfo){
		return service.selectInviteInfo(inviteInfo);
		
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

		if (roomInfo.get("targetId").equals("")) {
			room.setIdList(Map.of("empId", roomInfo.get("empId")));
		} else {
			room.setIdList(Map.of("empId", roomInfo.get("empId"), "targetId", roomInfo.get("targetId")));

		}
		System.out.println(roomInfo);
//		int alreadyExistFlag = service.selectCountPrivateRoomCheck();
		String roomNo = service.insertChattingRoom(room);
		Map<String, Object> data = new HashMap<>();
		if (roomNo!=null) {
			data.put("result", "success");
			data.put("roomNo", roomNo);
		} else {
			data.put("result", "fail");
		}

		return data;
	}

	@PostMapping("/passwordCheck")
	@ResponseBody
	public Map<String, Object> checkPassword(@RequestBody Map<String, String> roomInfo) {
		Map<String, Object> data = new HashMap<String, Object>();
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

	@PutMapping("/update/{roomNo}")
	@ResponseBody
	public Map<String, String> inviteCreateChatRoom(@PathVariable String roomNo, @RequestBody ChattingRoom room) {
		List<String> inviteEmpList = new ArrayList<String>(Arrays.asList(room.getInviteEmp()));
		Map<String, Object> inviteInsertInfo = new HashMap<String, Object>();
		
		
		room.setRoomNo(roomNo);
		inviteInsertInfo.put("room", room);
		inviteInsertInfo.put("roomNo", roomNo);
		inviteInsertInfo.put("inviteEmpList", inviteEmpList);
		int inviteInsertCheck = service.insertInviteEmpAndUpdate(inviteInsertInfo);
		if (inviteInsertCheck > 0) {
			return Map.of("result", "success");
		}

		return Map.of("result", "fail");
	}

	@DeleteMapping
	@ResponseBody
	public Map<String, String> deleteChatRoomInfoByRoomNo(@RequestBody String[] roomNo) {
		System.out.println(roomNo);
		Map<String, String> result = new HashMap<>();
		List<String> delRoomList = Arrays.asList(roomNo);
		int delResult = service.deleteChatRoomInfoByRoomNo(delRoomList);
		if (delResult > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}

		return result;

	}

}
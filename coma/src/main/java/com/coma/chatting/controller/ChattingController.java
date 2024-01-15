package com.coma.chatting.controller;

import java.util.ArrayList;
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

import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chatting")
@RequiredArgsConstructor
public class ChattingController {
	private final ChattingService service;
	public static Map<String, List<String>> roomMember = new HashMap<String, List<String>>();
	public static List<String> empList = new ArrayList<String>();

//	채팅방 접속 사원 정보 조회
	@GetMapping("/{empId}")
	@ResponseBody
	public Emp selectEmpByEmpId(@PathVariable String empId) {
		return service.selectEmpByEmpId(empId);

	}

//	채팅방 뷰 전환
	@GetMapping("/room/{roomNo}")
	public String chattingStart(@PathVariable String roomNo, Model model) {
		// 채팅 방 정보 + 로그인 세션 아이디 DB저장하기
		// Map으로 service or dao에서 한번에 처리하기
		List<ChattingMessage> chatMsg = service.selectChatMessageByRoomNo(roomNo);
		ChattingRoom room = service.selectRoomByRoomNo(roomNo);
		List<Emp> roomMemberList = service.selectRoomMemberList(roomNo);
		model.addAttribute("roomMemberList", roomMemberList);
		model.addAttribute("room", room);
		model.addAttribute("chatMsg", chatMsg);
		model.addAttribute("empList", empList);
		return "chat/chatView";
	}

//	채팅방 입장 시 입장 인원 insert
	@PostMapping
	@ResponseBody
	public boolean checkJoinEmp(@RequestBody Map<String, String> joinInfo) {
		int insertResult = 0;
		boolean enterCheck = false;

		empList.add(joinInfo.get("empId"));
		roomMember.put(joinInfo.get("roomNo"), empList);

		System.out.println("이걸로 활용할 수 있을까?" + empList);
		System.out.println("[채팅방입장]조회할 정보:" + joinInfo);
		ChattingJoin joinCheck = service.selectCheckJoin(joinInfo);
		System.out.println("[채팅방입장]조회결과 : " + joinCheck);
		if (joinCheck == null) {
			insertResult = service.insertJoinEmp(joinInfo);
			if (insertResult > 0) {
				enterCheck = true;
			} else {
				enterCheck = false;
			}
		} else {
			enterCheck = true;
		}

		return enterCheck;
	}

//	채팅방 신규접속 여부 체크 및 신규접속Flag 업데이트
	@PutMapping
	@ResponseBody
	public Map<String, Object> selectNewEmpCheck(@RequestBody Map<String, String> newEmpCheck) {
		Map<String, Object> roomInfo = new HashMap<String, Object>();

		ChattingJoin newJoinCheck = service.selectCheckJoin(newEmpCheck);
		ChattingJoin joinEmp = null;

		if (newJoinCheck.getNewJoin().equals("Y")) {
			joinEmp = service.selectJoinCheckByEmpId(newEmpCheck);
			if (joinEmp.getNewJoin().equals("Y")) {
				int result = service.updateChatNewJoin(newEmpCheck);
				if (result > 0) {
					roomInfo.put("joinEmp", joinEmp);
					return roomInfo;
				}
			}
		}

		return roomInfo;

	}

//	채팅방 완전 가갔을 때 정보 삭제
//	채팅방 인원 1명이 나갔을 때 채팅방 삭제하기 구현해야한다.
	@DeleteMapping
	@ResponseBody
	public Map<String, String> deleteChatRoomJoinEmpById(@RequestBody Map<String, String> exitEmp) {
		Map<String, String> msg = new HashMap<>();

		int deleteEmpCheck = service.deleteChatRoomJoinEmpById(exitEmp);
		if (deleteEmpCheck > 0) {
			int roomMeberCount = service.selectMemberCountInRoom(exitEmp.get("roomNo"));
			if (roomMeberCount == 0) {
				int result = service.deleteChattingMsgByRoomNo(exitEmp);
				if (result > 0) {
					System.out.println(exitEmp.get("roomNo") + "채탕방 완전 삭제");
					roomMember.remove(exitEmp.get("roomNo"));
				}
			}

			msg.put("result", "success");
			System.out.println("채팅방 리스트에서 삭제!!!");
		} else {
			msg.put("result", "fail");
			System.out.println("채팅방 리스트 삭제 실패!!!");
		}

		return msg;
	}

	@DeleteMapping("/back")
	@ResponseBody
	public Map<String, String> memberCheckOut(@RequestBody Map<String, String> data) {
		List<String> list = roomMember.get(data.get("roomNo"));
		System.err.println(list + " 채팅방 남은 인원 : " + data.get("empId"));

		list.remove(data.get("empId"));
		data.put("result", "success");
		return data;
	}
}

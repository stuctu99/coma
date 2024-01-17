package com.coma.chatting.controller;

import java.util.HashMap;
import java.util.Iterator;
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
	public static Map<String, Map<String, String>> roomMember = new HashMap<String, Map<String, String>>();
	public static Map<String, String> empList = new HashMap<String, String>();

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
		model.addAttribute("roomMember", roomMember.get(roomNo));
		return "chat/chatView";
	}

	@GetMapping("/memberlist/{roomNo}")
	@ResponseBody
	public Map<String, Object> selectMemberlistByRoomNo(@PathVariable String roomNo) {
		List<Emp> roomMemberList = service.selectRoomMemberList(roomNo);

		return Map.of("roomMemberList", roomMemberList, "roomMemberCheck", roomMember.get(roomNo));
	}

//	채팅방 입장 시 입장 인원 insert
	@PostMapping
	@ResponseBody
	public boolean checkJoinEmp(@RequestBody Map<String, String> joinInfo) {
		int insertResult = 0;
		boolean enterCheck = false;

		if (roomMember.containsKey(joinInfo.get("roomNo"))) {
			empList = roomMember.get(joinInfo.get("roomNo"));
			empList.put(joinInfo.get("empId"), joinInfo.get("empId"));
			roomMember.put(joinInfo.get("roomNo"), empList);
		} else {
			empList = new HashMap<String, String>();
			empList.put(joinInfo.get("empId"), joinInfo.get("empId"));
			roomMember.put(joinInfo.get("roomNo"), empList);
		}

		System.err.println("이걸로 활용할 수 있을까?" + empList);
		System.err.println("방정보가 나오려나?" + roomMember);
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
				System.err.println(exitEmp.get("roomNo") + "방에 남은 인원 : " + roomMeberCount);
				int result = service.deleteChattingMsgByRoomNo(exitEmp);
				if (result > 0) {
					roomMember.remove(exitEmp.get("roomNo"));
					System.out.println(exitEmp.get("roomNo") + "채탕방 완전 삭제");
					Iterator<Map.Entry<String, Map<String, String>>> entries = roomMember.entrySet().iterator();
					while (entries.hasNext()) {
						System.err.println("확인데이터" + entries.next());
					}

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
	public Map<String, Boolean> memberCheckOut(@RequestBody Map<String, String> data) {
		Map<String, Boolean> check = new HashMap<>();
		Map<String, String> memberlist = roomMember.get(data.get("roomNo"));
		memberlist.remove(data.get("empId"));

		System.err.println(" 채팅방 남은 인원 : " + memberlist);
		check.put("result", true);
		return check;
	}

}

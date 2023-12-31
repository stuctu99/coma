package com.coma.chatting.controller;

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
	
	
	/*
	 * @GetMapping("/{empId}")
	 * 
	 * @ResponseBody public Emp selectEmpByEmpId(@PathVariable String empId) {
	 * return service.selectEmpByEmpId(empId);
	 * 
	 * }
	 */
	
	
	
	@PostMapping
	@ResponseBody
	public boolean checkJoinEmp(@RequestBody Map<String,String> joinInfo) {
		int insertResult = 0;
		boolean enterCheck = false;
		System.out.println("[채팅방입장]조회할 정보:"+joinInfo);
		ChattingJoin joinCheck = service.selectCheckJoin(joinInfo);
		System.out.println("[채팅방입장]조회결과 : "+joinCheck);
		if(joinCheck==null) {
			insertResult = service.insertJoinEmp(joinInfo);
			if(insertResult>0) {
				enterCheck = true;
			}else {
				enterCheck = false;
			}
		}else {
			enterCheck = true;
		}
		
		return enterCheck;
	}
	
	@GetMapping("/room/{roomNo}")
	public String chattingStart(@PathVariable String roomNo, Model model) {
		//채팅 방 정보 + 로그인 세션 아이디 DB저장하기
		//Map으로 service or dao에서 한번에 처리하기
		List<ChattingJoin> roomMemberList = service.selectRoomMemberList(roomNo);
		List<ChattingMessage> chatMsg = service.selectChatMessageByRoomNo(roomNo);
		ChattingRoom room = service.selectRoomByRoomNo(roomNo);
		System.out.println(roomNo);
		model.addAttribute("room", room);
		model.addAttribute("roomMemberList", roomMemberList);
		model.addAttribute("chatMsg",chatMsg);
		return "chat/chatView";
	}
	
	@DeleteMapping
	@ResponseBody
	public Map<String,String> deleteChatRoomJoinEmpById(@RequestBody Map<String,String> data) {
		Map<String,String> msg = new HashMap<>();
		int result = service.deleteChatRoomJoinEmpById(data);
		if(result>0) {
			msg.put("result", "success");
			System.out.println("채팅방 리스트에서 삭제!!!");
		}else {
			msg.put("result", "fail");
			System.out.println("채팅방 리스트 삭제 실패!!!");
		}
		
		return msg;
	}
}

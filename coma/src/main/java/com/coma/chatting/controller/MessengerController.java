package com.coma.chatting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coma.chatting.model.service.MessengerService;
import com.coma.model.dto.ChattingRoom;
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
		model.addAttribute("dept",dept);
		for(Emp e : emp) {
			System.out.println(e);
		}
		System.out.println(dept);
		return "chat/chat"; 
	}
	
	@GetMapping("/roomlist")
	@ResponseBody
	public List<ChattingRoom> chatRoomList(){
		return service.selectRoomList();
	}
	
	@PostMapping
	public String createRoom(@ModelAttribute ChattingRoom room) {
		if(room.getRoomPasswordFlag()!=null) {
			room.setRoomPasswordFlag("Y");
		}else {
			room.setRoomPasswordFlag("N");
		}
		System.out.println(room);
		int result = service.insertChattingRoom(room);
		return "redirect:/messenger";
	}
	
	@PostMapping("/passwordCheck")
	@ResponseBody
	public Map<String, Object> checkPassword(@RequestBody Map<String,String> roomInfo) {
		Map<String,Object> data = new HashMap<>();
		System.out.println(roomInfo);
		ChattingRoom room = service.passwordCheck(roomInfo);
		
		Boolean flag = false;
		
		if(room!=null) {
			flag = true;
			data.put("flag", flag);
			data.put("room", room);
		}else {
			data.put("flag", flag);
			data.put("msg", "비밀번호가 틀렸습니다.");
		}
		System.out.println(room);
		
		return data;
	}
	
}

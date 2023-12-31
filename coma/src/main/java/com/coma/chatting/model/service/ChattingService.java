package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

public interface ChattingService {
	ChattingJoin selectCheckJoin(Map<String,String> joinInfo);
	List<ChattingJoin> selectRoomMemberList(String roomNo);
	List<ChattingMessage> selectChatMessageByRoomNo(String roomNo);
	ChattingRoom selectRoomByRoomNo(String roomNo);
	Emp selectEmpByEmpId(String empId);
	
	int insertJoinEmp(Map<String,String> joinInfo);
	int insertChattingMessage(List<ChattingMessage> msgPackages); 
	/* int insertChattingMessage(ChattingMessage msg); */
	
	 
	int deleteChatRoomJoinEmpById(Map<String,String> data);
	
}

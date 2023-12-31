package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface MessengerService {
	List<Emp> selectEmpListAll();
	List<Dept> selectDept();
	List<ChattingRoom> selectRoomList();
	int insertChattingRoom(ChattingRoom room);
	ChattingRoom passwordCheck(Map<String,String> roomInfo);
	List<ChattingRoom> selectChatRoomListByType(String type);
	
}

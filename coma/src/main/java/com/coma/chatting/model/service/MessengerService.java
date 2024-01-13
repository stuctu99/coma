package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface MessengerService {
	List<Emp> selectEmpListAll();
	List<Dept> selectDept();
	List<ChattingRoom> selectRoomList();
	List<String> selectMyJoinRoomById(String loginId);
	String selectNowCreateChatRoomNo();
	List<ChattingRoom> selectChatRoomListByType(Map<String,String> searchInfo);
	List<ChattingPrivateRoom> selectPrivateChatJoinInfo(String loginId);
	
	ChattingRoom passwordCheck(Map<String,String> roomInfo);
	int insertChattingRoom(ChattingRoom room);
	
	int deleteChatRoomInfoByRoomNo(List<String> roomList);
}

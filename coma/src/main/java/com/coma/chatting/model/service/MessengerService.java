package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface MessengerService {
	List<Emp> selectEmpListAll();
	List<Dept> selectDept();
	List<ChattingRoom> selectRoomList();
	List<ChattingJoin> selectMyJoinRoomById(String loginId);
	List<ChattingRoom> selectChatRoomList(Map<String,String> searchInfo);
	List<ChattingPrivateRoom> selectPrivateChatJoinInfo(String loginId);
	String selectRecentChattingMessageByRoomNo(String roomNo);
	Emp selectEmpByTargetId(String targetId);
	ChattingRoom selectRoomByRoomNo(String roomNo);
	Map<String,Object> selectInviteInfo(Map<String,String> inviteInfo);
	
	
	ChattingRoom passwordCheck(Map<String,String> roomInfo);
	String insertChattingRoom(ChattingRoom room);
	int insertInviteEmpAndUpdate(Map<String,Object> inviteInsertInfo);
	
	int deleteChatRoomInfoByRoomNo(List<String> roomList);
}

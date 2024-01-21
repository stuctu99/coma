package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface MessengerDao {
	List<Emp> selectEmpListAll(SqlSession session);
	List<Dept> selectDept(SqlSession session);
	List<ChattingRoom> selectRoomList(SqlSession session);
	List<ChattingJoin> selectMyJoinRoomById(SqlSession session, String loginId);
	String selectNowCreateChatRoomNo(SqlSession session);
	List<ChattingRoom> selectChatRoomListByType(SqlSession session, Map<String,String> searchInfo);
	List<ChattingPrivateRoom> selectPrivateChatJoinInfo(SqlSession session, String loginId);
	String selectRecentChattingMessageByRoomNo(SqlSession session, String roomNo);
	Emp selectEmpByTargetId(SqlSession session, String targetId);
	String selectPasswordFlagByRoomNo(SqlSession session, String roomNo);
	
	ChattingRoom passwordCheck(SqlSession session, Map<String,String> roomInfo);
	int insertChattingRoom(SqlSession session, ChattingRoom room);
	int insertInviteEmp(SqlSession session, Map<String,Object> inviteInsertInfo);
	
	int deleteChatRoomInfoByRoomNo(SqlSession session, List<String> roomList);
}

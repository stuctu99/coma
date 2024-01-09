package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

public interface ChattingDao {
	ChattingJoin selectCheckJoin(SqlSession session, Map<String, String> joinInfo);
	List<ChattingJoin> selectRoomMemberList(SqlSession session, String roomNo);
	List<ChattingMessage> selectChatMessageByRoomNo(SqlSession session, String roomNo);
	ChattingRoom selectRoomByRoomNo(SqlSession session, String roomNo);
	Emp selectEmpByEmpId(SqlSession session, String empId);
	
	int insertJoinEmp(SqlSession session, Map<String, String> joinInfo);
	
	int insertChattingMessage(SqlSession session, List<ChattingMessage> msgPackages);
	 
	/* int insertChattingMessage(SqlSession session, ChattingMessage msg); */
	int deleteChatRoomJoinEmpById(SqlSession session, Map<String,String> data);
}

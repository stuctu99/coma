package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ChattingJoin;

public interface ChattingDao {
	ChattingJoin selectCheckJoin(SqlSession session, Map<String, String> joinInfo);
	List<ChattingJoin> selectRoomMemberList(SqlSession session, String roomNo);
	
	int insertJoinEmp(SqlSession session, Map<String, String> joinInfo);
	
	int deleteChatRoomJoinEmpById(SqlSession session, Map<String,String> data);
}

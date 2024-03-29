package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface ChattingDao {
	ChattingJoin selectCheckJoin(SqlSession session, Map<String, String> joinInfo);
	List<Emp> selectRoomMemberList(SqlSession session, String roomNo);
	List<ChattingMessage> selectChatMessageByRoomNo(SqlSession session, String roomNo);
	ChattingRoom selectRoomByRoomNo(SqlSession session, String roomNo);
	Emp selectEmpByEmpId(SqlSession session, String empId);
	ChattingJoin selectJoinCheckByEmpId(SqlSession session, Map<String,String> joinEmp);
	int selectMemberCountInRoom(SqlSession session, String roomNo);
	List<Emp> selectInviteList(SqlSession session, String roomNo);
	List<Dept> selectDept(SqlSession session);
	
	int insertJoinEmp(SqlSession session, Map<String, String> joinInfo);
	
	int insertChattingMessage(SqlSession session, List<ChattingMessage> msgPackages);
	 
	
	int updateChatNewJoin(SqlSession session, Map<String,String> newEmpCheck);
	
	/* int insertChattingMessage(SqlSession session, ChattingMessage msg); */
	int deleteChatRoomJoinEmpById(SqlSession session, Map<String,String> exitEmp);
	int deleteChattingMsgByRoomNo(SqlSession session, Map<String,String> exitEmp);
}

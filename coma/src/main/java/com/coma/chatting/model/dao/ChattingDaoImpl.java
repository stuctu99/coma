package com.coma.chatting.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	@Override
	public ChattingJoin selectCheckJoin(SqlSession session, Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		ChattingJoin data = session.selectOne("chatting.selectCheckJoin",joinInfo);
		return data;
	}
	
	@Override
	public List<Emp> selectRoomMemberList(SqlSession session, String roomNo) {
		return session.selectList("chatting.selectRoomMemberList",roomNo);
	}
	
	@Override
	public List<ChattingMessage> selectChatMessageByRoomNo(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectChatMessageByRoomNo",roomNo);
	}
	
	@Override
	public ChattingRoom selectRoomByRoomNo(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRoomByRoomNo",roomNo);
	}
	
	@Override
	public Emp selectEmpByEmpId(SqlSession session, String empId) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectEmpByEmpId",empId);
	}

	@Override
	public ChattingJoin selectJoinCheckByEmpId(SqlSession session, Map<String, String> joinEmp) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectJoinCheckByEmpId",joinEmp);
	}

	@Override
	public int insertJoinEmp(SqlSession session, Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		return session.insert("chatting.insertJoinEmp",joinInfo);
	}

	@Override
	public int insertChattingMessage(SqlSession session, List<ChattingMessage> msgPackages) {
		// TODO Auto-generated method stub
		int result = 0;
//		for(ChattingMessage msg : msgPackages) {
//			result = session.insert("chatting.insertChattingMessage",msg);
//		}
		
		return session.insert("chatting.insertChattingMessage",msgPackages);
	}


//	채팅방 신규 접속 여부 Flag Update
	@Override
	public int updateChatNewJoin(SqlSession session, Map<String, String> newEmpCheck) {
		// TODO Auto-generated method stub
		return session.update("chatting.updateChatNewJoin",newEmpCheck);
	}
	

	
//	채팅방 나가기 로직
	
	@Override
	public int deleteChatRoomJoinEmpById(SqlSession session, Map<String, String> exitEmp) {
		// TODO Auto-generated method stub
		return session.delete("chatting.deleteChatRoomJoinEmpById",exitEmp);
	}
	

	@Override
	public int selectMemberCountInRoom(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectMemberCountInRoom",roomNo);
	}

	@Override
	@Transactional
	public int deleteChattingMsgByRoomNo(SqlSession session, Map<String, String> exitEmp) {
		int result = session.delete("chatting.deleteChattingMsgByRoomNo",exitEmp);
		List<String> roomNo = List.of(exitEmp.get("roomNo"));
		result = session.delete("chatting.deleteChattingRoom",roomNo);
		return result;
	}

	

	

	
	
	

	
}

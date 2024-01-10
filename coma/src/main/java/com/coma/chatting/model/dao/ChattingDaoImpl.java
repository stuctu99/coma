package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
		System.out.println("DAO 데이터 확인 : "+data);
		return data;
	}
	
	@Override
	public List<ChattingJoin> selectRoomMemberList(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
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

//	@Override
//	public int insertChattingMessage(SqlSession session, ChattingMessage msg) {
//		// TODO Auto-generated method stub
//		return session.insert("chatting.insertChattingMessage",msg);
//	}
	
	@Override
	public int updateChatNewJoin(SqlSession session, Map<String, String> newEmpCheck) {
		// TODO Auto-generated method stub
		return session.update("chatting.updateChatNewJoin",newEmpCheck);
	}
	

	@Override
	public int deleteChatRoomJoinEmpById(SqlSession session, Map<String, String> exitEmp) {
		// TODO Auto-generated method stub
		return session.delete("chatting.deleteChatRoomJoinEmpById",exitEmp);
	}

	@Override
	public int deleteChattingMsgByRoomNoAndEmpId(SqlSession session, Map<String, String> exitEmp) {
		// TODO Auto-generated method stub
		return session.delete("chatting.deleteChattingMsgByRoomNoAndEmpId",exitEmp);
	}

	

	

	
	
	

	
}
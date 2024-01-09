package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.chatting.model.dao.ChattingDao;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChattingServiceImpl implements ChattingService {
	private final ChattingDao dao;
	private final SqlSession session;
	
	@Override
	public ChattingJoin selectCheckJoin(Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		return dao.selectCheckJoin(session, joinInfo);
	}
	@Override
	public List<ChattingJoin> selectRoomMemberList(String roomNo) {
		// TODO Auto-generated method stub
		return dao.selectRoomMemberList(session, roomNo);
	}
	
	@Override
	public List<ChattingMessage> selectChatMessageByRoomNo(String roomNo) {
		// TODO Auto-generated method stub
		return dao.selectChatMessageByRoomNo(session, roomNo);
	}
	
	@Override
	public ChattingRoom selectRoomByRoomNo(String roomNo) {
		// TODO Auto-generated method stub
		return dao.selectRoomByRoomNo(session, roomNo);
	}
	
	@Override
	public Emp selectEmpByEmpId(String empId) {
		// TODO Auto-generated method stub
		return dao.selectEmpByEmpId(session, empId);
	}
	
	@Override
	@Transactional
	public int insertJoinEmp(Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		return dao.insertJoinEmp(session, joinInfo);
	}
	
	
	@Override
	@Transactional
	public int insertChattingMessage(List<ChattingMessage> msgPackages) {
		// TODO Auto-generated method stub
		return dao.insertChattingMessage(session, msgPackages);
	}
//	@Override
//	public int insertChattingMessage(ChattingMessage msg) {
//		// TODO Auto-generated method stub
//		return dao.insertChattingMessage(session, msg);
//	}
	
	
	
	@Override
	@Transactional
	public int deleteChatRoomJoinEmpById(Map<String, String> data) {
		// TODO Auto-generated method stub
		return dao.deleteChatRoomJoinEmpById(session, data);
	}

	

}

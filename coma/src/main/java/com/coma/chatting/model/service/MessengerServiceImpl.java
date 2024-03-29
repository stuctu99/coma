package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.coma.chatting.model.dao.MessengerDao;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingPrivateRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessengerServiceImpl implements MessengerService {
	private final MessengerDao dao;
	private final SqlSession session;
	
	@Override
	public List<Emp> selectEmpListAll() {
		// TODO Auto-generated method stub
		return dao.selectEmpListAll(session);
	}
	
	@Override
	public List<Dept> selectDept() {
		// TODO Auto-generated method stub
		return dao.selectDept(session);
	}


	@Override
	public List<ChattingRoom> selectRoomList() {
		// TODO Auto-generated method stub
		return dao.selectRoomList(session);
	}
	
	@Override
	public List<ChattingRoom> selectChatRoomList(Map<String,String> searchInfo) {
		// TODO Auto-generated method stub
		return dao.selectChatRoomList(session, searchInfo);
	}
	
	@Override
	public List<ChattingJoin> selectMyJoinRoomById(String loginId) {
		// TODO Auto-generated method stub
		return dao.selectMyJoinRoomById(session, loginId);
	}
	
	@Override
	public List<ChattingPrivateRoom> selectPrivateChatJoinInfo(String loginId) {
		// TODO Auto-generated method stub
		return dao.selectPrivateChatJoinInfo(session, loginId);
	}
	
	@Override
	public String selectRecentChattingMessageByRoomNo(String roomNo) {
		// TODO Auto-generated method stub
		return dao.selectRecentChattingMessageByRoomNo(session, roomNo);
	}
	
	@Override
	public Emp selectEmpByTargetId(String targetId) {
		// TODO Auto-generated method stub
		return dao.selectEmpByTargetId(session,targetId);
	}
	
	@Override
	public ChattingRoom selectRoomByRoomNo(String roomNo) {
		// TODO Auto-generated method stub
		return dao.selectRoomByRoomNo(session, roomNo);
	}

	@Override
	public Map<String, Object> selectInviteInfo(Map<String, String> inviteInfo) {
		// TODO Auto-generated method stub
		return dao.selectInviteInfo(session, inviteInfo);
	}
	
	
	@Override
	@Transactional
	public String insertChattingRoom(ChattingRoom room) {
		// TODO Auto-generated method stub
		return dao.insertChattingRoom(session, room);
	}
	
	@Override
	public int insertInviteEmpAndUpdate(Map<String,Object> inviteInsertInfo) {
		// TODO Auto-generated method stub
		return dao.insertInviteEmpAndUpdate(session, inviteInsertInfo);
	}
	
	

	@Override
	@Transactional
	public ChattingRoom passwordCheck(Map<String, String> roomInfo) {
		// TODO Auto-generated method stub
		return dao.passwordCheck(session, roomInfo);
	}

	@Override
	public int deleteChatRoomInfoByRoomNo(List<String> roomList) {
		// TODO Auto-generated method stub
		return dao.deleteChatRoomInfoByRoomNo(session, roomList);
	}

}

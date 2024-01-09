package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.chatting.model.dao.MessengerDao;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingRoom;
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
	public int insertChattingRoom(ChattingRoom room) {
		// TODO Auto-generated method stub
		return dao.insertChattingRoom(session, room);
	}

	@Override
	public ChattingRoom passwordCheck(Map<String, String> roomInfo) {
		// TODO Auto-generated method stub
		return dao.passwordCheck(session, roomInfo);
	}


	


}

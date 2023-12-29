package com.coma.chatting.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.chatting.model.dao.ChattingDao;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChattingServiceImpl implements ChattingService {
	private final ChattingDao dao;
	private final SqlSession session;
	
	@Override
	public List<Emp> selectEmpListAll() {
		// TODO Auto-generated method stub
		return dao.selectEmpListAll(session);
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



}

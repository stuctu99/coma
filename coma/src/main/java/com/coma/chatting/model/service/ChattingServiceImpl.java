package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.chatting.model.dao.ChattingDao;
import com.coma.model.dto.ChattingJoin;

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
	public int insertJoinEmp(Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		return dao.insertJoinEmp(session, joinInfo);
	}

}

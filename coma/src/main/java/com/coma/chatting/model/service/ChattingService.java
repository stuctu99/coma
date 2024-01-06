package com.coma.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ChattingJoin;

public interface ChattingService {
	ChattingJoin selectCheckJoin(Map<String,String> joinInfo);
	List<ChattingJoin> selectRoomMemberList(String roomNo);
	
	int insertJoinEmp(Map<String,String> joinInfo);
}

package com.coma.chatting.model.service;

import java.util.List;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

public interface ChattingService {
	List<Emp> selectEmpListAll();
	List<ChattingRoom> selectRoomList();
	int insertChattingRoom(ChattingRoom room);
}

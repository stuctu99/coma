package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

public interface MessengerDao {
	List<Emp> selectEmpListAll(SqlSession session);
	List<Dept> selectDept(SqlSession session);
	List<ChattingRoom> selectRoomList(SqlSession session);
	int insertChattingRoom(SqlSession session, ChattingRoom room);
	ChattingRoom passwordCheck(SqlSession session, Map<String,String> roomInfo);
	
}

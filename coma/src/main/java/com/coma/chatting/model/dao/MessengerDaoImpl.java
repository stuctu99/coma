package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Dept;
import com.coma.model.dto.Emp;

@Repository
public class MessengerDaoImpl implements MessengerDao {
//	select
	@Override
	public List<Emp> selectEmpListAll(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("emp.selectEmpAllforChatting");
	}
	
	@Override
	public List<Dept> selectDept(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("emp.selectDeptListforChatting");
	}

	@Override
	public List<ChattingRoom> selectRoomList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectRoomList");
	}

	@Override
	public ChattingRoom passwordCheck(SqlSession session, Map<String, String> roomInfo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRoomPasswordCheck",roomInfo);
	}

	// insert
	@Override
	public int insertChattingRoom(SqlSession session, ChattingRoom room) {
		// TODO Auto-generated method stub
		System.out.println(room);
		return session.insert("chatting.insertCreateRoom", room);
	}

//	update

//	delete

}

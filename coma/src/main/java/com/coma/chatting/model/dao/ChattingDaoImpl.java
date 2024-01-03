package com.coma.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.Emp;

@Repository
public class ChattingDaoImpl implements ChattingDao {
//	select
	@Override	
	public List<Emp> selectEmpListAll(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("emp.selectEmpAll");
	}
	
	@Override
	public List<ChattingRoom> selectRoomList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectRoomList");
	}

//	insert
	@Override
	public int insertChattingRoom(SqlSession session, ChattingRoom room) {
		// TODO Auto-generated method stub
		System.out.println(room);
		return session.insert("chatting.insertCreateRoom",room);
	}
	
//	update
	
//	delete

}

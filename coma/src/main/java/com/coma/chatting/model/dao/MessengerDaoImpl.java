package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coma.model.dto.ChattingJoin;
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
	

	@Override
	public List<ChattingRoom> selectChatRoomListByType(SqlSession session, String type) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectChatRoomListByType",type);
	}

	// insert
	@Override
	@Transactional
	public int insertChattingRoom(SqlSession session, ChattingRoom room) {
		// TODO Auto-generated method stub
		int result = session.insert("chatting.insertCreateRoom", room);
		if(result>0) {
			Map<String,String> creator = Map.of("empId",room.getEmpId());
			result = session.insert("chatting.insertJoinEmp",creator);
		}
		return result;
	}

//	update

//	delete

}

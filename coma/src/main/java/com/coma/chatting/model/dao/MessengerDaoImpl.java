package com.coma.chatting.model.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
	public List<String> selectMyJoinRoomById(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectMyJoinRoomById", loginId);
	}

	@Override
	public String selectNowCreateChatRoomNo(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectNowCreateChatRoomNo");
	}

	@Override
	public ChattingRoom passwordCheck(SqlSession session, Map<String, String> roomInfo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRoomPasswordCheck", roomInfo);
	}

	@Override
	public List<ChattingRoom> selectChatRoomListByType(SqlSession session, String type) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectChatRoomListByType", type);
	}

	// insert
	@Override
	@Transactional
	public int insertChattingRoom(SqlSession session, ChattingRoom room) {
		// TODO Auto-generated method stub
		int result = session.insert("chatting.insertCreateRoom", room);
		if (result > 0) {
			Map<String, String> creator = Map.of("empId", room.getEmpId());
			/*
			 * Collection<String> values =creator.values(); List<String> idList = new
			 * ArrayList<>(values);
			 */
			result = session.insert("chatting.insertJoinEmp", creator);

		}
		return result;
	}
	//	update
	
	//	delete
	@Override
	public int deleteChatRoomInfoByRoomNo(SqlSession session, List<String> roomList) {
		
		session.delete("chatting.deleteChattingMessage",roomList);
		session.delete("chatting.deleteChattingRoomMember",roomList);
			
		return session.delete("chatting.deleteChattingRoom",roomList);
	}

}

package com.coma.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.ChattingPrivateRoom;
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
	public List<ChattingJoin> selectMyJoinRoomById(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectMyJoinRoomById", loginId);
	}

	@Override
	public ChattingRoom passwordCheck(SqlSession session, Map<String, String> roomInfo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRoomPasswordCheck", roomInfo);
	}

	@Override
	public List<ChattingRoom> selectChatRoomList(SqlSession session, Map<String, String> searchInfo) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectChatRoomList", searchInfo);
	}

	@Override
	public List<ChattingPrivateRoom> selectPrivateChatJoinInfo(SqlSession session, String loginId) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectPrivateChatJoinInfo", loginId);
	}

	@Override
	public String selectRecentChattingMessageByRoomNo(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRecentChattingMessageByRoomNo", roomNo);
	}

	@Override
	public Emp selectEmpByTargetId(SqlSession session, String targetId) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectEmpByTargetId", targetId);
	}
	
	@Override
	public ChattingRoom selectRoomByRoomNo(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectOne("chatting.selectRoomByRoomNo",roomNo);
	}	
	
	@Override
	@Transactional
	public Map<String, Object> selectInviteInfo(SqlSession session, Map<String, String> inviteInfo) {
		ChattingRoom room = session.selectOne("chatting.selectRoomByRoomNo",inviteInfo.get("roomNo"));
		Emp emp = session.selectOne("chatting.selectEmpByEmpId", inviteInfo.get("sendId"));
		Map<String,Object> roomData = new HashMap<String,Object>();
		roomData.put("room",room);
		roomData.put("emp",emp);
		return roomData;
	}

	// insert
	@Override
	@Transactional
	public String insertChattingRoom(SqlSession session, ChattingRoom room) {
		String roomNo = null;
		int result = session.insert("chatting.insertCreateRoom", room);
		if (result > 0) {
			Map<String, String> joiner = room.getIdList();
			result = session.insert("chatting.insertJoinEmp", joiner);
			roomNo = session.selectOne("chatting.selectNowCreateChatRoomNo");

		}
		return roomNo;
	}

	@Override
	@Transactional
	public int insertInviteEmpAndUpdate(SqlSession session, Map<String, Object> inviteInsertInfo) {
		int result = 0;
		if (((ChattingRoom)inviteInsertInfo.get("room")).getInviteEmp().length!=0) {
			result = session.insert("chatting.insertInviteEmp", inviteInsertInfo);
			if (result > 0) {
				result = session.update("chatting.updateRoomByRoomNo", (ChattingRoom) inviteInsertInfo.get("room"));
			}
		} else {
			result = session.update("chatting.updateRoomByRoomNo", (ChattingRoom) inviteInsertInfo.get("room"));
		}
		return result;
	}

	// update

	// delete
	@Override
	public int deleteChatRoomInfoByRoomNo(SqlSession session, List<String> roomList) {

		session.delete("chatting.deleteChattingMessage", roomList);
		session.delete("chatting.deleteChattingRoomMember", roomList);

		return session.delete("chatting.deleteChattingRoom", roomList);
	}

}
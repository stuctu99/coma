package com.coma.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.ChattingJoin;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	@Override
	public ChattingJoin selectCheckJoin(SqlSession session, Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		ChattingJoin data = session.selectOne("chatting.selectCheckJoin",joinInfo);
		System.out.println("DAO 데이터 확인 : "+data);
		return data;
	}
	
	@Override
	public List<ChattingJoin> selectRoomMemberList(SqlSession session, String roomNo) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectRoomMemberList",roomNo);
	}

	@Override
	public int insertJoinEmp(SqlSession session, Map<String, String> joinInfo) {
		// TODO Auto-generated method stub
		return session.insert("chatting.insertJoinEmp",joinInfo);
	}

}

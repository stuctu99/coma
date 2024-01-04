package com.coma.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Override
	public List<Board> selectNoticeAll(SqlSession session) {
		return session.selectList("board.selectNoticeAll");
	}

	@Override
	public List<Board> selectFreeAll(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("board.selectFreeAll");
	}

	@Override
	public List<Board> selectBoarAll(SqlSession session, String boardType) {
		// TODO Auto-generated method stub
		return session.selectList("board.selectBoardAll");
	}

	@Override
	public Board selectBoardByNo(SqlSession session, String boardType, int boardNo) {
		// TODO Auto-generated method stub
		return session.selectOne("board.selectBoardByNo");
	}
	
	

}

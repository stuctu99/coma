package com.coma.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Override
	public List<Board> selectBoardByType(SqlSession session,Map<String, Integer> page, int boardType) {
		int cPage=page.get("cPage");
		int numPerpage=page.get("numPerpage");
		RowBounds rb = new RowBounds((cPage-1)*numPerpage,numPerpage);
		
		return session.selectList("board.selectBoardByType", boardType,rb);
	}

	@Override
	public Board selectBoardByNo(SqlSession session, int boardNo) {
		// TODO Auto-generated method stub
		return session.selectOne("board.selectBoardByNo", boardNo);
	}

	@Override
	public int insertBoard(SqlSession session, Board b) {
		// TODO Auto-generated method stub
		return session.insert("board.insertBoard",b);
	}

	@Override
	public int selectBoardCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("board.selectBoardCount");
	}

	
	

}

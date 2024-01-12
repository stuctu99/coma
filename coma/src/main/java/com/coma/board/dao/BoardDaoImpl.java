package com.coma.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.coma.model.dto.Board;
import com.coma.model.dto.Reply;

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
	public int selectBoardCount(SqlSession session, int boardType) {
		// TODO Auto-generated method stub
		return session.selectOne("board.selectBoardCount", boardType);
	}

	@Override
	public int deleteBoard(SqlSession session, Map<String, Integer> board) {
		// TODO Auto-generated method stub
		return session.delete("board.deleteBoard",board);
	}

	@Override
	public List<Reply> selectReplyByBoard(SqlSession session, int boardNo) {
		// TODO Auto-generated method stub
		return session.selectList("reply.selectReplyByBoard", boardNo);
	}

	@Override
	public Board updateBoardCount(SqlSession session, int boardNo) {
		// TODO Auto-generated method stub
		return session.selectOne("board.updateBoardCount", boardNo);
	}

	@Override
	public int insertReplyByBoard(SqlSession session, Map<String, Object> reply) {
		// TODO Auto-generated method stub
		return session.insert("reply.insertReplyByBoard", reply);
	}

	@Override
	public List<Reply> selectReplyCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("board.selectReplyCount");
	}

	@Override
	public int updateBoard(SqlSession session, Map<String, Object> board) {
		// TODO Auto-generated method stub
		return session.update("board.updateBoard",board);
	}
	
	
	
	
	
	

}

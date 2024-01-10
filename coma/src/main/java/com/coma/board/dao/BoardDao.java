package com.coma.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Board;
import com.coma.model.dto.Reply;

public interface BoardDao {
	
	List<Board> selectBoardByType(SqlSession session, Map<String, Integer> page,int BoardType);
	
	Board selectBoardByNo(SqlSession session, int boardNo);
	
	int insertBoard(SqlSession session, Board b);
	
	int selectBoardCount(SqlSession session, int boardType);
	
	int deleteBoard(SqlSession session, Map<String, Integer> board);
	
	List<Reply> selectReplyByBoard(SqlSession session, int boardNo);
	
	Board updateBoardCount(SqlSession session, int boardNo);
	
	int insertReplyByBoard(SqlSession session, Map<String,Object> reply);
	
	List<Reply> selectReplyCount(SqlSession session);
}

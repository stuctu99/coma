package com.coma.board.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.Board;
import com.coma.model.dto.Reply;

public interface BoardService {
	//board관련
	List<Board> selectBoardByType(Map<String, Integer> page, int boardType);
	
	Board selectBoardByNo(int boardNo);
	
	int insertBoard(Board b);
	
	int selectBoardCount(int boardType);
	
	int updateBoard(Map<String, Object> board);
	
	int deleteBoard(Map<String, Integer> board);

	Board updateBoardCount(int boardNo);
	
	//reply관련
	List<Reply> selectReplyByBoard(int boardNo);
	
	int insertReplyByBoard(Map<String, Object> reply);
	
	List<Board> selectReplyCount(Map<String, Integer> page, int boardType);
	
	List<Board> searchBoard(Map<String, Object> board);
}

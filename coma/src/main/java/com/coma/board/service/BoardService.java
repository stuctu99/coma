package com.coma.board.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.Board;
import com.coma.model.dto.Reply;

public interface BoardService {

	List<Board> selectBoardByType(Map<String, Integer> page, int boardType);
	
	Board selectBoardByNo(int boardNo);
	
	int insertBoard(Board b);
	
	int selectBoardCount(int boardType);
	
	int updateBoard(Board b);
	
	int deleteBoard(Map<String, Integer> board);

	List<Reply> selectReplyByBoard(int boardNo);
}

package com.coma.board.service;

import java.util.List;

import com.coma.model.dto.Board;

public interface BoardService {
	
	List<Board> selectBoardByType(int boardType);
	
	Board selectBoardByNo(int boardNo);
	

}

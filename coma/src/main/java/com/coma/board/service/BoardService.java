package com.coma.board.service;

import java.util.List;

import com.coma.model.dto.Board;

public interface BoardService {
	
	List<Board> selectNoticeAll();
	
	List<Board> selectFreeAll();
}

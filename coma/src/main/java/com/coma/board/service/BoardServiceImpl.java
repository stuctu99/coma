package com.coma.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.board.dao.BoardDao;
import com.coma.model.dto.Board;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardDao dao;
	private final SqlSession session;
	
	@Override
	public List<Board> selectBoardByType(int boardType) {
		// TODO Auto-generated method stub
		return dao.selectBoardByType(session, boardType);
	}


	@Override
	public Board selectBoardByNo(int boardNo) {
		// TODO Auto-generated method stub
		return dao.selectBoardByNo(session, boardNo);
	}


}

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
	public List<Board> selectNoticeAll() {
		// TODO Auto-generated method stub
		return dao.selectNoticeAll(session);
	}

	@Override
	public List<Board> selectFreeAll() {
		// TODO Auto-generated method stub
		return dao.selectFreeAll(session);
	}

	@Override
	public List<Board> selectBoardAll(String boardType) {
		// TODO Auto-generated method stub
		return dao.selectBoarAll(session, boardType);
	}
	
	

}

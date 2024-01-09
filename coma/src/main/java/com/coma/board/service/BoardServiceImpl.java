package com.coma.board.service;

import java.util.List;
import java.util.Map;

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
	public List<Board> selectBoardByType(Map<String, Integer> page,int boardType) {
		// TODO Auto-generated method stub
		return dao.selectBoardByType(session, page, boardType);
	}


	@Override
	public Board selectBoardByNo(int boardNo) {
		// TODO Auto-generated method stub
		return dao.selectBoardByNo(session, boardNo);
	}


	@Override
	public int insertBoard(Board b) {
		// TODO Auto-generated method stub
		return dao.insertBoard(session, b);
	}

	 
	@Override
	public int selectBoardCount() {
		// TODO Auto-generated method stub
		return dao.selectBoardCount(session);
	}


	@Override
	public int updateBoard(Board b) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}

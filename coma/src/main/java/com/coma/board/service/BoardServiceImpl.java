package com.coma.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.board.dao.BoardDao;
import com.coma.model.dto.Board;
import com.coma.model.dto.Reply;

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
	public int selectBoardCount(int boardType) {
		// TODO Auto-generated method stub
		return dao.selectBoardCount(session, boardType);
	}


	@Override
	public int updateBoard(Board b) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoard(Map<String, Integer> board) {
		// TODO Auto-generated method stub
		return dao.deleteBoard(session, board);
	}


	@Override
	public List<Reply> selectReplyByBoard(int boardNo) {
		// TODO Auto-generated method stub
		return dao.selectReplyByBoard(session, boardNo);
	}


	@Override
	public Board updateBoardCount(int boardNo) {
		// TODO Auto-generated method stub
		return dao.updateBoardCount(session, boardNo);
	}


	@Override
	public int insertReplyByBoard(Map<String, Object> reply) {
		// TODO Auto-generated method stub
		return dao.insertReplyByBoard(session, reply);
	}


	@Override
	public List<Reply> selectReplyCount() {
		// TODO Auto-generated method stub
		return dao.selectReplyCount(session);
	}
	
	

}

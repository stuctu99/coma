package com.coma.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public int insertBoard(Board b) {
		
		int result=dao.insertBoard(session, b);
		
		if(result>0) {
			if(b.getBoardFile()!=null && b.getBoardFile().size()>0) {
				b.getBoardFile().forEach(file->{
					int fileresult = dao.insertBoardFile(session, file);
					if(fileresult==0) throw new RuntimeException("등록실패");
				});
			}
		}else {
			throw new RuntimeException("등록실패");
		}
		
		return result;
	}

	 
	@Override
	public int selectBoardCount(int boardType) {
		// TODO Auto-generated method stub
		return dao.selectBoardCount(session, boardType);
	}


	@Override
	public int updateBoard(Map<String, Object> board) {
		// TODO Auto-generated method stub
		return dao.updateBoard(session, board);
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
	public List<Board> selectReplyCount(Map<String, Integer> page, int boardType) {
		// TODO Auto-generated method stub
		return dao.selectReplyCount(session, page, boardType);
	}


	@Override
	public List<Board> searchBoard(Map<String, Object> board) {
		// TODO Auto-generated method stub
		return dao.searchBoard(session, board);
	}


	@Override
	public int deleteReply(int replyNo) {
		// TODO Auto-generated method stub
		return dao.deleteReply(session, replyNo);
	}


	@Override
	public int checkDelete(List<Integer> ids) {
		// TODO Auto-generated method stub
		return dao.checkDelete(session, ids);
	}
	
	

}

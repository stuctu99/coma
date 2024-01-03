package com.coma.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.coma.model.dto.Board;

public interface BoardDao {
	
	List<Board> selectNoticeAll(SqlSession session);
	
	List<Board> selectFreeAll(SqlSession session);
}

package com.coma.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.coma.board.service.BoardService;
import com.coma.model.dto.Board;

import lombok.RequiredArgsConstructor;

@RequestMapping("/board")
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService service;
	
	@GetMapping("/noticelist")
	public void selectNoticeAll(Model m){
		List<Board> notices = service.selectNoticeAll();
		
		m.addAttribute("notices", notices);
	}
	
	@GetMapping("/freelist")
	public void selectFreeAll(Model m) {
		
		List<Board> frees = service.selectFreeAll();
		
		m.addAttribute("frees", frees);
	}
	
	@GetMapping("/list")
	public void selectBoardList(@RequestParam("boardType") String boardType, Model m){
		List<Board> boards = new ArrayList<>();
		
//		if(boardType!=null && boardType.equals("공지")) {
//			boards = service.selectNoticeAll();
//		}else if(boardType!=null && boardType.equals("자유")) {
//			boards = service.selectFreeAll();
//		}
		
		boards = service.selectBoardAll(boardType);
		
		
		m.addAttribute("boards", boards);
		
	}
	
	@GetMapping("/detail")
	public String selectBoardByNo(@RequestParam("boardNo") int boardNo, String boardType, Model m) {
		Board b = service.selectBoardByNo(boardType, boardNo);
		
		m.addAttribute("board", b);
		System.out.println(b);
		return "detail";
		
	}
	
//	@GetMapping("/post")
//	public void selectBoardByNo(Model m) {
//		
//	}
	
//	@GetPost("/insert")
//	public void insertBoard
//	
//	@GetPost("/update")
//	public void updateBoard
//	
//	@GetPost("/delete")
//	public void deleteBoard
//	
	
	
	
}

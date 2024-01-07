package com.coma.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	//타입으로 분류해서 BoardList model에추가
	@GetMapping({"/freelist", "/noticelist"})
	public void selectBoardAll(@RequestParam(required = false, defaultValue="0") int boardType, Model m){
	        List<Board> boards = service.selectBoardByType(boardType);
	        m.addAttribute("boards", boards);
	        
	        List<Board> mainNotice = boards.stream().limit(5).collect(Collectors.toList());
	        m.addAttribute("mainNotice", mainNotice);  
	}
	
	@GetMapping("/freePost")
	public void selectPost(@RequestParam int boardNo, Model m) {
	        Board post = service.selectBoardByNo(boardNo);
	        m.addAttribute("post", post);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	@GetMapping("/noticePost")
//	public void detailBoard(@RequestParam("boardType") String boardType, @RequestParam("boardNo") int boardNo, Model model) {
//		Board b = service.selectBoardByNo(boardType, boardNo);
//		
//		Board.builder().boardType(boardType).boardNo(boardNo).build();
//		
//		model.addAttribute("board",b);
//	}
	
//	@GetMapping("/freelist")
//	public void selectFreeAll(Model m) {
//		
//		List<Board> frees = service.selectFreeAll();
//		
//		m.addAttribute("frees", frees);
//	}
	
//	@GetMapping("/list")
//	public void selectBoardList(@RequestParam("boardType") String boardType, Model m){
//		List<Board> boards = new ArrayList<>();
//		
////		if(boardType!=null && boardType.equals("공지")) {
////			boards = service.selectNoticeAll();
////		}else if(boardType!=null && boardType.equals("자유")) {
////			boards = service.selectFreeAll();
////		}
//		
//		boards = service.selectBoardAll(boardType);
//		
//		
//		m.addAttribute("boards", boards);
//		
//	}
	
//	@GetMapping("/detail")
//	public void selectBoardByNo(@RequestParam("boardNo") int boardNo, Model m) {
//		List<Board> b = new ArrayList<>(); 
//				
//		b =service.selectBoardByNo(boardNo);
//		
//		m.addAttribute("boards", )
//		
//	}
	
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

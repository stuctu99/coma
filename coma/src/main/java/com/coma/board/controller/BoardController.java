package com.coma.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.coma.board.service.BoardService;
import com.coma.model.dto.Board;

import jakarta.servlet.http.HttpSession;
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
	          
	}
	
	//글상세화면메소드
	@GetMapping("/freePost")
	public void selectPost(@RequestParam int boardNo, Model m) {
	        Board post = service.selectBoardByNo(boardNo);
	        m.addAttribute("post", post);
	}
	
//	//글쓰기처리메소드
//	@PostMapping("/writePost")
//	public String insertPost(Board b) {
//		
//		int result = service.insertBoard(b);
//		
//		return "/redirect";
//	}
	

	
	@PostMapping("writePost")
	public String uploadImg(Board b, Model m, MultipartFile upFile, HttpSession session) {
		
		int result = service.insertBoard(b);
		String msg, loc;
		if(result>0) {
			msg="등록성공";
			loc="/freelist";
		}else {
			msg="등록실패";
			loc="/freelist";
		}
		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);
		
		
		//파일업로드 경로
		String path = session.getServletContext().getRealPath("/resources/upload/board");
		
		
		
		if(upFile!=null) {
			if(!upFile.isEmpty()) {
				String oriName = upFile.getOriginalFilename();
				String ext = oriName.substring(oriName.lastIndexOf("."));
				Date today = new Date(System.currentTimeMillis());
				int randomNum = (int)(Math.random()*10000)+1;
				String rename = "COMA"+"_"+ new SimpleDateFormat("yyyyMMddHHmmssSSS")
								.format(today)+"_"+randomNum+ext;
				try {
					upFile.transferTo(new File(path,rename));
				}catch(IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		
		return "redirect:/freelist";
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

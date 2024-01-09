package com.coma.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.coma.board.service.BoardService;
import com.coma.common.pagefactory.PageFactory;
import com.coma.model.dto.Board;
import com.coma.model.dto.Emp;
import com.coma.model.dto.Reply;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/board")
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService service;
	private final PageFactory pageFactory;
	
	//타입으로 분류해서 BoardList model에추가
	@GetMapping("/noticelist")
	public void selectBoardNotice(	@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "10") int numPerpage,
								@RequestParam(required = false, defaultValue="0") int boardType, Model m){
	        List<Board> boards = service.selectBoardByType(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
	        
	        int totalData=service.selectBoardCount(boardType);
	        
	        m.addAttribute("notices", boards);
	        m.addAttribute("pageBarNotice", pageFactory.getPage(cPage, numPerpage, totalData, "noticelist"));
	        m.addAttribute("totalData", totalData);
	}
	
	@GetMapping("/freelist")
	public void selectBoardFree(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "5") int numPerpage,
			@RequestParam(required = false, defaultValue="1") int boardType, Model m){
		List<Board> boards = service.selectBoardByType(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
				
		
		int totalData=service.selectBoardCount(boardType);
		
		m.addAttribute("frees", boards);
		m.addAttribute("pageBarFree", pageFactory.getPage(cPage, numPerpage, totalData, "freelist"));
		m.addAttribute("totalData", totalData);
	}
	
	//글상세화면메소드
	@GetMapping("/freePost")
	public void selectPost(@RequestParam int boardNo, Model m) {
	        Board post = service.selectBoardByNo(boardNo);
	        List<Reply> reply = service.selectReplyByBoard(boardNo);
	        m.addAttribute("post", post);
	        m.addAttribute("reply", reply);
	}

	@PostMapping("/writePost")
	public String uploadImg(String title, String writer, String contenttest, Model m, MultipartFile upFile, HttpSession session) {
		
		Board b=    Board.builder().boardTitle(title)
					.emp(Emp.builder()
							.empId(writer)
							.build())
					.boardContent(contenttest)
					.build();
		
		System.out.println(b);
		
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
	
	
	@PostMapping("/update")
	public String updatePost(Board b) {
		
		int result = service.updateBoard(b);
		String path = null;
		
		if(b.getBoardType()==0) {
			path = "redirect:/noticelist";
		}else if(b.getBoardType()==1) {
			path = "redirect:/freelist";
		}
		
		return path;
	}
	
	@GetMapping("/delete")
	public String deletePost(int boardNo, int boardType) {
		String path = null;
		
		Map<String, Integer> board = new HashMap<>();
		board.put("boardNo", boardNo);
		board.put("boardType", boardType);
		
		service.deleteBoard(board);
		
		if(boardType==0) {
			 path = "redirect:/board/noticelist";
		}else if(boardType==1) {
			 path = "redirect:/board/freelist";
		}
		
		return path;
		
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

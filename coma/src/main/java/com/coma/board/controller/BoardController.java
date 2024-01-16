package com.coma.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//공지사항리스트
	//타입으로 분류해서 BoardList model에추가
	@GetMapping("/noticelist")
	public void selectBoardNotice(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "10") int numPerpage,
								  @RequestParam(required = false, defaultValue="0") int boardType, Model m){
		
		//Type이 0(공지)인 게시글 List타입으로 가져오기+페이징처리
		List<Board> boards = service.selectBoardByType(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
	    
		//Type이 0(공지)인 게시글 총 갯수
	    int totalData=service.selectBoardCount(boardType);
	    
	    
	    //공지 List로 model에 저장
	    m.addAttribute("notices", boards);
	    //공지 페이지바 model에저장
	    m.addAttribute("pageBarNotice", pageFactory.getPage(cPage, numPerpage, totalData, "noticelist"));
	    //공지 총글갯수 model에저장
	    m.addAttribute("totalData", totalData);
	        
	}
	
	//자유게시판리스트
	@GetMapping("/freelist")
	public void selectBoardFree(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "20") int numPerpage,
								@RequestParam(required = false, defaultValue="1") int boardType, Model m){
		
		//Type이 1(자유)인 게시글 List타입으로 가져오기+페이징처리
		List<Board> boards = service.selectReplyCount(Map.of("cPage", cPage, "numPerpage", numPerpage),boardType);
		
		//Type이 1(자유)인 게시글 총 갯수
		int totalData=service.selectBoardCount(boardType);
		
		//자유게시글 List로 model에 저장
		m.addAttribute("frees", boards);
		//자유 페이지바 model에 저장
		m.addAttribute("pageBarFree", pageFactory.getPage(cPage, numPerpage, totalData, "freelist"));
		//자유 총글갯수 model에 저장
		m.addAttribute("totalData", totalData);
		
		m.addAttribute("type", boardType);
	}  
	
	//글상세화면
	@GetMapping("/freePost")
	public void selectPost(@RequestParam int boardNo, Model m) {
		
			//조회수
			service.updateBoardCount(boardNo);
			//글불러오기
			Board post = service.selectBoardByNo(boardNo);
	        //댓글불러오기
			List<Reply> reply = service.selectReplyByBoard(boardNo);
			
	        
	        m.addAttribute("post", post);
	        m.addAttribute("reply", reply);
	        
	}
	
	//댓글작성
	@PostMapping("/writeReply")
	public String insertReplyByBoard(@RequestParam int boardNo, @RequestParam String replyContent) {
	
		Map<String, Object> reply = new HashMap<>();
				
		reply.put("boardNo", boardNo);
		reply.put("replyContent", replyContent);
		
		service.insertReplyByBoard(reply);
		

		return "redirect:/board/freePost?boardNo="+boardNo;
	}

	@GetMapping("/writeView")
	public String WriteView(int boardType, Model m) {
		
		m.addAttribute("boardType", boardType);
		
		return "board/writePost";
	}
	
	
	//글작성(완료버튼눌렀을때)
	@PostMapping("/writePost")
	public String writePost(String title, String writer, String content, int boardType, Model m) {
		
		   
		Board b =	Board.builder().boardTitle(title)
					.emp(Emp.builder()
							.empId(writer)
							.build())
					.boardContent(content)
					.boardType(boardType)
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
		
		String path=null;
		
		if(b.getBoardType()==0) {
			path = "redirect:/board/noticelist";
		}else if(b.getBoardType()==1) {
			path = "redirect:/board/freelist";
		}
		
		
		
		return path;
	}
	
	//글작성-ck에디터이미지업로드
	@PostMapping("/ckFile")
	@ResponseBody
	public ResponseEntity<Map> ckFile(MultipartFile upload, HttpSession session) {
		
		//파일업로드 경로
		String path = session.getServletContext().getRealPath("/resource/upload/board");
		if(upload!=null) {
			if(!upload.isEmpty()) {
				String oriName = upload.getOriginalFilename();
				String ext = oriName.substring(oriName.lastIndexOf("."));
				Date today = new Date(System.currentTimeMillis());
				int randomNum = (int)(Math.random()*10000)+1;
				String rename = "board_"+"COMA"+"_"+ (new SimpleDateFormat("yyyyMMddHHmmssSSS")
						.format(today))+"_"+randomNum+ext;
				try {
					upload.transferTo(new File(path,rename));
					return ResponseEntity.status(HttpStatus.OK).body(Map.of("url","/resource/upload/board/"+rename));
				}catch(IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error","파일업로드실패"));
	}
	
	//글수정이동
	@GetMapping("/updatePost")
	public String updatePost(int boardNo, Model m) {
		
		Board post = service.selectBoardByNo(boardNo);
		
		System.out.println(post);
		
		m.addAttribute("post", post);
		
		return "board/updatePost";
	}
	
	//글수정
	@PostMapping("/update")
	public String updatePost(int boardNo, String title, String content) {
		
		Map<String, Object> board = new HashMap<>();
		board.put("boardTitle", title);
		board.put("boardContent", content);
		board.put("boardNo", boardNo);
		
		System.out.println(board);
		
		service.updateBoard(board);
		
		String path = null;
		
		path = "redirect:/board/freePost?boardNo="+boardNo;

		return path;
	}
	
	//글삭제
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
	
	//글검색
	@PostMapping("/search")
	@ResponseBody
	public ResponseEntity<List<Board>> searchPost(@RequestParam("search-type")String type, @RequestParam("search-keyword")String keyword,
							@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "10") int numPerpage,
							 @RequestParam(defaultValue="0", name= "boardType") int boardType, Model m) {
		

		Map<String, Object> board = new HashMap<>();
		board.put("type", type);
		board.put("keyword", keyword);
		board.put("boardType", boardType);
		board.put("cPage", cPage);
		board.put("numPerpage", numPerpage);
		
		List<Board> searchBoard = service.searchBoard(board);
//		int totalData = service.getSearchResultCount(board);
		
		
		return ResponseEntity.ok(searchBoard);
	}
	
	
}

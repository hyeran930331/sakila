package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.BoardService;
import com.gd.sakila.service.CommentService;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.BoardForm;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class BoardController {
	@Autowired
	BoardService boardService;

	@GetMapping("/modifyBoard")
	public String modifyBoard(Model model, @RequestParam(value="boardId", required=true) int boardId) {
		//getMapping 의 return type = 문자열 (뷰)
		System.out.println("▷▷▷▷▷▷ get modify : "+boardId); //slf4j.log 로 쓰임. 대문자 아님
		Map<String, Object> map = boardService.getBoardOne(boardId);
		model.addAttribute("boardMap", map.get("boardMap"));
		return "modifyBoard"; //jsp로 이동
	}
	@PostMapping("/modifyBoard")
	public String modifyBoard(Board board) {
		int row = boardService.modifyBoard(board);
		System.out.println("▷▷▷▷▷ post modify: "+row);
		if(row == 0) { //만약 보드서비스에서 모디파이 한 값이 0 이라면, 
			return "redirect:/admin/getBoardOne?boardId="+board.getBoardId(); //보드원 값으로
		}
		System.out.println("▷▷▷▷▷▷ post modify 끝");
		return "redirect:/admin/getBoardList"; // row가 0이 아니라면, 보드리스트로
	}
	
	@GetMapping("/removeBoard")
	public String removeBoard(Model model, @RequestParam(value="boardId", required=true) int boardId) {
		//getMapping 의 return type = 문자열 (뷰)
		System.out.println("▷▷▷▷▷ get remove : "+boardId);
		model.addAttribute("boardId",boardId);
		return "removeBoard"; //jsp로 이동
	}
	@PostMapping("/removeBoard")
	public String removeBoard(Board board) {
		System.out.println("▷▷▷▷▷ post remove : "+ board.toString());
		int row = boardService.removeBoard(board);
		System.out.println("▷▷▷▷▷ removeBoard(): "+row);
		if(row == 0) {
			return "redirect:/admin/getBoardOne?boardId="+board.getBoardId();
		}
		System.out.println("▷▷▷▷▷▷ post remove 끝");
		return "redirect:/admin/getBoardList";
	}

	@GetMapping("/addBoard")
	public String addBoard() { //동일한 매핑 - 오버로딩 get post
		return "addBoard"; 
	}
	@PostMapping("/addBoard")
	public String addBoard(BoardForm boardForm) { //커멘드객체 폼 밸유오브젝트vs도메인
		System.out.println("▷▷▷▷▷ Post addboard : "+boardForm.toString());
		boardService.addBoard(boardForm); //board에서 boardForm으로 바꿈 -> service
		System.out.println("▷▷▷▷▷▷ post add 끝");
		return "redirect:/admin/getBoardList";//리턴타입이 redirect: 이면 sendredirect로 처리
		//retrun "view"는 view를 보여주는것
		//return "redirect:/view"는 view주소로 url 요청을 다시하는것
	}
	
	@GetMapping("/getBoardOne")
	public String getBoardOne(Model model, @RequestParam(value="boardId", required=true) int boardId) {
		Map<String, Object> map = boardService.getBoardOne(boardId);
		System.out.println("▷▷▷▷▷ get boardOne : "+map);
		//log.debug("commentList size() : "+map.get("commentLsit").size()));
		model.addAttribute("boardMap", map.get("boardMap"));
		model.addAttribute("commentList", map.get("commentList"));
		model.addAttribute("boardTotal", map.get("boardTotal"));
		return "getBoardOne";
	}

	@GetMapping("/getBoardList")
	public String getBoardList(Model model
								, @RequestParam(value="currentPage", defaultValue="1") int currentPage
								, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
								, @RequestParam(value="searchWord", required = false) String searchWord
								) {
		System.out.println(currentPage+"<--currentPage");
		System.out.println(rowPerPage+"<--rowPerPage");
		System.out.println(searchWord+"<--searchWord");
		
		Map <String, Object> map = boardService.getBoardList(currentPage, rowPerPage, searchWord);
		//model.addAttribute를 이용해서, 넘길 데이터의 이름과 값을 넣는다. 그러면, 스프링은 그 값을 뷰쪽으로 넘겨준다.
		model.addAttribute("currentPage",currentPage); 
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("boardlist", map.get("boardList"));
		
		return "getBoardList";
	}
}

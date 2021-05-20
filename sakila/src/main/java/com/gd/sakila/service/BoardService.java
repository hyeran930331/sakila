package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.BoardMapper;
import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.Comment;
import com.gd.sakila.vo.Page;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional //try catch, 자동 rollback
public class BoardService {
	@Autowired	BoardMapper boardMapper;
	@Autowired CommentMapper commentMapper;
	
	public int modifyBoard(Board board){
		log.debug("▶▶▶▶▶▶ modifyBoard param: "+ board.toString());
		return boardMapper.updateBoard(board);
	}
	
	//삭제
	public int removeBoard(Board board) {
		log.debug("▶▶▶▶▶▶ removeBoard param: "+ board.toString());
		//게시글 삭제
		int boardRow = boardMapper.deleteBoard(board);
		
		if (boardRow == 0) {
			return 0; // 강제 종료.
		}
		// 게시글 삭제가 있으면, 댓글삭제 (board_id 외래키 noAction)
		int commentRow = commentMapper.deleteCommentByBoard(board.getBoardId()); //게시글삭제시
		log.debug("▶▶▶▶▶▶ removeBoard commentMapper: "+ commentRow);

		/* board_id 외래키 CasCast
		if (boardRow == 0) {
			//강제로 예외(try, catch를 강제안하는 오류)를 발생시켜, @Transactional에 걸러서 rollback 되도록
			throw new RuntimeException(); 
		}
		*/
		log.debug("▶▶▶▶▶▶removeBoard deleteBoard: "+ boardRow);
		return commentRow+boardRow;
	}
	
	public int addBoard(Board board) {
		log.debug("▶▶▶▶▶▶addBoard param: "+ board.toString());
		return boardMapper.insertBoard(board);
	}
	
	//상세보기+댓글목록
	public Map<String, Object> getBoardOne(int boardId){
		log.debug("▶▶▶▶▶▶ getBoardOne param: "+ boardId);
		//상세보기
		Map<String, Object> boardMap = boardMapper.selectBoardOne(boardId);
		log.debug("▶▶▶▶▶▶ boardMap: "+ boardMap);
		//댓글목록
		List<Comment> commentList = commentMapper.selectCommentListByBoard(boardId);
	    log.debug("commentList size() : "+ commentList.size());

	    int boardTotal = boardMapper.selectBoardTotal(null);
	    		
	    Map<String, Object> map = new HashMap<>();
	      map.put("boardMap", boardMap);
	      map.put("commentList", commentList);
	      map.put("boardTotal", boardTotal);
	      return map;
	}
	
	
	public Map<String, Object> getBoardList(int currentPage, int rowPerPage, String searchWord) {
		//1 전체갯수 구하기 (feat.검색어)
		int boardTotal = boardMapper.selectBoardTotal(searchWord); // searchWord
		/*
		int lastPage = boardTotal / rowPerPage;
		if(boardTotal % rowPerPage != 0) {
			lastPage++;
		}
		*/
		int lastPage = (int)(Math.ceil((double)boardTotal / rowPerPage));
		
		//2 페이징
		Page page = new Page();
		page.setBeginRow((currentPage-1)*rowPerPage);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		List<Board> boardList = boardMapper.selectBoardList(page); // Page
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lastPage", lastPage);
		map.put("boardList", boardList);
		return map;
	}
}
package com.gd.sakila.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.CommentService;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class CommentController {
	@Autowired CommentService commentService;
	
	@PostMapping("/addComment") //get은 없음
	public String addComment(Comment comment) {
		log.debug("ⓒCommentControllerⓒ post addComment : " +comment);
		int row = commentService.addComment(comment);
		log.debug("ⓒCommentControllerⓒ post addComment :" + row);
		return "redirect:/admin/getBoardOne?boardId="+comment.getBoardId(); 
		//어떻게 다시 돌아오지? +로 ㅎㅎ
	}
	
	@PostMapping("/removeComment")
	public String removeComment(@RequestParam(value="boardId", required = true) int boardId,
								@RequestParam(value="commentId", required = true) int commentId) {
		log.debug("ⓒCommentControllerⓒ post removeComment : boardId : " +boardId);
		int row = commentService.removeCommentByCommentId(commentId);
		log.debug("ⓒCommentControllerⓒ post removeComment : " + row);
		return "redirect:/admin/getBoardOne?boardId="+boardId; 
		//얘때문에 comment로 받아야하네
	}
}

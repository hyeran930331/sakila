package com.gd.sakila.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.sakila.service.CommentService;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class CommentController {
	CommentService commentService;
	
	@PostMapping("/addComment") //get은 없음
	public String addComment(Comment comment) {
		log.debug("ⓒⓒⓒⓒⓒⓒ post addComment : " +comment.toString());
		int row = commentService.addComment(comment);
		log.debug("ⓒⓒⓒⓒⓒⓒ post addComment :" + row);
		return "redirect:/admin/getBoardOne?boardId="+comment.getBoardId(); //어떻게 다시 돌아오지? +로 ㅎㅎ
	}
}

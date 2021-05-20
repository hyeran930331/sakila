package com.gd.sakila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional //try catch, 자동 rollback
public class CommentService {
	@Autowired CommentMapper commentMapper;

	public int addComment(Comment comment) {
		// TODO Auto-generated method stub
		log.debug("▶▶▶▶▶▶addComment param: "+ comment.toString());
		return commentMapper.insertComment(comment); //int return은 만들지 않아서 인가? (5:47)
	}
}

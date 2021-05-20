package com.gd.sakila.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Comment;

@Mapper
public interface CommentMapper { //class아니구~ interface! -> xml
	List<Comment> selectCommentListByBoard (int boardId);
	int deleteCommentByBoard (int boardId); //게시글삭제시
	int deleteCommentByCommentId (int commentId); //댓글삭제
	int insertComment(Comment coment);
}

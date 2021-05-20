package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Comment {
	private int commentId;
	private int boardId;
	private int staffId;
	private String content;
	private String insertDate;
}

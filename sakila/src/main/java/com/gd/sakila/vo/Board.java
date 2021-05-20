package com.gd.sakila.vo;

import lombok.Data;

@Data //allargument
public class Board {
	private int boardId;
	private String boardTitle;
	private String boardContent;
	private String boardPw;
	private String lastUpdate;
	private int staffId;
	private String insertDate;
}

package com.gd.sakila.vo;

import lombok.Data;

@Data
public class FilmCategory {
	//외래키 private int filmId;
	//private Film filmId;
	private Film[] film;
	//외래키 private int categoryId;	
	private Category categoryId;
	private String lastUpdate;
	
}
/* 입력시 필요한 vo 를 따로 구현해야하나,
class FilmCategory{
	private Film film;
	private int CategoryId;
}
*/

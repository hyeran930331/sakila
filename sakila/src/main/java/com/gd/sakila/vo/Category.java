package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Category {
	private int categoryId;
	private int filmId;
	private String lastUpdate;
}

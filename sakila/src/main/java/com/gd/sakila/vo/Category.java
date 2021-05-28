package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Category {
	private int categoryId;
	private String name;
	private int filmId;
	private String lastUpdate;
}

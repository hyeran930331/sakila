package com.gd.sakila.vo;

import lombok.Data;

@Data
public class Film {
	private int filmId;
	private String title;
	private String description;
	private String releaseYear;
	private int rentalDuration;
	private int rentalRate;
	private int length;
	private int replacementCost;
	private String rating; //enum인데?
	private String specialFeatures;
	private String actors;
	private String category;
}

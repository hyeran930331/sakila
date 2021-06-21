package com.gd.sakila.vo;

import java.util.List;
import java.util.Set;

import lombok.Data;

@Data
public class FilmForm {
	private Film film;
	private Category category;
	private String lastUpdate;
	private List<String> specialFeatures;
	/* "Trailers","Commentaries","Deleted Scenes","Behind the Scenes"*/

	
	public void setSpecialFeatures(Set<String> specialFeatures) {
		if(specialFeatures != null) {
			StringBuffer sb = new StringBuffer(); //String은 데이터가 변형이 안됨.
			for(String sf : specialFeatures) {
				sb.append(sf+", ");
			}
			this.film.setSpecialFeatures(sb.toString().substring(0, sb.toString().length()-1));
		}
	}
}

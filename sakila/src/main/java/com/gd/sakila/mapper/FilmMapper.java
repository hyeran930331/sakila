package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Category;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.FilmForm;

@Mapper
public interface FilmMapper {
	int insertFilmCategory(Map<String, Object> map);
	
	int insertFilm(Film film);
	
	List<Integer> selectStoreForCount();
	List<Integer> selectFilmInStock(int filmId, int storeId, int count);

	int selectStaffListForCount(Map<String, Object> map);

	List<Map<String, Object>> selectFilmList(Map<String, Object> map);
	
	Map<String, Object> selectFilmOneForFilmId(int filmId); //4
	Map<String, Object> selectFilmOneForTitle(String title);
	List<Map<String, Object>> selectFilmActorListByFilm(int filmId); //6
	int deleteFilmActor(int filmId);
	int insertFilmActor(Map<String, Object> paramMap);
	
	int updateFilm(Film film);
	int updateFilmCategory (Map<String,Object> map);
}
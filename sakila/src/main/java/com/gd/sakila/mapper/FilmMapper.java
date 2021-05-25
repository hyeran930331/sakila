package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FilmMapper {
	List<Integer> selectStoreForCount();
	List<Integer> selectFilmInStock(int FID, int storeId, int count);

	int selectStaffListForCount(Map<String, Object> map);

	List<Map<String, Object>> selectFilmList(Map<String, Object> map);
	
	Map<String, Object> selectFilmOne(int FID);
}
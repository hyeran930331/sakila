package com.gd.sakila.service;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentalMapper {
	int insertRental(Map<String,Object> map);

	int updateRental(Map<String, Object> paramMap);
}

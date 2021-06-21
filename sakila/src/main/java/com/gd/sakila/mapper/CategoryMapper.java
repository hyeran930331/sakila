package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Category;

@Mapper
public interface CategoryMapper {
	List<Category> selectCategoryList();
}

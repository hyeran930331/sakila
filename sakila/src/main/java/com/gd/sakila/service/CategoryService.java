package com.gd.sakila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CategoryMapper;
import com.gd.sakila.vo.Category;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class CategoryService {
	@Autowired CategoryMapper cetegoryMapper;
	public List<Category> getCategoryList(){
		return cetegoryMapper.selectCategoryList();
	}
}

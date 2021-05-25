package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CategoryMapper;
import com.gd.sakila.mapper.FilmMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	@Autowired CategoryMapper categoryMapper;
	
	public Map<String, Object> getFilmList(int currentPage, int rowPerPage, String category, Double price, String searchTitle, String searchActor, String rating) {
		log.debug("ⓢFilmServiceⓢ param확인 category :"+ category);
		
		//선택하지 않고 검색했을때 버그수정
		if(category != null && category.equals("")) {
			category = null;
		}
		if(price != null && price == 0) {
			price = null;
		}	
		
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		
		paramMap.put("category", category);
		paramMap.put("price", price);
		paramMap.put("searchTitle", searchTitle);
		paramMap.put("searchActor", searchActor);
		paramMap.put("rating", rating);
		
		List<Map<String, Object>> filmList = filmMapper.selectFilmList(paramMap);
		log.debug("ⓢFilmServiceⓢ filmMapper.selectFilmList :"+ filmList.toString());
		
		List<String> categoryList = categoryMapper.selectCategoryNameList();
		log.debug("ⓢFilmServiceⓢ categoryMapper.selectCategoryNameList :"+ categoryList.toString());
			
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("filmList", filmList);
		returnMap.put("categoryList", categoryList);
		
		return returnMap;
	}
	
	//Map <- film , 재고량 filmCount
	public Map<String, Object> getFilmOne(int FID){
		log.debug("ⓢFilmServiceⓢ getFilmOne() param FID:"+FID);
		//Map<String, Object> paramMap = new HashMap<String, Object>();
		//paramMap.put("FID", FID);
		//paramMap.put("storeId", storeId);
		//int filmCount = 0;
		//paramMap.put("filmCount", filmCount);
		//log.debug("ⓢFilmServiceⓢ getFilmOne() paramMap:"+paramMap.toString());
		
		//int store1 = filmMapper.selectFilmInStock(FID,1,"count").size();
		//int store2 = filmMapper.selectFilmInStock(FID,2,"count").size();
		//log.debug("ⓢFilmServiceⓢ getFilmOne() selectFilmInStock store1 :"+store1);
		//log.debug("ⓢFilmServiceⓢ getFilmOne() selectFilmInStock store2 :"+store2);
		//log.debug("ⓢFilmServiceⓢ getFilmOne() selectFilmInStock:"+paramMap.get("filmCount"));
		
		
		Map<String, Object> filmList = filmMapper.selectFilmOne(FID);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		//returnMap.put("store1", store1);
		//returnMap.put("store2", store2);
		returnMap.put("filmList", filmList);
		return returnMap;
	}
}

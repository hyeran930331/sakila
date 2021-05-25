package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CategoryMapper;
import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	@Autowired CategoryMapper categoryMapper;
	
	//Map <- film , 재고량 filmCount
	public Map<String, Object> getFilmOne(int filmId, int storeId){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("filmId", filmId);
		paramMap.put("storeId", storeId);
		int filmCount = 0;
		paramMap.put("filmCount", filmCount);
		log.debug("ⓢFilmServiceⓢ getFilmOne() paramMap:"+paramMap.toString());
		
		List<Integer> list = filmMapper.selectFilmInStock(paramMap);
		log.debug("ⓢFilmServiceⓢ getFilmOne() selectFilmInStock:"+list.toString());
		log.debug("ⓢFilmServiceⓢ getFilmOne() selectFilmInStock:"+paramMap.get("filmCount"));
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		return returnMap;
	}

	public HashMap<String, Object> getFilmList(String categoryName, int currentPage, int rowPerPage, String searchWord) {
		log.debug("ⓢFilmServiceⓢ getFilmList() param categoryName:"+categoryName); 
		log.debug("ⓢFilmServiceⓢ getFilmList() param rowPerPage:"+rowPerPage); 
		int total = filmMapper.selectStaffListForCount(searchWord);
		
		int lastPage= (int)(Math.ceil((double)total / rowPerPage));
		log.debug("ⓢFilmServiceⓢ getFilmList() param total, lastPage:"+rowPerPage); 
		//Page page = null; "com.gd.sakila.vo.Page.setBeginRow(int)" because "page" is null
		Page page = new Page();
		page.setBeginRow( (currentPage-1)*rowPerPage );
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		
		List<Film> filmList = filmMapper.selectFilmList(page);
		List<String> categoryList = categoryMapper.selectCategoryNameList();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("lastPage", lastPage);
		map.put("filmList", filmList);
		map.put("categoryList", categoryList);
		return map; //6:03... 헝헝 map is null 이라구...
	}
}

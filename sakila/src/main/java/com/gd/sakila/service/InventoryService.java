package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.InventoryMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class InventoryService {
	@Autowired InventoryMapper inventoryMapper;
	
	public Map<String,Object> selectInventory(Map<String,Object>paramMap) {
		log.debug("2 서비스 시작 paramMap 확인 : "+ paramMap.toString());
		int total = inventoryMapper.selectInventoryTotal();
		int lastPage = (int)(Math.ceil(total/(int)paramMap.get("rowPerPage")));		
		int beginRow = ( ( (int)(paramMap.get("currentPage")) -1) * (int)(paramMap.get("rowPerPage")) );
		
		Map<String,Object> map = new HashMap <String,Object>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", paramMap.get("rowPerPage"));
		map.put("title", paramMap.get("title"));
		map.put("inventoryId", paramMap.get("inventoryId"));
		log.debug("3 mapper로 줄 param : " +map.toString());
		
		List<Map<String,Object>> inventoryList = inventoryMapper.selectInventoryList(map);
		log.debug("4 콘트롤러로 보낼 list: "+ inventoryList);
		
		Map<String,Object> resultMap = new HashMap <String,Object>();
		resultMap.put("inventoryList", inventoryList);
		resultMap.put("lastPage",lastPage);
		
		return resultMap;
	}
}

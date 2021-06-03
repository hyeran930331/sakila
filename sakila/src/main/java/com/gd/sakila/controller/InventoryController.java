package com.gd.sakila.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.InventoryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class InventoryController {
	@Autowired InventoryService inventoryService;
	
	@GetMapping("/getInventoryList")
	public String getInventoryList(Model model
								, @RequestParam(value="currentPage", defaultValue = "1") int currentPage
								, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
								, @RequestParam(value="title", required=false) String title
								, @RequestParam(value="inventoryId", required=false) Integer inventoryId) {
		log.debug("0 getInventoryList Param 확인 : currentPage "+ currentPage);
		log.debug("0 getInventoryList Param 확인 : rowPerPage "+ rowPerPage);
		log.debug("0 getInventoryList Param 확인 : title "+ title);
		log.debug("0 getInventoryList Param 확인 : inventoryId "+ inventoryId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("currentPage",currentPage);
		map.put("rowPerPage",rowPerPage);
		map.put("title",title);
		map.put("inventoryId",inventoryId);
		
		log.debug("1 서비스에 줄 param : "+map.toString());
		
		Map<String,Object> resultMap = inventoryService.selectInventory(map);
		log.debug("6 서비스에 받은 map 확인 : "+ resultMap.toString());
		
		model.addAttribute("inventoryList", resultMap.get("inventoryList"));
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("currentPage",currentPage);
		return "getInventoryList";
	}
}

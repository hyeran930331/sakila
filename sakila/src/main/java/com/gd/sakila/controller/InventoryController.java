package com.gd.sakila.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.FilmService;
import com.gd.sakila.service.InventoryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class InventoryController {
	@Autowired InventoryService inventoryService;
	@Autowired FilmService filmService;

	@GetMapping("/addInventory")
	public String addInventory(Model model
								,@RequestParam(value="filmId") Integer filmId) {
		
		log.debug("0 addInventory Param 확인 : filmId "+ filmId);
		log.debug("1 서비스에 줄 param : "+filmId);
		
		Map<String,Object> resultMap = filmService.getFilmOneForFilmId(filmId);
		
		log.debug("6 서비스에 받은 map 확인 : "+ resultMap.toString());
		model.addAttribute("filmList", resultMap.get("filmList"));
		model.addAttribute("FilmInStockStore", resultMap.get("FilmInStockStore"));
		model.addAttribute("filmId", filmId);
		model.addAttribute("lastPage", resultMap.get("inventoryTotal"));
		return "addInventory";
	}
	@PostMapping("/addInventory")
	public String addInventory(Model model
							,@RequestParam(value="filmId") int filmId
							,@RequestParam(value="storeId") int storeId
							,@RequestParam(value="num") int num) {
		log.debug("0.addInventory 실행 param확인 : "+filmId);
		log.debug("0.addInventory 실행 param확인 : "+storeId);
		log.debug("0.addInventory 실행 param확인 : "+num);
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("filmId", filmId);
		paramMap.put("storeId", storeId);
		paramMap.put("num", num);
		log.debug("1. 서비스로 보낼 paramMap확인 : "+ paramMap.toString());
		
		int cnt = inventoryService.addInventory(paramMap);
		log.debug("5. 서비스애서 받은 cnt확인 : "+ cnt);
		
		return "redirect:/admin/getFilmOne?filmId="+filmId;
	}				
	
	@GetMapping("/getInventoryOne")
	public String getInventoryOne(Model model
								,@RequestParam(value="inventoryId") Integer inventoryId
								, @RequestParam(value="title") String title) {
		log.debug("0 getInventoryList Param 확인 : inventoryId "+ inventoryId);
		log.debug("1 서비스에 줄 param : "+inventoryId);
		
		Map<String,Object> resultMap = inventoryService.getInventoryOne(inventoryId);
		log.debug("6 서비스에서 받은 resultMap 확인 : "+ resultMap.toString());

		model.addAttribute("inventoryId", inventoryId);
		model.addAttribute("currentPage", inventoryId);
		model.addAttribute("lastPage", resultMap.get("inventoryTotal"));
		model.addAttribute("rentalListByInventory", resultMap.get("rentalList"));
		model.addAttribute("storeNum", resultMap.get("storeNum"));
		model.addAttribute("title", title);
		return "getInventoryOne";
	}
	
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
		
		Map<String,Object> resultMap = inventoryService.getInventory(map);
		log.debug("6 서비스에 받은 map 확인 : "+ resultMap.toString());
		
		model.addAttribute("inventoryList", resultMap.get("inventoryList"));
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("currentPage",currentPage);
		return "getInventoryList";
	}
}

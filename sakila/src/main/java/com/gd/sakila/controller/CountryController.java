package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.service.CountryService;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class CountryController {
	@Autowired private CountryService countryService;
	@Autowired CountryMapper countryMapper;
	
	@GetMapping("/countryList")//
	public String countryList(Model model, 
			@RequestParam(value="currentPage", defaultValue="1") int currentPage, 
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
			//
		Map<String, Object> map = countryService.getCountryList(currentPage, rowPerPage);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("currentPage", currentPage);
		return "countryList";
	}
}

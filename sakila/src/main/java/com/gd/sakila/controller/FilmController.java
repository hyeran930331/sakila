package com.gd.sakila.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.FilmService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin") //공통 매핑추가 post든 get이든~~
public class FilmController {
	@Autowired FilmService filmService;
	
	@GetMapping ("/getFilmList")
	public String getFilmList(Model model
							, @RequestParam(value="currentPage", defaultValue="1") int currentPage
							, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage
							, @RequestParam(value="category", required = false) String category
							, @RequestParam(value="searchWord", required = false) String searchWord) {
		System.out.println(currentPage+"<--currentPage");
		System.out.println(rowPerPage+"<--rowPerPage");
		System.out.println(searchWord+"<--searchWord");
		
		//카테고리를 선택하지 않고 검색했을때 버그수정
		if(category.equals("")) {
			category = null;
		}
		
		HashMap<String,Object> map = filmService.getFilmList(currentPage, rowPerPage, searchWord);
		System.out.println("ⓒFilmControllerⓒ getFilmList 실행"); //성공
		System.out.println("ⓒFilmControllerⓒ getFilmList 값 map.get(filmList) : "+ map.get("filmList").toString());
		System.out.println("ⓒFilmControllerⓒ getFilmList 값 map.get(filmList) : "+ map.get("filmList"));

		model.addAttribute("currentPage",currentPage); 
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("staffList", map.get("filmList"));
		return "getFilmList";
	}
	
	@GetMapping ("/getFilmOne")
	public String getFilmOne() {
		System.out.println("ⓒFilmControllerⓒ getFilmOne 실행");
		filmService.getFilmOne(1, 1);
		return "getFilmOne";
	}
}
